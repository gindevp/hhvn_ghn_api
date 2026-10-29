package com.mycompany.myapp.service.customer;

import com.mycompany.myapp.domain.IntegrationConfig;
import com.mycompany.myapp.repository.IntegrationConfigRepository;
import com.mycompany.myapp.repository.ShipmentOrderRepository;
import com.mycompany.myapp.service.partner.GapOneZnsClient;
import com.mycompany.myapp.service.partner.GapOneZnsLogService;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.time.Duration;
import java.time.Instant;
import java.util.ArrayDeque;
import java.util.Arrays;
import java.util.Base64;
import java.util.Deque;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

/**
 * Khách đăng nhập web bằng SĐT + OTP (ZNS GapOne). Token khách tách biệt JWT nhân viên:
 * ký HMAC bằng khóa riêng, gửi qua header {@code X-Customer-Token}, không dùng được cho API nội bộ.
 */
@Service
public class CustomerAuthService {

    private static final Logger LOG = LoggerFactory.getLogger(CustomerAuthService.class);

    static final Duration OTP_TTL = Duration.ofMinutes(5);
    static final Duration RESEND_COOLDOWN = Duration.ofSeconds(60);
    static final Duration TOKEN_TTL = Duration.ofDays(30);
    static final int MAX_VERIFY_ATTEMPTS = 5;
    static final int MAX_SEND_PER_PHONE_HOUR = 5;
    static final int MAX_SEND_PER_IP_HOUR = 20;

    private record Pending(String code, Instant expiresAt, Instant sentAt, int attempts) {}

    private final IntegrationConfigRepository integrationConfigRepository;
    private final ShipmentOrderRepository shipmentOrderRepository;
    private final GapOneZnsClient gapOneZnsClient;
    private final GapOneZnsLogService gapOneZnsLogService;
    private final byte[] tokenKey;
    private final SecureRandom random = new SecureRandom();
    private final Map<String, Pending> pending = new ConcurrentHashMap<>();
    private final Map<String, Deque<Instant>> sendHits = new ConcurrentHashMap<>();

    public CustomerAuthService(
        IntegrationConfigRepository integrationConfigRepository,
        ShipmentOrderRepository shipmentOrderRepository,
        GapOneZnsClient gapOneZnsClient,
        GapOneZnsLogService gapOneZnsLogService,
        @Value("${jhipster.security.authentication.jwt.base64-secret:}") String jwtSecret
    ) {
        this.integrationConfigRepository = integrationConfigRepository;
        this.shipmentOrderRepository = shipmentOrderRepository;
        this.gapOneZnsClient = gapOneZnsClient;
        this.gapOneZnsLogService = gapOneZnsLogService;
        this.tokenKey = deriveKey(jwtSecret);
    }

    public record SendResult(String phone, int resendAfterSeconds, int expiresInSeconds) {}

