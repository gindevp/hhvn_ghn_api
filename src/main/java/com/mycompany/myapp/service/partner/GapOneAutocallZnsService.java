package com.mycompany.myapp.service.partner;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mycompany.myapp.domain.AutoCall;
import com.mycompany.myapp.domain.IntegrationConfig;
import com.mycompany.myapp.domain.Office;
import com.mycompany.myapp.domain.OrderEvent;
import com.mycompany.myapp.domain.ShipmentOrder;
import com.mycompany.myapp.repository.AutoCallRepository;
import com.mycompany.myapp.repository.IntegrationConfigRepository;
import com.mycompany.myapp.repository.OrderEventRepository;
import com.mycompany.myapp.repository.ShipmentOrderRepository;
import com.mycompany.myapp.service.autocall.AutoCallService;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Hết vòng Auto Call ngày 1 (không nghe máy hoặc đã huỷ) → gửi ZNS GapOne theo cấu hình Tích hợp.
 */
@Service
public class GapOneAutocallZnsService {

    private static final Logger LOG = LoggerFactory.getLogger(GapOneAutocallZnsService.class);
    private static final String ACTOR = "gapone-zns";
    private static final Set<String> FIELD_KEYS = Set.of(
        "orderCode",
        "receiverName",
        "receiverPhone",
        "deliveryAddress",
        "senderName",
        "senderPhone",
        "codAmount",
        "fareAmount",
        "paidAmount",
        "goodsName",
        "toOfficeCode",
        "toOfficeName",
        "toOfficeAddress",
        "fromOfficeCode",
        "fromOfficeName",
        "quantity",
        "weightKg",
        "paymentTerm",
        "serviceType",
        "status",
        "refId",
        "retryDay",
        "retryNo"
    );

    private final IntegrationConfigRepository integrationConfigRepository;
    private final AutoCallRepository autoCallRepository;
    private final ShipmentOrderRepository shipmentOrderRepository;
    private final GapOneZnsClient gapOneZnsClient;
    private final GapOneZnsLogService gapOneZnsLogService;
    private final OrderEventRepository orderEventRepository;

    public GapOneAutocallZnsService(
        IntegrationConfigRepository integrationConfigRepository,
        AutoCallRepository autoCallRepository,
        ShipmentOrderRepository shipmentOrderRepository,
        GapOneZnsClient gapOneZnsClient,
        GapOneZnsLogService gapOneZnsLogService,
        OrderEventRepository orderEventRepository
    ) {
        this.integrationConfigRepository = integrationConfigRepository;
        this.autoCallRepository = autoCallRepository;
        this.shipmentOrderRepository = shipmentOrderRepository;
        this.gapOneZnsClient = gapOneZnsClient;
        this.gapOneZnsLogService = gapOneZnsLogService;
        this.orderEventRepository = orderEventRepository;
    }

