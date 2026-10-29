package com.mycompany.myapp.service.partner;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.mycompany.myapp.domain.IntegrationConfig;
import com.mycompany.myapp.repository.IntegrationConfigRepository;
import com.mycompany.myapp.web.rest.errors.BadRequestAlertException;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientResponseException;

/**
 * GapOne Zalo ZNS — OAuth, liệt kê OA, gửi thử A2P (tab Tích hợp).
 * Docs: https://docs.gapone.vn/vi/api-docs
 */
@Service
public class GapOneZnsClient {

    private static final Logger LOG = LoggerFactory.getLogger(GapOneZnsClient.class);
    private static final String ENTITY = "gapone";
    static final String SCOPE = "gateway";
    /** Postman + curl docs dùng /token; OpenAPI tokenUrl ghi /tokens — thử cả hai. */
    private static final String[] TOKEN_URLS = { "https://auth.gapone.vn/token", "https://auth.gapone.vn/tokens" };
    private static final String API_ROOT = "https://api.gapone.vn";
    private static final String A2P_URL = "https://gateway.gapone.vn/a2p-request";

    private final IntegrationConfigRepository integrationConfigRepository;
    private final ObjectMapper json;
    private final RestClient http = RestClient.builder().build();
    private final TransactionTemplate tokenTx;

    public GapOneZnsClient(
        IntegrationConfigRepository integrationConfigRepository,
        ObjectMapper json,
        PlatformTransactionManager transactionManager
    ) {
        this.integrationConfigRepository = integrationConfigRepository;
        this.json = json;
        this.tokenTx = new TransactionTemplate(transactionManager);
        this.tokenTx.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
    }

    /** Làm mới access_token từ client_id / client_secret đã lưu. */
    public void refreshToken() {
        accessToken(true);
    }

    /**
     * Test kết nối: OAuth access_token rồi GET /v1/zns/oas (docs: Bearer hoặc Basic).
     * Không gửi ZNS.
     * @return map gồm oaCount, oas[{oaId, oaName}], authMode
     */
    public Map<String, Object> probe() {
        IntegrationConfig cfg = config();
        requireCreds(cfg);
        String token = accessToken(true);
        try {
            String raw = getOasRaw("Bearer " + token);
            return probeResult(raw, "oauth");
        } catch (RestClientResponseException e) {
            // Docs cho phép BasicAuth trên /v1/zns/oas — thử lại nếu Bearer lỗi.
            if (e.getStatusCode().value() == 401 || e.getStatusCode().value() == 403) {
                try {
                    String raw = getOasRaw("Basic " + basicHeader(cfg));
                    return probeResult(raw, "basic");
                } catch (RestClientResponseException e2) {
                    throw gaponeError(e2);
                } catch (Exception e2) {
                    LOG.warn("GapOne list OA (basic) failed: {}", e2.getMessage());
                    throw new BadRequestAlertException("GapOne không trả danh sách OA", ENTITY, "gaponeOa");
                }
            }
            throw gaponeError(e);
        } catch (BadRequestAlertException e) {
            throw e;
        } catch (Exception e) {
            LOG.warn("GapOne list OA failed: {}", e.getMessage());
            throw new BadRequestAlertException("GapOne không trả danh sách OA", ENTITY, "gaponeOa");
        }
    }

    private Map<String, Object> probeResult(String raw, String authMode) throws Exception {
        List<Map<String, String>> oas = parseOas(raw);
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("oaCount", oas.size());
        out.put("oas", oas);
        out.put("authMode", authMode);
        return out;
    }

    private String getOasRaw(String authorization) {
        return http.get().uri(API_ROOT + "/v1/zns/oas").header("Authorization", authorization).retrieve().body(String.class);
    }