    public record LoginResult(String token, String phone, String name, Instant expiresAt) {}

    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public SendResult sendOtp(String rawPhone, String ip) {
        String phone = requirePhone(rawPhone);
        Pending prev = pending.get(phone);
        Instant now = Instant.now();
        if (prev != null && prev.sentAt().plus(RESEND_COOLDOWN).isAfter(now)) {
            long wait = Duration.between(now, prev.sentAt().plus(RESEND_COOLDOWN)).toSeconds() + 1;
            throw new ResponseStatusException(HttpStatus.TOO_MANY_REQUESTS, "Vui lòng đợi " + wait + " giây rồi gửi lại mã");
        }
        IntegrationConfig cfg = config();
        String testCode = testCodeFor(cfg, phone);
        if (testCode != null) {
            pending.put(phone, new Pending(testCode, now.plus(OTP_TTL), now, 0));
            return new SendResult(phone, (int) RESEND_COOLDOWN.toSeconds(), (int) OTP_TTL.toSeconds());
        }
        throttle("phone:" + phone, MAX_SEND_PER_PHONE_HOUR);
        throttle("ip:" + (ip == null ? "" : ip), MAX_SEND_PER_IP_HOUR);
        if (!Boolean.TRUE.equals(cfg.getGaponeLoginOtpEnabled()) || isBlank(cfg.getGaponeLoginOtpTemplateId())) {
            throw new ResponseStatusException(HttpStatus.SERVICE_UNAVAILABLE, "Chưa cấu hình gửi OTP đăng nhập — vui lòng thử lại sau");
        }
        String code = String.format("%06d", random.nextInt(1_000_000));
        String templateId = cfg.getGaponeLoginOtpTemplateId().trim();
        String param = isBlank(cfg.getGaponeLoginOtpParam()) ? "otp" : cfg.getGaponeLoginOtpParam().trim();
        String requestId = "cpn-otp-" + UUID.randomUUID();
        try {
            Map<String, Object> sent = gapOneZnsClient.sendZns(phone, templateId, null, Map.of(param, code), requestId);
            gapOneZnsLogService.logSendOk(
                requestId,
                str(sent.get("messageId")),
                str(sent.get("to")),
                str(sent.get("oaId")),
                templateId,
                null,
                GapOneZnsLogService.SOURCE_LOGIN_OTP,
                null
            );
        } catch (RuntimeException e) {
            LOG.warn("Send login OTP to {} failed: {}", phone, e.getMessage());
            gapOneZnsLogService.logSendError(
                requestId,
                phone,
                cfg.getGaponeOaId(),
                templateId,
                e.getMessage(),
                null,
                GapOneZnsLogService.SOURCE_LOGIN_OTP,
                null
            );
            throw new ResponseStatusException(HttpStatus.BAD_GATEWAY, "Không gửi được mã OTP — vui lòng thử lại sau");
        }
        pending.put(phone, new Pending(code, now.plus(OTP_TTL), now, 0));
        return new SendResult(phone, (int) RESEND_COOLDOWN.toSeconds(), (int) OTP_TTL.toSeconds());
    }

    @Transactional(readOnly = true)
    public LoginResult verifyOtp(String rawPhone, String rawCode) {
        String phone = requirePhone(rawPhone);
        String code = rawCode == null ? "" : rawCode.replaceAll("\\D", "");
        Pending p = pending.get(phone);
        Instant now = Instant.now();
        if (p == null || p.expiresAt().isBefore(now)) {
            pending.remove(phone);
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Mã OTP đã hết hạn — bấm Gửi lại mã");
        }
        if (!MessageDigest.isEqual(p.code().getBytes(StandardCharsets.UTF_8), code.getBytes(StandardCharsets.UTF_8))) {
            int attempts = p.attempts() + 1;
            if (attempts >= MAX_VERIFY_ATTEMPTS) {
                pending.remove(phone);
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Nhập sai quá nhiều lần — bấm Gửi lại mã");
            }
            pending.put(phone, new Pending(p.code(), p.expiresAt(), p.sentAt(), attempts));
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Mã OTP không đúng");
        }
        pending.remove(phone);
        Instant exp = now.plus(TOKEN_TTL);
        return new LoginResult(issueToken(phone, exp), phone, latestSenderName(phone), exp);
    }

    /** SĐT khách từ token; null nếu token sai / hết hạn. */
    public String phoneOf(String token) {
        if (token == null || token.isBlank()) {
            return null;
        }
        String[] parts = token.trim().split("\\.");
        if (parts.length != 2) {
            return null;
        }
        byte[] payload;
        try {
            payload = Base64.getUrlDecoder().decode(parts[0]);
            byte[] sig = Base64.getUrlDecoder().decode(parts[1]);
            if (!MessageDigest.isEqual(sig, hmac(payload))) {
                return null;
            }
        } catch (IllegalArgumentException e) {
            return null;
        }
        String[] fields = new String(payload, StandardCharsets.UTF_8).split("\\|");
        if (fields.length != 3 || !"kh".equals(fields[0])) {
            return null;
        }
        try {
            if (Instant.ofEpochSecond(Long.parseLong(fields[2])).isBefore(Instant.now())) {
                return null;
            }
        } catch (NumberFormatException e) {
            return null;
        }
        return normalizePhone(fields[1]);
    }

