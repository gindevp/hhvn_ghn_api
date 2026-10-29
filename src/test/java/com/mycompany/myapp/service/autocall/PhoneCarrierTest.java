package com.mycompany.myapp.service.autocall;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class PhoneCarrierTest {

    @Test
    void mapsKnownPrefixes() {
        assertThat(PhoneCarrier.of("0981234567").code()).isEqualTo("VIETTEL");
        assertThat(PhoneCarrier.of("0321234567").label()).isEqualTo("Viettel");
        assertThat(PhoneCarrier.of("0912345678").code()).isEqualTo("VINAPHONE");
        assertThat(PhoneCarrier.of("0901234567").code()).isEqualTo("MOBIFONE");
        assertThat(PhoneCarrier.of("0921234567").code()).isEqualTo("VIETNAMOBILE");
        assertThat(PhoneCarrier.of("0991234567").code()).isEqualTo("GMOBILE");
        assertThat(PhoneCarrier.of("0871234567").code()).isEqualTo("ITEL");
        assertThat(PhoneCarrier.of("0551234567").code()).isEqualTo("REDDI");
    }

    @Test
    void acceptsPlus84AndUnknown() {
        assertThat(PhoneCarrier.of("+84981234567").code()).isEqualTo("VIETTEL");
        assertThat(PhoneCarrier.of("84901234567").code()).isEqualTo("MOBIFONE");
        assertThat(PhoneCarrier.of("0123456789").code()).isEqualTo("KHAC");
        assertThat(PhoneCarrier.of("abc").label()).isEqualTo("Khác");
        assertThat(PhoneCarrier.of(null).code()).isEqualTo("KHAC");
    }
}
