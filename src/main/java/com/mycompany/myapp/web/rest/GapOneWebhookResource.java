package com.mycompany.myapp.web.rest;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.myapp.domain.IntegrationConfig;
import com.mycompany.myapp.repository.IntegrationConfigRepository;
import com.mycompany.myapp.service.partner.GapOneZnsLogService;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.HexFormat;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Webhook delivery notification GapOne — public (?token=).
 * Đăng ký URL: GapOne POST mẫu + {@code X-GapOne-Signature}; cần HTTP 2xx.
 * Chữ ký docs: {@code sha256(client_id + message_id + delivery_channel + timestamp)}.
 */
@RestController
public class GapOneWebhookResource {

    private static final Logger LOG = LoggerFactory.getLogger(GapOneWebhookResource.class);

    private final IntegrationConfigRepository integrationConfigRepository;
    private final ObjectMapper json;
    private final GapOneZnsLogService gapOneZnsLogService;

    public GapOneWebhookResource(
        IntegrationConfigRepository integrationConfigRepository,
        ObjectMapper json,
        GapOneZnsLogService gapOneZnsLogService
    ) {
        this.integrationConfigRepository = integrationConfigRepository;
        this.json = json;
        this.gapOneZnsLogService = gapOneZnsLogService;
    }

    @GetMapping(value = "/api/public/gapone/webhook", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> probe(@RequestParam(value = "token", required = false) String token) {
        if (!tokenOk(token)) {
            return unauthorized("invalid token", null);
        }
        return ok("webhook ready", null);
    }

    @PostMapping(value = "/api/public/gapone/webhook", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Map<String, Object>> delivery(
        @RequestParam(value = "token", required = false) String token,
        @RequestHeader(value = "X-GapOne-Signature", required = false) String signature,
        @RequestBody(required = false) byte[] rawBody
    ) {
        if (!tokenOk(token)) {
            LOG.warn("GapOne webhook rejected: bad/missing token");
            return unauthorized("invalid token", null);
        }
        JsonNode body;
        try {
            body = json.readTree(rawBody == null || rawBody.length == 0 ? "{}".getBytes(StandardCharsets.UTF_8) : rawBody);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("status", 400, "description", "invalid json"));
        }
        String requestId = text(body, "request_id");
        String messageId = text(body, "message_id");
        String channel = text(body, "delivery_channel");
        String timestamp = text(body, "timestamp");

        if (signature != null && !signature.isBlank() && messageId != null) {
            IntegrationConfig cfg = config();
            String clientId = trimToNull(cfg.getGaponeClientId());
            if (clientId == null) {
                // Chưa lưu client_id — vẫn 200 để GapOne chấp nhận URL; nhắc log.
                LOG.warn("GapOne webhook: có chữ ký nhưng chưa lưu gaponeClientId — bỏ qua verify");
            } else if (
                !signatureMatches(signature.trim(), clientId, trimToNull(cfg.getGaponeClientSecret()), messageId, channel, timestamp)
            ) {
                LOG.warn(
                    "GapOne webhook invalid signature messageId={} channel={} tsLen={}",
                    messageId,
                    channel,
                    timestamp == null ? 0 : timestamp.length()
                );
                return unauthorized("invalid signature", requestId);
            }
        }

        String raw = rawBody == null ? "{}" : new String(rawBody, StandardCharsets.UTF_8);
        // Bỏ qua probe đăng ký URL (thiếu message_id / mô tả thật).
        if (messageId != null || (requestId != null && text(body, "delivery_description") != null)) {
            try {
                gapOneZnsLogService.logCallback(body, raw);
            } catch (Exception e) {
                LOG.warn("GapOne webhook persist failed: {}", e.getMessage());
            }
        }
        LOG.info(
            "GapOne DN messageId={} channel={} status={} desc={}",
            messageId,
            channel,
            body.path("delivery_status").asText(null),
            text(body, "delivery_description")
        );
        return ok("delivery notification received", requestId);
    }

    /**
     * Docs: sha256(client_id + message_id + delivery_channel + timestamp).
     * Thử thêm vài biến thể HMAC vì portal ghi "HMAC-SHA256" trong khi công thức là sha256(concat).
     */
    static boolean signatureMatches(
        String signature,
        String clientId,
        String clientSecret,
        String messageId,
        String channel,
        String timestamp
    ) {
        String mid = nullToEmpty(messageId);
        String ch = nullToEmpty(channel);
        String ts = nullToEmpty(timestamp);
        String concat = clientId + mid + ch + ts;
        if (eqHex(signature, sha256Hex(concat))) {
            return true;
        }
        // Một số bản tài liệu gọi nhầm HMAC — thử HMAC-SHA256(key=client_id, data=mid+ch+ts)
        if (eqHex(signature, hmacSha256Hex(clientId, mid + ch + ts))) {
            return true;
        }
        // HMAC-SHA256(key=client_secret, data=concat) nếu đã lưu secret
        if (clientSecret != null && !clientSecret.isBlank() && eqHex(signature, hmacSha256Hex(clientSecret, concat))) {
            return true;
        }
        // Timestamp đôi khi ký với dạng Unicode escape của '+'
        if (timestamp != null && timestamp.contains("+")) {
            String tsEsc = timestamp.replace("+", "\\u002B");
            String concatEsc = clientId + mid + ch + tsEsc;
            if (eqHex(signature, sha256Hex(concatEsc))) {
                return true;
            }
        }
        return false;
    }

    private boolean tokenOk(String token) {
        if (token == null || token.isBlank()) {
            return false;
        }
        String expected = config().getGaponeWebhookToken();
        return expected != null && !expected.isBlank() && expected.equals(token.trim());
    }

    private IntegrationConfig config() {
        return integrationConfigRepository.findAll().stream().findFirst().orElseGet(IntegrationConfig::new);
    }

    private static ResponseEntity<Map<String, Object>> ok(String description, String requestId) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("status", 200);
        body.put("description", description);
        if (requestId != null) {
            body.put("request_id", requestId);
        }
        return ResponseEntity.ok(body);
    }

    private static ResponseEntity<Map<String, Object>> unauthorized(String description, String requestId) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("status", 401);
        body.put("description", description);
        if (requestId != null) {
            body.put("request_id", requestId);
        }
        return ResponseEntity.status(401).body(body);
    }

    private static String text(JsonNode node, String field) {
        JsonNode n = node.get(field);
        if (n == null || n.isNull()) {
            return null;
        }
        String s = n.asText();
        return s == null || s.isBlank() ? null : s;
    }

    private static String trimToNull(String s) {
        if (s == null) {
            return null;
        }
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }

    private static String nullToEmpty(String s) {
        return s == null ? "" : s;
    }

    private static boolean eqHex(String a, String b) {
        return a != null && b != null && a.equalsIgnoreCase(b);
    }

    static String sha256Hex(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] dig = md.digest(input.getBytes(StandardCharsets.UTF_8));
            return HexFormat.of().formatHex(dig);
        } catch (Exception e) {
            throw new IllegalStateException("SHA-256 unavailable", e);
        }
    }

    static String hmacSha256Hex(String key, String data) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA256"));
            return HexFormat.of().formatHex(mac.doFinal(data.getBytes(StandardCharsets.UTF_8)));
        } catch (Exception e) {
            throw new IllegalStateException("HMAC-SHA256 unavailable", e);
        }
    }
}