    public String requirePhoneOf(String token) {
        String phone = phoneOf(token);
        if (phone == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Phiên đăng nhập đã hết hạn — vui lòng đăng nhập lại");
        }
        return phone;
    }

    public String latestSenderName(String phone) {
        List<String> names = shipmentOrderRepository.findLatestSenderNames(phone, PageRequest.of(0, 1));
        return names.isEmpty() ? null : names.get(0).trim();
    }

    String issueToken(String phone, Instant exp) {
        byte[] payload = ("kh|" + phone + "|" + exp.getEpochSecond()).getBytes(StandardCharsets.UTF_8);
        Base64.Encoder enc = Base64.getUrlEncoder().withoutPadding();
        return enc.encodeToString(payload) + "." + enc.encodeToString(hmac(payload));
    }

    /** {@code 0xxxxxxxxx} hoặc null; nhận cả +84 / 84 / có dấu cách, chấm. */
    public static String normalizePhone(String raw) {
        if (raw == null) {
            return null;
        }
        String d = raw.replaceAll("\\D", "");
        if (d.startsWith("84") && d.length() == 11) {
            d = "0" + d.substring(2);
        }
        return d.matches("0[35789]\\d{8}") ? d : null;
    }

    private static String requirePhone(String raw) {
        String phone = normalizePhone(raw);
        if (phone == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Số điện thoại không hợp lệ");
        }
        return phone;
    }

    private static String testCodeFor(IntegrationConfig cfg, String phone) {
        String code = cfg.getGaponeLoginOtpTestCode();
        if (isBlank(cfg.getGaponeLoginOtpTestPhones()) || code == null || !code.trim().matches("\\d{6}")) {
            return null;
        }
        boolean listed = Arrays.stream(cfg.getGaponeLoginOtpTestPhones().split("[,;\\s]+"))
            .map(CustomerAuthService::normalizePhone)
            .anyMatch(phone::equals);
        return listed ? code.trim() : null;
    }

    private void throttle(String key, int max) {
        if (sendHits.size() > 50_000) {
            sendHits.clear();
        }
        Deque<Instant> q = sendHits.computeIfAbsent(key, k -> new ArrayDeque<>());
        synchronized (q) {
            Instant cutoff = Instant.now().minus(Duration.ofHours(1));
            while (!q.isEmpty() && q.peekFirst().isBefore(cutoff)) {
                q.pollFirst();
            }
            if (q.size() >= max) {
                throw new ResponseStatusException(HttpStatus.TOO_MANY_REQUESTS, "Gửi mã quá nhiều lần — vui lòng thử lại sau");
            }
            q.addLast(Instant.now());
        }
    }

    private IntegrationConfig config() {
        return integrationConfigRepository.findAll().stream().findFirst().orElseGet(IntegrationConfig::new);
    }

    private byte[] hmac(byte[] payload) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(tokenKey, "HmacSHA256"));
            return mac.doFinal(payload);
        } catch (Exception e) {
            throw new IllegalStateException("HMAC unavailable", e);
        }
    }

    private static byte[] deriveKey(String secret) {
        try {
            MessageDigest sha = MessageDigest.getInstance("SHA-256");
            return sha.digest(("cpn-customer-token:" + (secret == null ? "" : secret)).getBytes(StandardCharsets.UTF_8));
        } catch (Exception e) {
            throw new IllegalStateException("SHA-256 unavailable", e);
        }
    }

    private static boolean isBlank(String s) {
        return s == null || s.isBlank();
    }

    private static String str(Object o) {
        return o == null ? null : String.valueOf(o);
    }
}
