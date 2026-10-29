package com.mycompany.myapp.service.customer;

import static org.assertj.core.api.Assertions.assertThat;

import java.math.BigDecimal;
import java.util.List;
import org.junit.jupiter.api.Test;

class CustomerOwnerServiceTest {

    @Test
    void packagesFromNoteTags() {
        String note =
            "[LOAI]Quần áo|Khác[/LOAI]\n[TENHANG]|Bình hoa[/TENHANG]\n[CUOC]20000,15000[/CUOC]\n[SLQTY]2,1[/SLQTY]\n[PKGKG]1.5,3[/PKGKG]";
        List<CustomerOwnerService.OwnedPackage> pkgs = CustomerOwnerService.packages(note, 2, BigDecimal.valueOf(35000));
        assertThat(pkgs).hasSize(2);
        assertThat(pkgs.get(0).label()).isEqualTo("Quần áo");
        assertThat(pkgs.get(0).itemQty()).isEqualTo(2);
        assertThat(pkgs.get(0).fare()).isEqualByComparingTo("20000");
        assertThat(pkgs.get(1).label()).isEqualTo("Bình hoa");
        assertThat(pkgs.get(1).weightKg()).isEqualByComparingTo("3");
    }

    @Test
    void noTagsGivesSinglePackage() {
        List<CustomerOwnerService.OwnedPackage> pkgs = CustomerOwnerService.packages("Gọi trước khi giao", 3, BigDecimal.valueOf(50000));
        assertThat(pkgs).hasSize(1);
        assertThat(pkgs.get(0).itemQty()).isEqualTo(3);
        assertThat(pkgs.get(0).fare()).isEqualByComparingTo("50000");
    }
}