    /**
     * Danh sách template ZNS của OA — GET /v1/zns/oas/{oa_id}/templates.
     * @param oaIdOverride trống thì dùng gapone_oa_id đã lưu
     */
    public Map<String, Object> listTemplates(String oaIdOverride) {
        IntegrationConfig cfg = config();
        requireCreds(cfg);
        String oa = notBlank(oaIdOverride) ? oaIdOverride.trim() : blankToNull(cfg.getGaponeOaId());
        if (oa == null) {
            throw new BadRequestAlertException("Chưa có OA ID — Test kết nối, chọn OA rồi Lưu", ENTITY, "gaponeOaId");
        }
        String token = accessToken(false);
        try {
            String raw = http
                .get()
                .uri(API_ROOT + "/v1/zns/oas/" + oa + "/templates")
                .header("Authorization", "Bearer " + token)
                .retrieve()
                .body(String.class);
            List<Map<String, String>> templates = parseTemplates(raw);
            Map<String, Object> out = new LinkedHashMap<>();
            out.put("oaId", oa);
            out.put("templateCount", templates.size());
            out.put("templates", templates);
            return out;
        } catch (RestClientResponseException e) {
            // Fallback Basic Auth như list OA.
            if (e.getStatusCode().value() == 401 || e.getStatusCode().value() == 403) {
                try {
                    String raw = http
                        .get()
                        .uri(API_ROOT + "/v1/zns/oas/" + oa + "/templates")
                        .header("Authorization", "Basic " + basicHeader(cfg))
                        .retrieve()
                        .body(String.class);
                    List<Map<String, String>> templates = parseTemplates(raw);
                    Map<String, Object> out = new LinkedHashMap<>();
                    out.put("oaId", oa);
                    out.put("templateCount", templates.size());
                    out.put("templates", templates);
                    return out;
                } catch (RestClientResponseException e2) {
                    throw gaponeError(e2);
                } catch (Exception e2) {
                    LOG.warn("GapOne list templates (basic) failed: {}", e2.getMessage());
                    throw new BadRequestAlertException("GapOne không trả danh sách template", ENTITY, "gaponeTemplate");
                }
            }
            throw gaponeError(e);
        } catch (BadRequestAlertException e) {
            throw e;
        } catch (Exception e) {
            LOG.warn("GapOne list templates failed: {}", e.getMessage());
            throw new BadRequestAlertException("GapOne không trả danh sách template", ENTITY, "gaponeTemplate");
        }
    }

    /**
     * Gửi thử 1 tin ZNS từ màn Tích hợp.
     * @param oaIdOverride OA sender; trống thì dùng gapone_oa_id đã lưu
     * @param templateData biến template (có thể null/rỗng)
     */
    public Map<String, Object> sendTestZns(String phone, String templateId, String oaIdOverride, Map<String, Object> templateData) {
        return sendZns(phone, templateId, oaIdOverride, templateData, "cpn-test-" + UUID.randomUUID());
    }

