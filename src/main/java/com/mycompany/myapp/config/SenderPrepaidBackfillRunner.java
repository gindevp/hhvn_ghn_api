package com.mycompany.myapp.config;

import com.mycompany.myapp.service.order.OrderFacadeService;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

/**
 * One-shot (idempotent) lúc boot: ghi thu đầu gửi cho đơn GUI_TRA tạo quầy / nhập kho gửi bị thiếu prepaid.
 * Tắt bằng {@code cpn.backfill.sender-prepaid-on-startup=false}.
 */
@Component
@Order
public class SenderPrepaidBackfillRunner implements ApplicationRunner {

    private static final Logger LOG = LoggerFactory.getLogger(SenderPrepaidBackfillRunner.class);

    private final OrderFacadeService orderFacadeService;

    @Value("${cpn.backfill.sender-prepaid-on-startup:true}")
    private boolean enabled;

    public SenderPrepaidBackfillRunner(OrderFacadeService orderFacadeService) {
        this.orderFacadeService = orderFacadeService;
    }

    @Override
    public void run(ApplicationArguments args) {
        if (!enabled) {
            return;
        }
        int total = 0;
        try {
            for (String code : List.of("NB311096VX", "BC3110FTZF")) {
                try {
                    Map<String, Object> one = orderFacadeService.backfillMissingSenderPrepaid(false, 1, code);
                    Object fixed = one.get("fixedCount");
                    int n = fixed instanceof Number ? ((Number) fixed).intValue() : 0;
                    total += n;
                    LOG.info("Sender prepaid backfill {}: fixed={} skipped={}", code, n, one.get("skipped"));
                } catch (Exception ex) {
                    LOG.warn("Sender prepaid backfill {} failed: {}", code, ex.toString());
                }
            }
            for (int i = 0; i < 30; i++) {
                Map<String, Object> out = orderFacadeService.backfillMissingSenderPrepaid(false, 200, null);
                Object fixed = out.get("fixedCount");
                int n = fixed instanceof Number ? ((Number) fixed).intValue() : 0;
                total += n;
                if (n == 0) {
                    break;
                }
                LOG.info("Sender prepaid backfill batch {}: fixed={}", i + 1, n);
            }
            LOG.info("Sender prepaid backfill finished, totalFixed={}", total);
        } catch (Exception ex) {
            LOG.warn("Sender prepaid backfill failed (non-fatal): {}", ex.toString());
        }
    }
}
