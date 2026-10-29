package com.mycompany.myapp.service.customer;

import com.mycompany.myapp.domain.Office;
import com.mycompany.myapp.domain.ShipmentOrder;
import com.mycompany.myapp.domain.enumeration.PaymentTerm;
import com.mycompany.myapp.repository.ShipmentOrderRepository;
import com.mycompany.myapp.service.order.OrderMoney;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

/**
 * Chủ đơn ({@code owner_phone}) dùng chung web khách và app chọn vé: đơn app được mobile_service gán chủ, đơn web khách
 * đã đăng nhập gán lúc tạo. Cả hai bên xem được mọi đơn cùng chủ.
 */
@Service
@Transactional
public class CustomerOwnerService {

    static final int MAX_ORDERS = 500;
    private static final String OTHER_GOODS = "Khác";
    private static final String GOODS_FALLBACK = "Hàng hoá";

    public record Claim(String code, String senderPhone) {}

    public record SyncRequest(String phone, List<Claim> orders) {}

    public record OwnedPackage(int seq, String label, int itemQty, BigDecimal weightKg, BigDecimal fare) {}

    /** Đơn theo khuôn {@code CreatedDeliveryOrder} của app. */
    public record OwnedOrder(
        String code,
        Instant createdAt,
        String senderName,
        String senderPhone,
        String senderAddress,
        String fromOfficeName,
        String receiverName,
        String receiverPhone,
        String receiverAddress,
        String toOfficeName,
        String route,
        String itinerary,
        boolean homePickup,
        boolean homeDelivery,
        List<OwnedPackage> packages,
        BigDecimal goodsFare,
        BigDecimal pickupFee,
        BigDecimal deliveryFee,
        BigDecimal codAmount,
        BigDecimal codFee,
        BigDecimal declaredFee,
        BigDecimal discountAmount,
        BigDecimal fare,
        BigDecimal paidAmount,
        String payLabel
    ) {}

    private final ShipmentOrderRepository shipmentOrderRepository;

    public CustomerOwnerService(ShipmentOrderRepository shipmentOrderRepository) {
        this.shipmentOrderRepository = shipmentOrderRepository;
    }