    /**
     * Gửi ZNS (channel=zalo) qua Gateway A2P — dùng chung test + nghiệp vụ Auto Call.
     * @param requestId id duy nhất phía CPN (GapOne echo lại)
     */
    public Map<String, Object> sendZns(
        String phone,
        String templateId,
        String oaIdOverride,
        Map<String, Object> templateData,
        String requestId
    ) {
        IntegrationConfig cfg = config();
        requireCreds(cfg);
        String oa = notBlank(oaIdOverride) ? oaIdOverride.trim() : blankToNull(cfg.getGaponeOaId());
        if (oa == null) {
            throw new BadRequestAlertException("Chưa có OA ID — Test kết nối, chọn OA rồi Lưu", ENTITY, "gaponeOaId");
        }
        String to = normalizePhone(phone);
        if (to == null) {
            throw new BadRequestAlertException("SĐT nhận không hợp lệ (vd 0912345678 hoặc 84912345678)", ENTITY, "gaponePhone");
        }
        if (!notBlank(templateId)) {
            throw new BadRequestAlertException("Nhập template_id ZNS đã duyệt trên GapOne/Zalo", ENTITY, "gaponeTemplate");
        }
        String rid = notBlank(requestId) ? requestId.trim() : "cpn-zns-" + UUID.randomUUID();
        if (rid.length() > 80) {
            rid = rid.substring(0, 80);
        }
        ObjectNode body = json.createObjectNode();
        body.put("request_id", rid);
        ObjectNode message = body.putObject("message");
        message.put("channel", "zalo");
        message.put("from", oa);
        message.put("to", to);
        message.put("template_id", templateId.trim());
        ObjectNode data = message.putObject("template_data");
        if (templateData != null) {
            for (Map.Entry<String, Object> e : templateData.entrySet()) {
                if (e.getKey() == null || e.getKey().isBlank() || e.getValue() == null) {
                    continue;
                }
                Object v = e.getValue();
                if (v instanceof Number n) {
                    data.putPOJO(e.getKey(), n);
                } else if (v instanceof Boolean b) {
                    data.put(e.getKey(), b);
                } else {
                    data.put(e.getKey(), String.valueOf(v));
                }
            }
        }
        String payload = body.toString();
        // Làm mới token mỗi lần gửi — tránh Bearer cũ / client đổi secret.
        String token = accessToken(true);
        try {
            return parseSendResponse(postA2p("Bearer " + token, payload), rid, oa, to, templateId.trim(), "oauth");
        } catch (RestClientResponseException e) {
            if (e.getStatusCode().value() == 401) {
                LOG.warn("GapOne A2P Bearer 401 — xóa token cache, lấy lại rồi thử Basic Auth");
                clearCachedToken();
                try {
                    String fresh = accessToken(true);
                    return parseSendResponse(postA2p("Bearer " + fresh, payload), rid, oa, to, templateId.trim(), "oauth-retry");
                } catch (RestClientResponseException e2) {
                    try {
                        return parseSendResponse(postA2p("Basic " + basicHeader(cfg), payload), rid, oa, to, templateId.trim(), "basic");
                    } catch (RestClientResponseException e3) {
                        throw gaponeSendError(e3);
                    }
                } catch (BadRequestAlertException ex) {
                    try {
                        return parseSendResponse(
                            postA2p("Basic " + basicHeader(config()), payload),
                            rid,
                            oa,
                            to,
                            templateId.trim(),
                            "basic"
                        );
                    } catch (RestClientResponseException e3) {
                        throw gaponeSendError(e3);
                    }
                }
            }
            throw gaponeSendError(e);
        } catch (BadRequestAlertException e) {
            throw e;
        } catch (Exception e) {
            LOG.warn("GapOne send ZNS failed: {}", e.getMessage());
            throw new BadRequestAlertException("Gửi ZNS thất bại", ENTITY, "gaponeSend");
        }
    }

    private String postA2p(String authorization, String payload) {
        return http
            .post()
            .uri(A2P_URL)
            .header("Authorization", authorization)
            .contentType(MediaType.APPLICATION_JSON)
            .body(payload)
            .retrieve()
            .body(String.class);
    }

    private Map<String, Object> parseSendResponse(String raw, String requestId, String oa, String to, String templateId, String authMode) {
        try {
            JsonNode res = json.readTree(raw == null ? "{}" : raw);
            Map<String, Object> out = new LinkedHashMap<>();
            out.put("requestId", requestId);
            out.put("messageId", text(res, "message_id"));
            out.put("oaId", oa);
            out.put("to", to);
            out.put("templateId", templateId);
            out.put("authMode", authMode);
            out.put("raw", raw);
            return out;
        } catch (Exception e) {
            throw new BadRequestAlertException("GapOne trả phản hồi không đọc được", ENTITY, "gaponeSend");
        }
    }

    private void clearCachedToken() {
        tokenTx.executeWithoutResult(status -> {
            IntegrationConfig row = integrationConfigRepository.findAll().stream().findFirst().orElse(null);
            if (row == null) {
                return;
            }
            row.setGaponeAccessToken(null);
            row.setGaponeTokenExpiresAt(null);
            integrationConfigRepository.save(row);
        });
    }

    private BadRequestAlertException gaponeSendError(RestClientResponseException e) {
        String body = e.getResponseBodyAsString();
        LOG.warn("GapOne A2P HTTP {}: {}", e.getStatusCode().value(), body);
        String lower = body == null ? "" : body.toLowerCase();
        if (lower.contains("invalid_client")) {
            return new BadRequestAlertException(
                "GapOne invalid_client — Client ID/Secret sai hoặc app chưa được cấp quyền gửi ZNS. " +
                "Vào Tích hợp → Zalo ZNS: nhập lại Client ID + Secret → Lưu → Test kết nối, rồi gửi thử lại.",
                ENTITY,
                "gaponeInvalidClient"
            );
        }
        if (e.getStatusCode().value() == 402 || lower.contains("not enough balance") || lower.contains("payment required")) {
            return new BadRequestAlertException(
                "GapOne hết số dư (402 not enough balance) — kết nối OK nhưng tài khoản GapOne chưa đủ tiền gửi ZNS. " +
                "Nạp tiền / kiểm tra gói trên app.gapone.vn rồi gửi thử lại.",
                ENTITY,
                "gaponeBalance"
            );
        }
        return gaponeError(e);
    }

