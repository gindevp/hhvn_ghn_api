package com.mycompany.myapp.service.invoice;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyCollection;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.mycompany.myapp.domain.Office;
import com.mycompany.myapp.domain.ShipmentOrder;
import com.mycompany.myapp.domain.enumeration.OrderStatus;
import com.mycompany.myapp.domain.enumeration.PaymentTerm;
import com.mycompany.myapp.repository.IntegrationConfigRepository;
import com.mycompany.myapp.repository.OrderEventRepository;
import com.mycompany.myapp.repository.ShipmentOrderRepository;
import com.mycompany.myapp.service.day.DayClosureGuard;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.junit.jupiter.api.Test;

class TmpDryRunTest {

    @Test
    void dryRun() throws Exception {
        ShipmentOrderRepository repo = mock(ShipmentOrderRepository.class);
        OrderEventRepository events = mock(OrderEventRepository.class);
        MisaMeInvoiceClient client = mock(MisaMeInvoiceClient.class);
        when(client.isEnabled()).thenReturn(true);
        when(client.getInvSeries()).thenReturn("1C26MYY");
        when(client.getSignType()).thenReturn(5);
        List<ObjectNode> sent = new ArrayList<>();
        when(client.publish(any(ObjectNode.class))).thenAnswer(inv -> {
            sent.add(inv.getArgument(0));
            return new MisaMeInvoiceClient.PublishResult(true, false, "DRYRUN-TX", "DRYRUN-NO", "1C26MYY", "DRYRUN", "{}");
        });
        ObjectMapper om = new ObjectMapper();
        MeInvoiceIssueService s = new MeInvoiceIssueService(
            repo,
            events,
            mock(IntegrationConfigRepository.class),
            mock(DayClosureGuard.class),
            client,
            om,
            true
        );

        Office bc = new Office();
        bc.setCode("VP_BC");
        bc.setName("31A Nguyễn Quốc Trị - Hà Nội");
        bc.setAddress("Số 31A, đường Nguyễn Quốc Trị, Phường Yên Hoà, Quận Cầu Giấy, Thành phố Hà Nội");
        Office nd = new Office();
        nd.setCode("VP_ND_77");
        nd.setName("77 Trần Anh Tông - Nam Định");
        nd.setAddress("Số 77, đường Trần Anh Tông, Phường Lộc Hòa, Thành phố Nam Định, Tỉnh Nam Định");

        ShipmentOrder o = new ShipmentOrder();
        o.setId(2033L);
        o.setOrderCode("BC0210JFV7");
        o.setStatus(OrderStatus.DELIVERED);
        o.setPaymentTerm(PaymentTerm.NHAN_TRA);
        o.setOnCredit(false);
        o.setCodAmount(BigDecimal.ZERO);
        o.setFareAmount(new BigDecimal("35000"));
        o.setPaidAmount(new BigDecimal("35000"));
        o.setGoodsFareAmount(new BigDecimal("35000"));
        o.setPickupFeeAmount(BigDecimal.ZERO);
        o.setDeliveryFeeAmount(BigDecimal.ZERO);
        o.setCodFeeAmount(BigDecimal.ZERO);
        o.setDeclaredFeeAmount(BigDecimal.ZERO);
        o.setDiscountAmount(BigDecimal.ZERO);
        o.setSenderName("C MAI");
        o.setSenderPhone("0903419914");
        o.setReceiverName("C LIÊN");
        o.setReceiverPhone("0986469993");
        o.setFromOffice(bc);
        o.setToOffice(nd);
        o.setFinalToOffice(nd);
        o.setPickedUpAt(Instant.parse("2026-10-02T04:00:58Z"));
        o.setInvoiceRequested(false);
        o.setInvoiceStatus("SKIPPED");
        o.setInvoiceError("invoiceRequested=false");
        when(repo.findById(2033L)).thenReturn(Optional.of(o));
        List<Object[]> delivered = new ArrayList<>();
        delivered.add(new Object[] { 2033L, Instant.parse("2026-10-02T12:53:02Z") });
        when(events.latestEventAtByOrderIds(anyList(), anyCollection())).thenReturn(delivered);

        String result = s.autoIssueOne(2033L);
        StringBuilder out = new StringBuilder();
        out
            .append("result=")
            .append(result)
            .append(" type=")
            .append(o.getInvoiceType())
            .append(" gross=")
            .append(o.getInvoiceGrossAmount())
            .append(" net=")
            .append(o.getInvoiceNetAmount())
            .append(" vat=")
            .append(o.getInvoiceVatAmount())
            .append('\n');
        for (ObjectNode b : sent) {
            out.append(om.writerWithDefaultPrettyPrinter().writeValueAsString(b)).append('\n');
        }
        Files.writeString(Path.of(System.getProperty("java.io.tmpdir"), "misa-dryrun.txt"), out, StandardCharsets.UTF_8);
    }
}
