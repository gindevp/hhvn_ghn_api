package com.mycompany.myapp.service.partner;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;

class GapOneZnsClientTest {

    @Test
    void parseOasArray() throws Exception {
        List<Map<String, String>> rows = GapOneZnsClient.parseOas("[{\"oa_id\":\"2275071494300819170\",\"oa_name\":\"GAPIT\"}]");
        assertThat(rows).hasSize(1);
        assertThat(rows.get(0).get("oaId")).isEqualTo("2275071494300819170");
        assertThat(rows.get(0).get("oaName")).isEqualTo("GAPIT");
    }

    @Test
    void parseOasWrappedData() throws Exception {
        List<Map<String, String>> rows = GapOneZnsClient.parseOas("{\"data\":[{\"oaId\":\"1\",\"name\":\"OA A\"}]}");
        assertThat(rows).hasSize(1);
        assertThat(rows.get(0).get("oaId")).isEqualTo("1");
        assertThat(rows.get(0).get("oaName")).isEqualTo("OA A");
    }

    @Test
    void parseOasEmpty() throws Exception {
        assertThat(GapOneZnsClient.parseOas("")).isEmpty();
        assertThat(GapOneZnsClient.parseOas("{}")).isEmpty();
    }

    @Test
    void normalizePhone() {
        assertThat(GapOneZnsClient.normalizePhone("0912345678")).isEqualTo("84912345678");
        assertThat(GapOneZnsClient.normalizePhone("84912345678")).isEqualTo("84912345678");
        assertThat(GapOneZnsClient.normalizePhone("+84 912 345 678")).isEqualTo("84912345678");
        assertThat(GapOneZnsClient.normalizePhone("abc")).isNull();
    }

    @Test
    void parseTemplates() throws Exception {
        String raw =
            "[{\"oa_id\":\"1\",\"template_id\":\"225212\",\"name\":\"Cam on\",\"params\":\"customer_name,OTP\",\"template_object\":{\"status\":\"ENABLE\"}}]";
        var rows = GapOneZnsClient.parseTemplates(raw);
        assertThat(rows).hasSize(1);
        assertThat(rows.get(0).get("templateId")).isEqualTo("225212");
        assertThat(rows.get(0).get("name")).isEqualTo("Cam on");
        assertThat(rows.get(0).get("params")).isEqualTo("customer_name,OTP");
        assertThat(rows.get(0).get("status")).isEqualTo("ENABLE");
    }
}