    static String normalizePhone(String raw) {
        if (raw == null || raw.isBlank()) {
            return null;
        }
        String d = raw.trim().replaceAll("[^0-9+]", "");
        if (d.startsWith("+")) {
            d = d.substring(1);
        }
        if (d.startsWith("0") && d.length() >= 9) {
            d = "84" + d.substring(1);
        }
        if (d.startsWith("84") && d.length() >= 11 && d.length() <= 12) {
            return d;
        }
        return null;
    }

    private static boolean notBlank(String s) {
        return s != null && !s.isBlank();
    }

    private static String blankToNull(String s) {
        return notBlank(s) ? s.trim() : null;
    }

    String accessToken(boolean force) {
        IntegrationConfig cfg = config();
        requireCreds(cfg);
        Instant exp = cfg.getGaponeTokenExpiresAt();
        if (!force && cfg.getGaponeAccessToken() != null && exp != null && exp.isAfter(Instant.now().plusSeconds(120))) {
            return cfg.getGaponeAccessToken();
        }
        MultiValueMap<String, String> form = new LinkedMultiValueMap<>();
        form.add("grant_type", "client_credentials");
        form.add("scope", SCOPE);
        String basic = basicHeader(cfg);
        RestClientResponseException lastHttp = null;
        Exception lastOther = null;
        for (String tokenUrl : TOKEN_URLS) {
            try {
                String raw = http
                    .post()
                    .uri(tokenUrl)
                    .header("Authorization", "Basic " + basic)
                    .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                    .body(form)
                    .retrieve()
                    .body(String.class);
                JsonNode node = json.readTree(raw == null ? "{}" : raw);
                String token = text(node, "access_token");
                if (token == null || token.isBlank()) {
                    throw new BadRequestAlertException("GapOne không trả access_token", ENTITY, "gaponeToken");
                }
                int seconds = node.path("expires_in").asInt(3600);
                tokenTx.executeWithoutResult(status -> {
                    IntegrationConfig row = integrationConfigRepository.findAll().stream().findFirst().orElseThrow();
                    row.setGaponeAccessToken(token);
                    row.setGaponeTokenExpiresAt(Instant.now().plusSeconds(Math.max(60, seconds - 60)));
                    integrationConfigRepository.save(row);
                });
                return token;
            } catch (BadRequestAlertException e) {
                throw e;
            } catch (RestClientResponseException e) {
                lastHttp = e;
                // 404 → thử URL còn lại (OpenAPI ghi /tokens).
                if (e.getStatusCode().value() == 404) {
                    LOG.info("GapOne token URL {} → 404, thử URL khác", tokenUrl);
                    continue;
                }
                throw gaponeError(e);
            } catch (Exception e) {
                lastOther = e;
                LOG.warn("GapOne token {} failed: {}", tokenUrl, e.getMessage());
            }
        }
        if (lastHttp != null) {
            throw gaponeError(lastHttp);
        }
        LOG.warn("GapOne token failed: {}", lastOther != null ? lastOther.getMessage() : "unknown");
        throw new BadRequestAlertException("Không lấy được token GapOne", ENTITY, "gaponeToken");
    }

    private static String basicHeader(IntegrationConfig cfg) {
        return Base64.getEncoder()
            .encodeToString((cfg.getGaponeClientId().trim() + ":" + cfg.getGaponeClientSecret().trim()).getBytes(StandardCharsets.UTF_8));
    }

    static List<Map<String, String>> parseOas(String raw) throws Exception {
        List<Map<String, String>> out = new ArrayList<>();
        if (raw == null || raw.isBlank()) {
            return out;
        }
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(raw);
        JsonNode arr = root.isArray() ? root : root.path("data");
        if (!arr.isArray()) {
            arr = root.path("oas");
        }
        if (!arr.isArray()) {
            return out;
        }
        for (JsonNode n : arr) {
            String id = firstText(n, "oa_id", "oaId", "id");
            if (id == null || id.isBlank()) {
                continue;
            }
            Map<String, String> row = new LinkedHashMap<>();
            row.put("oaId", id);
            String name = firstText(n, "oa_name", "oaName", "name");
            row.put("oaName", name != null ? name : id);
            out.add(row);
        }
        return out;
    }

