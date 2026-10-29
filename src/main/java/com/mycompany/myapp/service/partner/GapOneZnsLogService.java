package com.mycompany.myapp.service.partner;

import com.fasterxml.jackson.databind.JsonNode;
import com.mycompany.myapp.domain.GapOneZnsLog;
import com.mycompany.myapp.repository.GapOneZnsLogRepository;
import jakarta.persistence.criteria.Predicate;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

@Service
public class GapOneZnsLogService {

    public static final String KIND_SEND = "SEND";
    public static final String KIND_CALLBACK = "CALLBACK";
    public static final String RESULT_OK = "OK";
    public static final String RESULT_ERROR = "ERROR";
    public static final String RESULT_PENDING = "PENDING";
    public static final String SOURCE_TEST = "TEST";
    public static final String SOURCE_AUTOCALL_DAY0 = "AUTOCALL_DAY0";
    public static final String SOURCE_LOGIN_OTP = "LOGIN_OTP";

    private static final ZoneId VN = ZoneId.of("Asia/Ho_Chi_Minh");
    private static final int MAX_RANGE_DAYS = 90;
    private static final int MAX_PAGE_SIZE = 5_000;
    private static final Set<String> KINDS = Set.of(KIND_SEND, KIND_CALLBACK);
    private static final Set<String> RESULTS = Set.of(RESULT_OK, RESULT_ERROR, RESULT_PENDING);

    private final GapOneZnsLogRepository repository;

    public GapOneZnsLogService(GapOneZnsLogRepository repository) {
        this.repository = repository;
    }

    @Transactional
    public GapOneZnsLog logSendOk(String requestId, String messageId, String phone, String oaId, String templateId, String raw) {
        return logSendOk(requestId, messageId, phone, oaId, templateId, raw, SOURCE_TEST, null);
    }

    @Transactional
    public GapOneZnsLog logSendOk(
        String requestId,
        String messageId,
        String phone,
        String oaId,
        String templateId,
        String raw,
        String source,
        String orderCode
    ) {
        GapOneZnsLog row = base(KIND_SEND, messageId != null && !messageId.isBlank() ? RESULT_OK : RESULT_PENDING);
        row.setRequestId(clip(requestId, 80));
        row.setMessageId(clip(messageId, 80));
        row.setPhone(clip(phone, 32));
        row.setOaId(clip(oaId, 64));
        row.setTemplateId(clip(templateId, 64));
        row.setDeliveryChannel("zalo");
        row.setRawJson(clip(raw, 4000));
        row.setSource(clip(source, 32));
        row.setOrderCode(clip(orderCode, 64));
        return repository.save(row);
    }

    @Transactional
    public GapOneZnsLog logSendError(String requestId, String phone, String oaId, String templateId, String errorMessage, String raw) {
        return logSendError(requestId, phone, oaId, templateId, errorMessage, raw, SOURCE_TEST, null);
    }

    @Transactional
    public GapOneZnsLog logSendError(
        String requestId,
        String phone,
        String oaId,
        String templateId,
        String errorMessage,
        String raw,
        String source,
        String orderCode
    ) {
        GapOneZnsLog row = base(KIND_SEND, RESULT_ERROR);
        row.setRequestId(clip(requestId, 80));
        row.setPhone(clip(phone, 32));
        row.setOaId(clip(oaId, 64));
        row.setTemplateId(clip(templateId, 64));
        row.setDeliveryChannel("zalo");
        row.setErrorMessage(clip(errorMessage, 500));
        row.setRawJson(clip(raw, 4000));
        row.setSource(clip(source, 32));
        row.setOrderCode(clip(orderCode, 64));
        return repository.save(row);
    }

    @Transactional(readOnly = true)
    public boolean alreadySentAutocallDay0(String orderCode) {
        if (orderCode == null || orderCode.isBlank()) {
            return false;
        }
        return repository.existsByOrderCodeAndSourceAndKindAndResultIn(
            orderCode.trim(),
            SOURCE_AUTOCALL_DAY0,
            KIND_SEND,
            List.of(RESULT_OK, RESULT_PENDING)
        );
    }

    @Transactional
    public GapOneZnsLog logCallback(JsonNode body, String raw) {
        String messageId = text(body, "message_id");
        String requestId = text(body, "request_id");
        String channel = text(body, "delivery_channel");
        String desc = text(body, "delivery_description");
        Integer status = null;
        if (body != null && body.has("delivery_status") && !body.get("delivery_status").isNull()) {
            status = body.get("delivery_status").asInt();
        }
        String err = text(body, "error_message");
        String result = RESULT_OK;
        if (status != null && status != 0) {
            result = RESULT_ERROR;
        }
        if (err != null && !err.isBlank() && !"Success".equalsIgnoreCase(err) && !"200".equals(text(body, "error_status"))) {
            if (status != null && status != 0) {
                result = RESULT_ERROR;
            }
        }

        GapOneZnsLog row = base(KIND_CALLBACK, result);
        row.setRequestId(clip(requestId, 80));
        row.setMessageId(clip(messageId, 80));
        row.setDeliveryChannel(clip(channel, 32));
        row.setDeliveryStatus(status);
        row.setDeliveryDescription(clip(desc, 255));
        row.setErrorMessage(clip(err, 500));
        row.setRawJson(clip(raw, 4000));
        GapOneZnsLog saved = repository.save(row);

        // Gắn trạng thái delivery lên bản SEND cùng message_id (nếu có).
        if (messageId != null && !messageId.isBlank()) {
            for (GapOneZnsLog send : repository.findByMessageIdOrderByCreatedAtDesc(messageId)) {
                if (!KIND_SEND.equals(send.getKind())) {
                    continue;
                }
                send.setDeliveryStatus(status);
                send.setDeliveryDescription(clip(desc, 255));
                send.setResult(status != null && status == 0 ? RESULT_OK : RESULT_ERROR);
                if (err != null) {
                    send.setErrorMessage(clip(err, 500));
                }
                repository.save(send);
                break;
            }
        }
        return saved;
    }

