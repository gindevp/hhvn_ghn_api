package com.mycompany.myapp.service.partner;

import static org.assertj.core.api.Assertions.assertThat;

import com.mycompany.myapp.domain.AutoCall;
import com.mycompany.myapp.domain.IntegrationConfig;
import com.mycompany.myapp.domain.ShipmentOrder;
import java.util.Map;
import org.junit.jupiter.api.Test;

class GapOneAutocallZnsServiceTest {

    @Test
    void shouldTrigger_day0LastNoAnswer_true() {
        IntegrationConfig cfg = new IntegrationConfig();
        cfg.setAutocallRetryIntervals("60,120");
        AutoCall call = new AutoCall();
        call.setRetryDay(0);
        call.setRetryNo(2);
        call.setStatus("FAILED");
        call.setResult("not_answered");
        GapOneAutocallZnsService svc = bareService();
        assertThat(svc.shouldTrigger(call, cfg)).isTrue();
    }

    @Test
    void shouldTrigger_midDay_false() {
        IntegrationConfig cfg = new IntegrationConfig();
        cfg.setAutocallRetryIntervals("60,120");
        AutoCall call = new AutoCall();
        call.setRetryDay(0);
        call.setRetryNo(1);
        call.setStatus("FAILED");
        call.setResult("not_answered");
        assertThat(bareService().shouldTrigger(call, cfg)).isFalse();
    }

    @Test
    void shouldTrigger_day0LastCancelled_true() {
        IntegrationConfig cfg = new IntegrationConfig();
        cfg.setAutocallRetryIntervals("60,120");
        AutoCall call = new AutoCall();
        call.setRetryDay(0);
        call.setRetryNo(2);
        call.setStatus("CANCELLED");
        call.setResult("cancelled");
        assertThat(bareService().shouldTrigger(call, cfg)).isTrue();
    }

    @Test
    void shouldTrigger_cancelledBeforeLastCall_false() {
        IntegrationConfig cfg = new IntegrationConfig();
        cfg.setAutocallRetryIntervals("60,120");
        AutoCall call = new AutoCall();
        call.setRetryDay(0);
        call.setRetryNo(1);
        call.setStatus("CANCELLED");
        call.setResult("cancelled");
        assertThat(bareService().shouldTrigger(call, cfg)).isFalse();
    }

    @Test
    void shouldTrigger_carrierError_false() {
        IntegrationConfig cfg = new IntegrationConfig();
        cfg.setAutocallRetryIntervals("60,120");
        AutoCall call = new AutoCall();
        call.setRetryDay(0);
        call.setRetryNo(2);
        call.setStatus("FAILED");
        call.setResult("error");
        assertThat(bareService().shouldTrigger(call, cfg)).isFalse();
    }

    @Test
    void shouldTrigger_day1_false() {
        IntegrationConfig cfg = new IntegrationConfig();
        cfg.setAutocallRetryIntervals("60,120");
        AutoCall call = new AutoCall();
        call.setRetryDay(1);
        call.setRetryNo(2);
        call.setStatus("FAILED");
        call.setResult("not_answered");
        assertThat(bareService().shouldTrigger(call, cfg)).isFalse();
    }

    @Test
    void shouldTrigger_customIntervals_usesSizeNotHardcoded3() {
        IntegrationConfig cfg = new IntegrationConfig();
        cfg.setAutocallRetryIntervals("30"); // 2 cuộc / ngày
        AutoCall call = new AutoCall();
        call.setRetryDay(0);
        call.setRetryNo(1);
        call.setStatus("FAILED");
        call.setResult("not_answered");
        assertThat(bareService().shouldTrigger(call, cfg)).isTrue();
        call.setRetryNo(0);
        assertThat(bareService().shouldTrigger(call, cfg)).isFalse();
    }

    @Test
    void parseAndResolve_fieldMap() {
        ShipmentOrder order = new ShipmentOrder();
        order.setOrderCode("CPN001");
        order.setReceiverName("Nguyen A");
        order.setDeliveryAddress("1 Le Loi");
        AutoCall call = new AutoCall();
        call.setRefId("ref-1");
        call.setRetryDay(0);
        call.setRetryNo(2);
        Map<String, Object> data = bareService()
            .buildTemplateData(
                "{\"customer_name\":\"receiverName\",\"ma_don\":\"orderCode\",\"addr\":\"deliveryAddress\",\"bad\":\"unknown\"}",
                order,
                call
            );
        assertThat(data)
            .containsEntry("customer_name", "Nguyen A")
            .containsEntry("ma_don", "CPN001")
            .containsEntry("addr", "1 Le Loi")
            .doesNotContainKey("bad");
    }

    private static GapOneAutocallZnsService bareService() {
        return new GapOneAutocallZnsService(null, null, null, null, null, null);
    }
}
