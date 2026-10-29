package com.mycompany.myapp.service.autocall;

/**
 * Nhà mạng gốc theo đầu số SĐT VN 10 số (032–099). Không tra cứu chuyển mạng giữ số.
 */
public final class PhoneCarrier {

    public static final String KHAC = "KHAC";

    public record Info(String code, String label) {}

    private PhoneCarrier() {}

    public static Info of(String phone) {
        String prefix = prefix3(phone);
        if (prefix == null) {
            return new Info(KHAC, "Khác");
        }
        return switch (prefix) {
            case "032", "033", "034", "035", "036", "037", "038", "039", "086", "096", "097", "098" -> new Info("VIETTEL", "Viettel");
            case "081", "082", "083", "084", "085", "088", "091", "094" -> new Info("VINAPHONE", "Vinaphone");
            case "070", "076", "077", "078", "079", "089", "090", "093" -> new Info("MOBIFONE", "Mobifone");
            case "052", "056", "058", "092" -> new Info("VIETNAMOBILE", "Vietnamobile");
            case "059", "099" -> new Info("GMOBILE", "Gmobile");
            case "087" -> new Info("ITEL", "iTel");
            case "055" -> new Info("REDDI", "Reddi");
            default -> new Info(KHAC, "Khác");
        };
    }

    public static String code(String phone) {
        return of(phone).code();
    }

    public static String label(String phone) {
        return of(phone).label();
    }

    /** Ba số đầu dạng 09x / 03x sau khi chuẩn hoá 0xxxxxxxxx. */
    static String prefix3(String raw) {
        if (raw == null) {
            return null;
        }
        String d = raw.replaceAll("\\D", "");
        if (d.startsWith("84") && d.length() >= 11) {
            d = "0" + d.substring(2);
        }
        if (d.length() < 3) {
            return null;
        }
        if (!d.startsWith("0")) {
            d = "0" + d;
        }
        return d.substring(0, 3);
    }
}
