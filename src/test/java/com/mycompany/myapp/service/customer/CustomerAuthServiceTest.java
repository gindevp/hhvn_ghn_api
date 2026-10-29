package com.mycompany.myapp.service.customer;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.mycompany.myapp.domain.IntegrationConfig;
import com.mycompany.myapp.repository.IntegrationConfigRepository;
import com.mycompany.myapp.repository.ShipmentOrderRepository;
import com.mycompany.myapp.service.partner.GapOneZnsClient;
import com.mycompany.myapp.service.partner.GapOneZnsLogService;
import java.time.Instant;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.web.server.ResponseStatusException;

class CustomerAuthServiceTest {

    private IntegrationConfig cfg;
    private GapOneZnsClient zns;
    private CustomerAuthService service;

    @BeforeEach
    void setUp() {
        cfg = new IntegrationConfig();
        cfg.setGaponeLoginOtpTestPhones("0393883210");
        cfg.setGaponeLoginOtpTestCode("123456");
        IntegrationConfigRepository configs = mock(IntegrationConfigRepository.class);
        when(configs.findAll()).thenReturn(List.of(cfg));
        ShipmentOrderRepository orders = mock(ShipmentOrderRepository.class);
        when(orders.findLatestSenderNames(any(), any())).thenReturn(List.of("Nguyễn Văn A"));
        zns = mock(GapOneZnsClient.class);
        service = new CustomerAuthService(configs, orders, zns, mock(GapOneZnsLogService.class), "secret");
    }

    @Test
    void testPhoneLogsInWithFixedCodeWithoutSendingZns() {
        service.sendOtp("+84 393 883 210", "1.1.1.1");
        verify(zns, never()).sendZns(any(), any(), any(), any(), any());

        CustomerAuthService.LoginResult r = service.verifyOtp("0393883210", "123456");

        assertThat(r.phone()).isEqualTo("0393883210");
        assertThat(r.name()).isEqualTo("Nguyễn Văn A");
        assertThat(service.phoneOf(r.token())).isEqualTo("0393883210");
    }

    @Test
    void wrongCodeRejectedAndCodeIsSingleUse() {
        service.sendOtp("0393883210", null);
        assertThatThrownBy(() -> service.verifyOtp("0393883210", "000000")).isInstanceOf(ResponseStatusException.class);
        service.verifyOtp("0393883210", "123456");
        assertThatThrownBy(() -> service.verifyOtp("0393883210", "123456")).isInstanceOf(ResponseStatusException.class);
    }

    @Test
    void resendBlockedDuringCooldown() {
        service.sendOtp("0393883210", null);
        assertThatThrownBy(() -> service.sendOtp("0393883210", null)).isInstanceOf(ResponseStatusException.class);
    }

    @Test
    void otherPhoneNeedsOtpConfigEnabled() {
        assertThatThrownBy(() -> service.sendOtp("0912345678", null)).isInstanceOf(ResponseStatusException.class);
        verify(zns, never()).sendZns(any(), any(), any(), any(), any());
    }

    @Test
    void tamperedOrExpiredTokenRejected() {
        String token = service.issueToken("0393883210", Instant.now().plusSeconds(60));
        assertThat(service.phoneOf(token)).isEqualTo("0393883210");
        assertThat(service.phoneOf(token.substring(0, token.length() - 2) + "xx")).isNull();
        assertThat(service.phoneOf(service.issueToken("0393883210", Instant.now().minusSeconds(1)))).isNull();
        assertThat(service.phoneOf("not-a-token")).isNull();
    }

    @Test
    void invalidPhoneRejected() {
        assertThatThrownBy(() -> service.sendOtp("0123", null)).isInstanceOf(ResponseStatusException.class);
        assertThat(CustomerAuthService.normalizePhone("84393883210")).isEqualTo("0393883210");
    }
}