    static List<Map<String, String>> parseTemplates(String raw) throws Exception {
        List<Map<String, String>> out = new ArrayList<>();
        if (raw == null || raw.isBlank()) {
            return out;
        }
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(raw);
        JsonNode arr = root.isArray() ? root : root.path("data");
        if (!arr.isArray()) {
            arr = root.path("templates");
        }
        if (!arr.isArray()) {
            return out;
        }
        for (JsonNode n : arr) {
            String id = firstText(n, "template_id", "templateId");
            if (id == null) {
                JsonNode obj = n.get("template_object");
                if (obj != null && !obj.isNull()) {
                    JsonNode tid = obj.get("templateId");
                    if (tid != null && !tid.isNull()) {
                        id = tid.asText();
                    }
                }
            }
            if (id == null || id.isBlank()) {
                continue;
            }
            Map<String, String> row = new LinkedHashMap<>();
            row.put("templateId", id);
            String name = firstText(n, "name", "templateName");
            if (name == null) {
                JsonNode obj = n.get("template_object");
                if (obj != null) {
                    name = firstText(obj, "templateName", "name");
                }
            }
            row.put("name", name != null ? name : id);
            String params = firstText(n, "params");
            if (params == null) {
                JsonNode obj = n.get("template_object");
                if (obj != null && obj.path("listParams").isArray()) {
                    StringBuilder sb = new StringBuilder();
                    for (JsonNode p : obj.path("listParams")) {
                        String pn = firstText(p, "name");
                        if (pn == null) {
                            continue;
                        }
                        if (sb.length() > 0) {
                            sb.append(',');
                        }
                        sb.append(pn);
                    }
                    params = sb.length() > 0 ? sb.toString() : null;
                }
            }
            if (params != null) {
                row.put("params", params);
            }
            String status = null;
            JsonNode obj = n.get("template_object");
            if (obj != null) {
                status = firstText(obj, "status");
            }
            if (status != null) {
                row.put("status", status);
            }
            out.add(row);
        }
        return out;
    }

    private IntegrationConfig config() {
        return integrationConfigRepository.findAll().stream().findFirst().orElseGet(IntegrationConfig::new);
    }

    private static void requireCreds(IntegrationConfig cfg) {
        if (
            cfg.getGaponeClientId() == null ||
            cfg.getGaponeClientId().isBlank() ||
            cfg.getGaponeClientSecret() == null ||
            cfg.getGaponeClientSecret().isBlank()
        ) {
            throw new BadRequestAlertException("Chưa lưu Client ID và Client Secret GapOne (Tích hợp → Zalo ZNS)", ENTITY, "gaponeCreds");
        }
    }

    private static BadRequestAlertException gaponeError(RestClientResponseException e) {
        String body = e.getResponseBodyAsString();
        LOG.warn("GapOne HTTP {}: {}", e.getStatusCode().value(), body);
        if (body != null && body.toLowerCase().contains("invalid_client")) {
            return new BadRequestAlertException(
                "GapOne invalid_client — kiểm tra lại Client ID và Client Secret (Lưu rồi Test kết nối).",
                ENTITY,
                "gaponeInvalidClient"
            );
        }
        String msg = "GapOne từ chối (" + e.getStatusCode().value() + ")";
        if (body != null && !body.isBlank() && body.length() < 300) {
            msg = msg + ": " + body.trim();
        }
        return new BadRequestAlertException(msg, ENTITY, "gaponeHttp");
    }

    private static String text(JsonNode node, String field) {
        JsonNode n = node.get(field);
        if (n == null || n.isNull()) {
            return null;
        }
        String s = n.asText();
        return s == null || s.isBlank() ? null : s;
    }

    private static String firstText(JsonNode node, String... fields) {
        for (String f : fields) {
            String v = text(node, f);
            if (v != null) {
                return v;
            }
        }
        return null;
    }
}