    /**
     * Gọi sau kết quả Auto Call cuối. Fail-open: mọi lỗi chỉ log / OrderEvent, không ném ra webhook.
     */
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void maybeSendAfterDay0Fail(Long callId) {
        if (callId == null) {
            return;
        }
        try {
            AutoCall call = autoCallRepository.findById(callId).orElse(null);
            if (call == null || !shouldTrigger(call)) {
                return;
            }
            IntegrationConfig cfg = currentConfig();
            if (cfg == null || !Boolean.TRUE.equals(cfg.getGaponeAutocallZnsEnabled())) {
                return;
            }
            String templateId = blankToNull(cfg.getGaponeAutocallZnsTemplateId());
            if (templateId == null) {
                return;
            }
            if (!notBlank(cfg.getGaponeClientId()) || !cfg.isGaponeClientSecretConfigured()) {
                return;
            }
            ShipmentOrder order = call.getOrder();
            if (order != null && order.getId() != null) {
                order = shipmentOrderRepository.findById(order.getId()).orElse(order);
            }
            if (order == null) {
                return;
            }
            String orderCode = order.getOrderCode();
            if (gapOneZnsLogService.alreadySentAutocallDay0(orderCode)) {
                return;
            }
            String phone = order.getReceiverPhone();
            Map<String, Object> templateData = buildTemplateData(cfg.getGaponeAutocallZnsFieldMap(), order, call);
            String requestId = "cpn-ac-" + (orderCode != null ? orderCode : "x") + "-" + UUID.randomUUID().toString().substring(0, 8);
            try {
                Map<String, Object> sent = gapOneZnsClient.sendZns(phone, templateId, cfg.getGaponeOaId(), templateData, requestId);
                gapOneZnsLogService.logSendOk(
                    str(sent.get("requestId")),
                    str(sent.get("messageId")),
                    str(sent.get("to")),
                    str(sent.get("oaId")),
                    str(sent.get("templateId")),
                    str(sent.get("raw")),
                    GapOneZnsLogService.SOURCE_AUTOCALL_DAY0,
                    orderCode
                );
                appendEvent(
                    order,
                    "ZNS_AUTOCALL",
                    "Đã gửi ZNS (hết vòng gọi ngày 1 · không nghe/đã huỷ) → " +
                    (phone != null ? phone : "?") +
                    " · mẫu " +
                    templateId +
                    (sent.get("messageId") != null ? " · msgid " + sent.get("messageId") : "")
                );
            } catch (Exception e) {
                LOG.warn("AutoCall day0 ZNS failed for {}: {}", orderCode, e.getMessage());
                gapOneZnsLogService.logSendError(
                    requestId,
                    phone,
                    cfg.getGaponeOaId(),
                    templateId,
                    rootMessage(e),
                    null,
                    GapOneZnsLogService.SOURCE_AUTOCALL_DAY0,
                    orderCode
                );
                appendEvent(
                    order,
                    "ZNS_ERROR",
                    "Gửi ZNS thất bại (hết vòng gọi ngày 1) → " + (phone != null ? phone : "?") + ": " + truncate(rootMessage(e), 180)
                );
            }
        } catch (Exception e) {
            LOG.warn("maybeSendAfterDay0Fail ignored: {}", e.getMessage());
        }
    }

    /**
     * Hết vòng ngày 0 (retryNo ≥ số khoảng cách = cuộc thứ 3 nếu lịch 60,120) và kết quả là không nghe
     * hoặc đã huỷ. Lỗi tổng đài / gửi lỗi không gửi ZNS.
     */
    boolean shouldTrigger(AutoCall call, IntegrationConfig cfg) {
        if (call == null || cfg == null) {
            return false;
        }
        if (nz(call.getRetryDay()) != 0) {
            return false;
        }
        if (!customerMissedOrCancelled(call)) {
            return false;
        }
        List<Integer> intervals = AutoCallService.retryIntervals(cfg);
        return nz(call.getRetryNo()) >= intervals.size();
    }

    /** Hai trạng thái thất bại phía khách: không nghe máy, đã huỷ. */
    static boolean customerMissedOrCancelled(AutoCall call) {
        if (call == null) {
            return false;
        }
        if ("CANCELLED".equalsIgnoreCase(call.getStatus()) || "cancelled".equalsIgnoreCase(call.getResult())) {
            return true;
        }
        return AutoCallService.retryReason(call) == AutoCallService.RetryReason.NO_ANSWER;
    }

    private boolean shouldTrigger(AutoCall call) {
        return shouldTrigger(call, currentConfig());
    }

    Map<String, Object> buildTemplateData(String fieldMapJson, ShipmentOrder order, AutoCall call) {
        Map<String, String> map = parseFieldMap(fieldMapJson);
        Map<String, Object> data = new LinkedHashMap<>();
        for (Map.Entry<String, String> e : map.entrySet()) {
            String param = e.getKey();
            String field = e.getValue();
            if (param == null || param.isBlank() || field == null || field.isBlank()) {
                continue;
            }
            String value = resolveField(field.trim(), order, call);
            if (value != null) {
                data.put(param.trim(), value);
            }
        }
        return data;
    }

    static Map<String, String> parseFieldMap(String raw) {
        if (raw == null || raw.isBlank()) {
            return Map.of();
        }
        try {
            ObjectMapper om = new ObjectMapper();
            Map<String, String> parsed = om.readValue(raw, new TypeReference<Map<String, String>>() {});
            if (parsed == null || parsed.isEmpty()) {
                return Map.of();
            }
            Map<String, String> out = new LinkedHashMap<>();
            for (Map.Entry<String, String> e : parsed.entrySet()) {
                if (e.getKey() == null || e.getKey().isBlank() || e.getValue() == null || e.getValue().isBlank()) {
                    continue;
                }
                String field = e.getValue().trim();
                if (!FIELD_KEYS.contains(field)) {
                    continue;
                }
                out.put(e.getKey().trim(), field);
            }
            return out;
        } catch (Exception e) {
            return Map.of();
        }
    }

