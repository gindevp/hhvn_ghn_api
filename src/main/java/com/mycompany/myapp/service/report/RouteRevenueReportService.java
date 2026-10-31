package com.mycompany.myapp.service.report;

import com.mycompany.myapp.domain.Office;
import com.mycompany.myapp.domain.ShipmentOrder;
import com.mycompany.myapp.domain.enumeration.OrderStatus;
import com.mycompany.myapp.repository.OfficeRepository;
import com.mycompany.myapp.security.StaffAccessService;
import com.mycompany.myapp.service.order.CustomerTrackStatus;
import com.mycompany.myapp.service.order.OrderMoney;
import com.mycompany.myapp.web.rest.errors.BadRequestAlertException;
import jakarta.persistence.EntityManager;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Doanh thu theo tuyến (điểm nhận): ma trận ngày × tuyến.
 * Lượt = số bill; tiền ship = phí lấy + phí giao tận nơi; đã/chưa TT theo cước net; DT thực = cước net.
 */
@Service
@Transactional(readOnly = true)
public class RouteRevenueReportService {

    static final ZoneId VN = ZoneId.of("Asia/Ho_Chi_Minh");
    static final int MAX_RANGE_DAYS = 366;

    public record Cell(long bills, BigDecimal shipFee, BigDecimal paid, BigDecimal unpaid, BigDecimal revenue) {
        static Cell zero() {
            return new Cell(0L, BigDecimal.ZERO, BigDecimal.ZERO, BigDecimal.ZERO, BigDecimal.ZERO);
        }

        Cell add(Cell o) {
            return new Cell(
                bills + o.bills,
                shipFee.add(o.shipFee),
                paid.add(o.paid),
                unpaid.add(o.unpaid),
                revenue.add(o.revenue)
            );
        }
    }

    public record DayRow(LocalDate date, Map<String, Cell> byRoute, Cell total) {}

    public record Report(LocalDate from, LocalDate to, String officeCode, List<String> routes, List<DayRow> days, Cell grandTotal) {}

    private final EntityManager em;
    private final OfficeRepository officeRepository;
    private final StaffAccessService staffAccessService;

    public RouteRevenueReportService(EntityManager em, OfficeRepository officeRepository, StaffAccessService staffAccessService) {
        this.em = em;
        this.officeRepository = officeRepository;
        this.staffAccessService = staffAccessService;
    }

    public Report report(LocalDate from, LocalDate to, String officeCode) {
        LocalDate today = LocalDate.now(VN);
        LocalDate f = from != null ? from : today;
        LocalDate t = to != null ? to : f;
        if (t.isBefore(f)) {
            LocalDate x = f;
            f = t;
            t = x;
        }
        if (ChronoUnit.DAYS.between(f, t) + 1 > MAX_RANGE_DAYS) {
            throw new BadRequestAlertException("Khoảng ngày tối đa " + MAX_RANGE_DAYS + " ngày", "report", "rangeTooLong");
        }
        String office = resolveOffice(officeCode);
        Instant start = f.atStartOfDay(VN).toInstant();
        Instant end = t.plusDays(1).atStartOfDay(VN).toInstant();

        List<Object[]> rows = em
            .createQuery(
                "select o, f.code from ShipmentOrder o left join o.fromOffice f" +
                " where o.createdAt >= :start and o.createdAt < :end and o.status <> :draft" +
                " and (o.status <> :cancelled or (o.transferPaidAt is not null and (o.transferSandbox is null or o.transferSandbox = false)))",
                Object[].class
            )
            .setParameter("start", start)
            .setParameter("end", end)
            .setParameter("draft", OrderStatus.DRAFT)
            .setParameter("cancelled", OrderStatus.CANCELLED)
            .getResultList();

        Map<LocalDate, Map<String, Cell>> matrix = new TreeMap<>();
        Set<String> routeSet = new LinkedHashSet<>();
        Cell grand = Cell.zero();

        for (Object[] r : rows) {
            ShipmentOrder o = (ShipmentOrder) r[0];
            String fromCode = r[1] == null ? "" : String.valueOf(r[1]).trim();
            if (office != null && !office.equalsIgnoreCase(fromCode)) {
                continue;
            }
            if (o.getTransferPaidAt() == null && CustomerTrackStatus.pendingHandover(o)) {
                continue;
            }
            Instant created = o.getCreatedAt();
            if (created == null) {
                continue;
            }
            LocalDate day = created.atZone(VN).toLocalDate();
            String route = routeLabel(o);
            routeSet.add(route);

            BigDecimal revenue = RevenueLedger.netFare(
                o.getFareAmount(),
                o.getPartnerCode(),
                o.getPartnerStatus(),
                o.getPartnerFeeAmount()
            );
            BigDecimal paid = RevenueLedger.collectedOf(revenue, o.getPaidAmount());
            BigDecimal unpaid = revenue.subtract(paid).max(BigDecimal.ZERO);
            BigDecimal ship = OrderMoney.nz(o.getPickupFeeAmount()).add(OrderMoney.nz(o.getDeliveryFeeAmount()));
            Cell cell = new Cell(1L, ship, paid, unpaid, revenue);

            matrix.computeIfAbsent(day, d -> new LinkedHashMap<>()).merge(route, cell, Cell::add);
            grand = grand.add(cell);
        }

        List<String> routes = new ArrayList<>(routeSet);
        routes.sort(Comparator.comparing(s -> s.toLowerCase(Locale.ROOT)));

        List<DayRow> days = new ArrayList<>();
        for (LocalDate d = f; !d.isAfter(t); d = d.plusDays(1)) {
            Map<String, Cell> byRoute = matrix.getOrDefault(d, Map.of());
            Map<String, Cell> ordered = new LinkedHashMap<>();
            Cell dayTotal = Cell.zero();
            for (String route : routes) {
                Cell c = byRoute.getOrDefault(route, Cell.zero());
                ordered.put(route, c);
                dayTotal = dayTotal.add(c);
            }
            days.add(new DayRow(d, ordered, dayTotal));
        }

        return new Report(f, t, office, routes, days, grand);
    }

    /** Nhãn tuyến = điểm lộ trình VP nhận (final/to), không có thì tên VP, không có thì «Khác». */
    static String routeLabel(ShipmentOrder o) {
        Office dest = o.getFinalToOffice() != null ? o.getFinalToOffice() : o.getToOffice();
        if (dest == null) {
            return "Khác";
        }
        String point = dest.getItineraryPoint();
        if (point != null && !point.isBlank()) {
            return point.trim();
        }
        if (dest.getName() != null && !dest.getName().isBlank()) {
            return dest.getName().trim();
        }
        if (dest.getCode() != null && !dest.getCode().isBlank()) {
            return dest.getCode().trim();
        }
        return "Khác";
    }

    private String resolveOffice(String officeCode) {
        String scoped = staffAccessService.scopedOfficeCode().orElse(null);
        if (scoped != null && !scoped.isBlank()) {
            return scoped.trim();
        }
        if (officeCode == null || officeCode.isBlank()) {
            return null;
        }
        String raw = officeCode.trim();
        return officeRepository
            .findAll()
            .stream()
            .filter(o -> raw.equalsIgnoreCase(o.getCode()) || raw.equalsIgnoreCase(o.getName()))
            .map(Office::getCode)
            .findFirst()
            .orElse(raw);
    }
}