    /**
     * Gán chủ cho đơn app chưa có chủ — chỉ khi SĐT tài khoản trùng SĐT người gửi trên đơn (không nhận vơ đơn người khác).
     * Trả mọi đơn {@code owner_phone} = tài khoản (đơn web đã login đã gắn lúc tạo).
     */
    public List<OwnedOrder> sync(SyncRequest req) {
        String phone = req == null ? null : CustomerAuthService.normalizePhone(req.phone());
        if (phone == null) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "SĐT tài khoản không hợp lệ");
        }
        if (req.orders() != null) {
            for (Claim c : req.orders()) {
                claim(phone, c);
            }
        }
        return shipmentOrderRepository
            .findOwnedOrders(ownerVariants(phone), PageRequest.of(0, MAX_ORDERS))
            .stream()
            .map(CustomerOwnerService::toOwned)
            .toList();
    }

    private void claim(String phone, Claim c) {
        if (c == null || c.code() == null || c.code().isBlank()) {
            return;
        }
        ShipmentOrder order = shipmentOrderRepository.findOneByOrderCodeOrDraftCode(c.code().trim()).orElse(null);
        if (order == null || order.getOwnerPhone() != null) {
            return;
        }
        String sender = CustomerAuthService.normalizePhone(order.getSenderPhone());
        String claimed = CustomerAuthService.normalizePhone(c.senderPhone());
        if (sender == null || !phone.equals(sender) || !phone.equals(claimed)) {
            return;
        }
        order.setOwnerPhone(phone);
        shipmentOrderRepository.save(order);
    }

    /** Khách đăng nhập (0xxxxxxxxx) là chủ, người gửi hoặc người nhận của đơn. */
    @Transactional(readOnly = true)
    public boolean ownedBy(String code, String phone) {
        if (code == null || code.isBlank() || phone == null) {
            return false;
        }
        ShipmentOrder o = shipmentOrderRepository.findOneByOrderCodeOrDraftCode(code.trim()).orElse(null);
        if (o == null) {
            return false;
        }
        return (
            phone.equals(CustomerAuthService.normalizePhone(o.getOwnerPhone())) ||
            phone.equals(CustomerAuthService.normalizePhone(o.getSenderPhone())) ||
            phone.equals(CustomerAuthService.normalizePhone(o.getReceiverPhone()))
        );
    }

    /** Owner lưu dạng 0xxxxxxxxx; giữ thêm +84 cho dữ liệu cũ nhập tay. */
    static List<String> ownerVariants(String phone) {
        String rest = phone.substring(1);
        return List.of(phone, "+84" + rest, "84" + rest);
    }

    static OwnedOrder toOwned(ShipmentOrder o) {
        Office dest = o.getFinalToOffice() != null ? o.getFinalToOffice() : o.getToOffice();
        boolean homePickup = Boolean.TRUE.equals(o.getHomePickup());
        boolean homeDelivery = Boolean.TRUE.equals(o.getHomeDelivery());
        return new OwnedOrder(
            o.getOrderCode(),
            o.getCreatedAt(),
            o.getSenderName(),
            o.getSenderPhone(),
            homePickup ? o.getPickupAddress() : null,
            o.getFromOffice() != null ? o.getFromOffice().getName() : null,
            o.getReceiverName(),
            o.getReceiverPhone(),
            homeDelivery ? o.getDeliveryAddress() : null,
            dest != null ? dest.getName() : null,
            o.getRouteLabel(),
            o.getItineraryLabel(),
            homePickup,
            homeDelivery,
            packages(o.getNote(), o.getQuantity(), o.getGoodsFareAmount()),
            OrderMoney.nz(o.getGoodsFareAmount()),
            OrderMoney.nz(o.getPickupFeeAmount()),
            OrderMoney.nz(o.getDeliveryFeeAmount()),
            OrderMoney.nz(o.getCodAmount()),
            OrderMoney.nz(o.getCodFeeAmount()),
            OrderMoney.nz(o.getDeclaredFeeAmount()),
            OrderMoney.nz(o.getDiscountAmount()),
            OrderMoney.nz(o.getFareAmount()),
            OrderMoney.nz(o.getPaidAmount()),
            o.getPaymentTerm() == PaymentTerm.GUI_TRA ? "Người gửi thanh toán" : "Người nhận thanh toán"
        );
    }

    /** Kiện theo tag note như web/app: [LOAI] [TENHANG] [CUOC] [SLQTY] [PKGKG]. Không có tag → 1 kiện. */
    static List<OwnedPackage> packages(String note, Integer quantity, BigDecimal goodsFare) {
        List<String> kinds = split(tag(note, "LOAI"), "\\|");
        List<String> names = split(tag(note, "TENHANG"), "\\|");
        List<String> fares = split(tag(note, "CUOC"), ",");
        List<String> qtys = split(tag(note, "SLQTY"), ",");
        List<String> kgs = split(tag(note, "PKGKG"), ",");
        int n = Math.max(Math.max(kinds.size(), fares.size()), Math.max(qtys.size(), kgs.size()));
        List<OwnedPackage> out = new ArrayList<>();
        if (n == 0) {
            int qty = quantity != null && quantity > 0 ? quantity : 1;
            out.add(new OwnedPackage(1, GOODS_FALLBACK, qty, BigDecimal.ZERO, OrderMoney.nz(goodsFare)));
            return out;
        }
        for (int i = 0; i < n; i++) {
            String kind = at(kinds, i);
            String name = at(names, i);
            String label = OTHER_GOODS.equals(kind) && !name.isEmpty() ? name : kind.isEmpty() ? GOODS_FALLBACK : kind;
            out.add(
                new OwnedPackage(i + 1, label, Math.max(1, (int) number(at(qtys, i)).longValue()), number(at(kgs, i)), number(at(fares, i)))
            );
        }
        return out;
    }

    private static String tag(String note, String name) {
        if (note == null) {
            return "";
        }
        Matcher m = Pattern.compile("\\[" + name + "\\]([\\s\\S]*?)\\[/" + name + "\\]").matcher(note);
        return m.find() ? m.group(1) : "";
    }

    private static List<String> split(String raw, String sep) {
        if (raw == null || raw.isBlank()) {
            return List.of();
        }
        List<String> out = new ArrayList<>();
        for (String s : raw.split(sep, -1)) {
            out.add(s.trim());
        }
        return out;
    }

    private static String at(List<String> list, int i) {
        return i < list.size() ? list.get(i) : "";
    }

    private static BigDecimal number(String raw) {
        try {
            return raw == null || raw.isBlank() ? BigDecimal.ZERO : new BigDecimal(raw.trim());
        } catch (NumberFormatException e) {
            return BigDecimal.ZERO;
        }
    }
}