    static String resolveField(String field, ShipmentOrder order, AutoCall call) {
        if (order == null) {
            return switch (field) {
                case "refId" -> call != null ? call.getRefId() : null;
                case "retryDay" -> call != null ? String.valueOf(nz(call.getRetryDay())) : null;
                case "retryNo" -> call != null ? String.valueOf(nz(call.getRetryNo())) : null;
                default -> null;
            };
        }
        return switch (field) {
            case "orderCode" -> order.getOrderCode();
            case "receiverName" -> order.getReceiverName();
            case "receiverPhone" -> order.getReceiverPhone();
            case "deliveryAddress" -> order.getDeliveryAddress();
            case "senderName" -> order.getSenderName();
            case "senderPhone" -> order.getSenderPhone();
            case "codAmount" -> money(order.getCodAmount());
            case "fareAmount" -> money(order.getFareAmount());
            case "paidAmount" -> money(order.getPaidAmount());
            case "goodsName" -> AutoCallService.goodsNameLabel(order.getNote());
            case "toOfficeCode" -> officeCode(order.getToOffice());
            case "toOfficeName" -> AutoCallService.officeLabel(order.getToOffice());
            case "toOfficeAddress" -> officeAddress(order.getToOffice());
            case "fromOfficeCode" -> officeCode(order.getFromOffice());
            case "fromOfficeName" -> AutoCallService.officeLabel(order.getFromOffice());
            case "quantity" -> order.getQuantity() != null ? String.valueOf(order.getQuantity()) : null;
            case "weightKg" -> order.getWeightKg() != null ? order.getWeightKg().stripTrailingZeros().toPlainString() : null;
            case "paymentTerm" -> order.getPaymentTerm() != null ? order.getPaymentTerm().name() : null;
            case "serviceType" -> order.getServiceType() != null ? order.getServiceType().name() : null;
            case "status" -> order.getStatus() != null ? order.getStatus().name() : null;
            case "refId" -> call != null ? call.getRefId() : null;
            case "retryDay" -> call != null ? String.valueOf(nz(call.getRetryDay())) : null;
            case "retryNo" -> call != null ? String.valueOf(nz(call.getRetryNo())) : null;
            default -> null;
        };
    }

    public static Set<String> fieldKeys() {
        return FIELD_KEYS;
    }

    private void appendEvent(ShipmentOrder order, String action, String detail) {
        if (order == null || order.getId() == null) {
            return;
        }
        try {
            ShipmentOrder ref = shipmentOrderRepository.getReferenceById(order.getId());
            OrderEvent event = new OrderEvent();
            event.setEventAt(java.time.Instant.now());
            event.setAction(action);
            event.setDetail(truncate(detail, OrderEvent.DETAIL_MAX));
            event.setActorUsername(ACTOR);
            event.setOrder(ref);
            orderEventRepository.saveAndFlush(event);
        } catch (Exception e) {
            LOG.warn("ZNS OrderEvent failed: {}", e.getMessage());
        }
    }

    private IntegrationConfig currentConfig() {
        return integrationConfigRepository.findAll().stream().findFirst().orElse(null);
    }

    private static String money(BigDecimal v) {
        return v == null ? null : v.stripTrailingZeros().toPlainString();
    }

    private static String officeCode(Office office) {
        return office != null && office.getCode() != null ? office.getCode().trim() : null;
    }

    private static String officeAddress(Office office) {
        return office != null && office.getAddress() != null ? office.getAddress().trim() : null;
    }

    private static int nz(Integer v) {
        return v == null ? 0 : v;
    }

    private static boolean notBlank(String s) {
        return s != null && !s.isBlank();
    }

    private static String blankToNull(String s) {
        return notBlank(s) ? s.trim() : null;
    }

    private static String str(Object o) {
        return o == null ? null : String.valueOf(o);
    }

    private static String truncate(String s, int max) {
        if (s == null) {
            return null;
        }
        return s.length() <= max ? s : s.substring(0, max);
    }

    private static String rootMessage(Throwable e) {
        Throwable t = e;
        while (t.getCause() != null && t.getCause() != t) {
            t = t.getCause();
        }
        String m = t.getMessage();
        return m != null && !m.isBlank() ? m : e.getClass().getSimpleName();
    }
}
