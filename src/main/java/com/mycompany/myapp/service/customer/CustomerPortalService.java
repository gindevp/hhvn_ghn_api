package com.mycompany.myapp.service.customer;

import com.mycompany.myapp.domain.Office;
import com.mycompany.myapp.domain.ShipmentOrder;
import com.mycompany.myapp.domain.enumeration.OrderStatus;
import com.mycompany.myapp.domain.enumeration.PaymentTerm;
import com.mycompany.myapp.repository.ShipmentOrderRepository;
import com.mycompany.myapp.service.dto.order.TrackOrderRequest;
import com.mycompany.myapp.service.dto.order.TrackOrderResponse;
import com.mycompany.myapp.service.order.CustomerTrackStatus;
import com.mycompany.myapp.service.order.OrderFacadeService;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

/** Dữ liệu trang khách (sau đăng nhập OTP): chỉ đơn owner_phone = SĐT tài khoản. */
@Service
public class CustomerPortalService {

    static final int MAX_ORDERS = 500;
    private static final ZoneId VN = ZoneId.of("Asia/Ho_Chi_Minh");

    private final ShipmentOrderRepository shipmentOrderRepository;
    private final OrderFacadeService orderFacadeService;

    public CustomerPortalService(ShipmentOrderRepository shipmentOrderRepository, OrderFacadeService orderFacadeService) {
        this.shipmentOrderRepository = shipmentOrderRepository;
        this.orderFacadeService = orderFacadeService;
    }

    /** Nhóm hiển thị trên trang khách. */
    public enum Group {
        PENDING,
        SHIPPING,
        DELIVERED,
        CANCELLED,
    }

    public record OrderRow(
        String orderCode,
        Instant createdAt,
        String direction,
        String senderName,
        String senderPhone,
        String receiverName,
        String receiverPhone,
        String deliveryAddress,
        String fromOfficeName,
        String toOfficeName,
        BigDecimal fareAmount,
        BigDecimal paidAmount,
        BigDecimal codAmount,
        String payer,
        String status,
        String statusLabel,
        String group,
        boolean invoiced,
        boolean codRefunded
    ) {}

    @Transactional(readOnly = true)
    public List<OrderRow> orders(String phone) {
        return shipmentOrderRepository
            .findOwnedOrders(phoneVariants(phone), PageRequest.of(0, MAX_ORDERS))
            .stream()
            .map(o -> row(o, phone))
            .toList();
    }

    @Transactional(readOnly = true)
    public Map<String, Object> summary(String phone, String name) {
        List<OrderRow> rows = orders(phone);
        LocalDate today = LocalDate.now(VN);
        Instant monthStart = today.withDayOfMonth(1).atStartOfDay(VN).toInstant();
        Instant prevMonthStart = today.withDayOfMonth(1).minusMonths(1).atStartOfDay(VN).toInstant();
        Map<String, Long> month = countByGroup(rows, monthStart, null);
        Map<String, Long> prev = countByGroup(rows, prevMonthStart, monthStart);
        BigDecimal spendMonth = spend(rows, phone, monthStart, null);
        BigDecimal spendPrev = spend(rows, phone, prevMonthStart, monthStart);
        long shippingNow = rows.stream().filter(r -> Group.SHIPPING.name().equals(r.group())).count();

        Map<String, Object> out = new LinkedHashMap<>();
        out.put("phone", phone);
        out.put("name", name);
        out.put("totalOrders", rows.size());
        out.put("shippingNow", shippingNow);
        out.put("month", month);
        out.put("prevMonth", prev);
        out.put("spendMonth", spendMonth);
        out.put("spendPrevMonth", spendPrev);
        return out;
    }

