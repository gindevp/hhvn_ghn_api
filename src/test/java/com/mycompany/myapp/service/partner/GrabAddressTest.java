package com.mycompany.myapp.service.partner;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class GrabAddressTest {

    @Test
    void formatAndCity() {
        assertThat(GrabAddress.format("12 Nguyễn Trãi, Phường Khương Trung, Hà Nội, Việt Nam")).isEqualTo(
            "12 Nguyễn Trãi, P.Khương Trung, Hà Nội"
        );
        assertThat(GrabAddress.keywords("12 Nguyễn Trãi, P.Khương Trung, TP.Hà Nội")).isEqualTo("12 Nguyễn Trãi");
        assertThat(GrabAddress.cityCode("12 Nguyễn Trãi, P.Khương Trung, Hà Nội")).isEqualTo("HAN");
        assertThat(GrabAddress.cityCode("1060 Nguyễn Văn Linh, Phường Tân Hưng, Thành phố Hồ Chí Minh")).isEqualTo("SGN");
        assertThat(GrabAddress.itineraryCity("PHOCO")).isEqualTo("HAN");
        assertThat(GrabAddress.format("1060 Nguyễn Văn Linh, Phường Tân Hưng, Thành phố Hồ Chí Minh")).isEqualTo(
            "1060 Nguyễn Văn Linh, P.Tân Hưng, TP.Hồ Chí Minh"
        );
    }

    @Test
    void formatGoogleMapsPaste() {
        assertThat(GrabAddress.format("38 Ng. 133 - Thái Hà, Đống Đa, Hà Nội 100000, Việt Nam")).isEqualTo(
            "38 Ng. 133 - Thái Hà, Đống Đa, Hà Nội"
        );
        assertThat(GrabAddress.format("239 P. Quan Nhân, Thanh Xuân, Hà Nội, Việt Nam")).isEqualTo("239 P. Quan Nhân, Thanh Xuân, Hà Nội");
        assertThat(GrabAddress.format("31 Đ. Lê Văn Lương, Thanh Xuân, Hà Nội 100000, Vietnam")).isEqualTo(
            "31 Đ. Lê Văn Lương, Thanh Xuân, Hà Nội"
        );
        assertThat(GrabAddress.cityCode("38 Ng. 133 - Thái Hà, Đống Đa, Hà Nội 100000, Việt Nam")).isEqualTo("HAN");
        assertThat(GrabAddress.keywords("38 Ng. 133 - Thái Hà, Đống Đa, Hà Nội")).isEqualTo("38 Ng. 133 - Thái Hà");
    }

    @Test
    void formatStripsProvinceWordAndNote() {
        assertThat(
            GrabAddress.format("Số 6 đường Lê Hồng Phong, phường Vân Giang TP Ninh Bình cũ, Tỉnh Ninh Bình.(toà nhà Bình An Nhiên)")
        ).isEqualTo("Số 6 đường Lê Hồng Phong, P.Vân Giang TP Ninh Bình cũ, Ninh Bình");
        assertThat(GrabAddress.cityCode("Tỉnh Ninh Bình")).isEqualTo("HAN");
    }
}