    @Transactional(readOnly = true)
    public Map<String, Object> list(String from, String to, String kind, String result, String phone, Integer page, Integer limit) {
        LocalDate toDate = parseDate(to, LocalDate.now(VN));
        LocalDate fromDate = parseDate(from, toDate.minusDays(6));
        if (fromDate.isAfter(toDate)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "from không được sau to");
        }
        if (ChronoUnit.DAYS.between(fromDate, toDate) + 1 > MAX_RANGE_DAYS) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Khoảng ngày tối đa " + MAX_RANGE_DAYS + " ngày");
        }

        String kindFilter = optionalOf(kind, KINDS, "kind phải là SEND hoặc CALLBACK");
        String resultFilter = optionalOf(result, RESULTS, "result phải là OK, ERROR hoặc PENDING");
        String phoneDigits = phoneDigits(phone);

        Instant fromInst = fromDate.atStartOfDay(VN).toInstant();
        Instant toInst = toDate.plusDays(1).atStartOfDay(VN).toInstant();

        int pg = page == null || page < 1 ? 1 : page;
        int lim = limit == null ? 50 : Math.max(1, Math.min(MAX_PAGE_SIZE, limit));

        Specification<GapOneZnsLog> spec = (root, query, cb) -> {
            List<Predicate> preds = new ArrayList<>();
            preds.add(cb.greaterThanOrEqualTo(root.get("createdAt"), fromInst));
            preds.add(cb.lessThan(root.get("createdAt"), toInst));
            if (kindFilter != null) {
                preds.add(cb.equal(root.get("kind"), kindFilter));
            }
            if (resultFilter != null) {
                preds.add(cb.equal(root.get("result"), resultFilter));
            }
            if (phoneDigits != null) {
                preds.add(cb.like(root.get("phone"), "%" + phoneDigits + "%"));
            }
            return cb.and(preds.toArray(Predicate[]::new));
        };

        Page<GapOneZnsLog> pageResult = repository.findAll(
            spec,
            PageRequest.of(pg - 1, lim, Sort.by(Sort.Direction.DESC, "createdAt").and(Sort.by(Sort.Direction.DESC, "id")))
        );

        List<Map<String, Object>> items = new ArrayList<>();
        for (GapOneZnsLog r : pageResult.getContent()) {
            items.add(toView(r));
        }

        Map<String, Object> pagination = new LinkedHashMap<>();
        pagination.put("page", pg);
        pagination.put("limit", lim);
        pagination.put("total", pageResult.getTotalElements());
        pagination.put("totalPages", Math.max(1, pageResult.getTotalPages()));

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("ok", true);
        out.put("from", fromDate.toString());
        out.put("to", toDate.toString());
        out.put("count", items.size());
        out.put("items", items);
        out.put("pagination", pagination);
        return out;
    }

    private static GapOneZnsLog base(String kind, String result) {
        GapOneZnsLog row = new GapOneZnsLog();
        row.setCreatedAt(Instant.now());
        row.setKind(kind);
        row.setResult(result);
        return row;
    }

    private static Map<String, Object> toView(GapOneZnsLog r) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("id", r.getId());
        m.put("createdAt", r.getCreatedAt() != null ? r.getCreatedAt().toString() : null);
        m.put("kind", r.getKind());
        m.put("result", r.getResult());
        m.put("requestId", r.getRequestId());
        m.put("messageId", r.getMessageId());
        m.put("phone", r.getPhone());
        m.put("oaId", r.getOaId());
        m.put("templateId", r.getTemplateId());
        m.put("deliveryChannel", r.getDeliveryChannel());
        m.put("deliveryStatus", r.getDeliveryStatus());
        m.put("deliveryDescription", r.getDeliveryDescription());
        m.put("errorMessage", r.getErrorMessage());
        m.put("source", r.getSource());
        m.put("orderCode", r.getOrderCode());
        return m;
    }

    private static LocalDate parseDate(String s, LocalDate fallback) {
        if (s == null || s.isBlank()) {
            return fallback;
        }
        try {
            return LocalDate.parse(s.trim());
        } catch (DateTimeParseException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Ngày không hợp lệ (yyyy-MM-dd)");
        }
    }

    private static String optionalOf(String raw, Set<String> allowed, String err) {
        if (raw == null || raw.isBlank()) {
            return null;
        }
        String v = raw.trim().toUpperCase(Locale.ROOT);
        if (!allowed.contains(v)) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, err);
        }
        return v;
    }

    private static String phoneDigits(String phone) {
        if (phone == null || phone.isBlank()) {
            return null;
        }
        String digits = phone.replaceAll("\\D+", "");
        return digits.isEmpty() ? null : digits;
    }

    private static String text(JsonNode node, String field) {
        if (node == null) {
            return null;
        }
        JsonNode n = node.get(field);
        if (n == null || n.isNull()) {
            return null;
        }
        String s = n.asText();
        return s == null || s.isBlank() ? null : s;
    }

    private static String clip(String s, int max) {
        if (s == null) {
            return null;
        }
        String t = s.trim();
        if (t.isEmpty()) {
            return null;
        }
        return t.length() <= max ? t : t.substring(0, max);
    }
}