    @Transactional(readOnly = true)
    public TrackOrderResponse detail(String phone, String code) {
        if (code == null || code.isBlank()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy đơn");
        }
        ShipmentOrder owned = shipmentOrderRepository.findOneByOrderCodeOrDraftCode(code.trim()).orElse(null);
        if (owned == null || !phone.equals(CustomerAuthService.normalizePhone(owned.getOwnerPhone()))) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy đơn");
        }
        TrackOrderRequest req = new TrackOrderRequest();
        req.setCode(code);
        req.setPhone(owned.getSenderPhone() != null ? owned.getSenderPhone() : phone);
        TrackOrderResponse res = orderFacadeService.track(req);
        if (!res.isFound()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Không tìm thấy đơn");
        }
        return res;
    }

    private static Map<String, Long> countByGroup(List<OrderRow> rows, Instant from, Instant to) {
        Map<String, Long> out = new LinkedHashMap<>();
        for (Group g : Group.values()) {
            out.put(g.name(), 0L);
        }
        long total = 0;
        for (OrderRow r : rows) {
            if (!inRange(r.createdAt(), from, to)) continue;
            out.merge(r.group(), 1L, Long::sum);
            total++;
        }
        out.put("TOTAL", total);
        return out;
    }

    /** Cước khách đã/ sẽ trả: đơn khách là người gửi trả, hoặc khách là người nhận trả. */
    private static BigDecimal spend(List<OrderRow> rows, String phone, Instant from, Instant to) {
        BigDecimal sum = BigDecimal.ZERO;
        for (OrderRow r : rows) {
            if (!inRange(r.createdAt(), from, to) || Group.CANCELLED.name().equals(r.group()) || r.fareAmount() == null) continue;
            boolean mine = "SENDER".equals(r.payer()) ? "SENT".equals(r.direction()) : "RECEIVED".equals(r.direction());
            if (mine) sum = sum.add(r.fareAmount());
        }
        return sum;
    }

    private static boolean inRange(Instant at, Instant from, Instant to) {
        if (at == null) return false;
        return !at.isBefore(from) && (to == null || at.isBefore(to));
    }

    private static OrderRow row(ShipmentOrder o, String phone) {
        boolean received =
            phone.equals(CustomerAuthService.normalizePhone(o.getReceiverPhone())) &&
            !phone.equals(CustomerAuthService.normalizePhone(o.getSenderPhone()));
        // Đơn tạo bằng tài khoản (owner) mà mình không phải người nhận → coi là đơn gửi.
        boolean sent = !received;
        Office dest = o.getFinalToOffice() != null ? o.getFinalToOffice() : o.getToOffice();
        String inv = o.getInvoiceStatus();
        return new OrderRow(
            o.getOrderCode(),
            o.getCreatedAt(),
            sent ? "SENT" : "RECEIVED",
            o.getSenderName(),
            o.getSenderPhone(),
            o.getReceiverName(),
            o.getReceiverPhone(),
            o.getDeliveryAddress(),
            o.getFromOffice() != null ? o.getFromOffice().getName() : null,
            dest != null ? dest.getName() : null,
            o.getFareAmount(),
            o.getPaidAmount(),
            o.getCodAmount(),
            o.getPaymentTerm() == PaymentTerm.GUI_TRA ? "SENDER" : "RECEIVER",
            o.getStatus() != null ? o.getStatus().name() : null,
            CustomerTrackStatus.labelOf(o),
            group(o).name(),
            "ISSUED".equals(inv) || "DUPLICATE".equals(inv),
            o.getCodExportedAt() != null
        );
    }

    static Group group(ShipmentOrder o) {
        OrderStatus st = o.getStatus();
        if (st == OrderStatus.DELIVERED) return Group.DELIVERED;
        if (st == OrderStatus.CANCELLED || st == OrderStatus.RETURNED || st == OrderStatus.RETURNING) return Group.CANCELLED;
        if (CustomerTrackStatus.pendingHandover(o)) return Group.PENDING;
        return Group.SHIPPING;
    }

    static List<String> phoneVariants(String phone) {
        String rest = phone.substring(1);
        return List.of(phone, "+84" + rest, "84" + rest);
    }
}
