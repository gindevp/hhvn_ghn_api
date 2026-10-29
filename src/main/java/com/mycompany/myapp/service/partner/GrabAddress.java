package com.mycompany.myapp.service.partner;

import java.text.Normalizer;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Địa chỉ gửi Grab Geo_poi_search: không Việt Nam / mã BC, prefix P./X./TP., có cityCode.
 * Chuẩn hoá cả địa chỉ dán từ Google Maps (Đ./Ng./P. phố, mã bưu chính).
 */
final class GrabAddress {

    private static final Pattern VIETNAM_TAIL = Pattern.compile("(?i)(?:\\s*,\\s*|\\s+)(việt nam|vietnam)\\s*$");
    private static final Pattern POSTAL_AFTER_PLACE = Pattern.compile("(?<=[\\p{L}.])\\s+\\d{4,6}\\b");
    private static final Pattern POSTAL_SEGMENT = Pattern.compile("\\s*,\\s*\\d{4,6}\\b");
    private static final Pattern TRAILING_NOTE = Pattern.compile("\\s*[.(]\\s*[^)]{0,100}\\)\\s*$");
    private static final Pattern FIRST_COMMA = Pattern.compile("\\s*,\\s*");
    private static final Map<Pattern, String> PREFIX = new LinkedHashMap<>();
    private static final Map<String, String> CITY = new LinkedHashMap<>();

    static {
        PREFIX.put(Pattern.compile("(?i)\\bthành phố hồ chí minh\\b"), "TP.Hồ Chí Minh");
        PREFIX.put(Pattern.compile("(?i)\\bthành phố hà nội\\b"), "TP.Hà Nội");
        PREFIX.put(Pattern.compile("(?i)\\bthành phố đà nẵng\\b"), "TP.Đà Nẵng");
        PREFIX.put(Pattern.compile("(?i)\\bthành phố cần thơ\\b"), "TP.Cần Thơ");
        PREFIX.put(Pattern.compile("(?i)\\bthành phố hải phòng\\b"), "TP.Hải Phòng");
        PREFIX.put(Pattern.compile("(?i)\\bthành phố nam định\\b"), "TP.Nam Định");
        PREFIX.put(Pattern.compile("(?i)\\bthành phố thái bình\\b"), "TP.Thái Bình");
        PREFIX.put(Pattern.compile("(?i)\\bthành phố ninh bình\\b"), "TP.Ninh Bình");
        PREFIX.put(Pattern.compile("(?i)\\bthành phố hoa lư\\b"), "TP.Hoa Lư");
        PREFIX.put(Pattern.compile("(?i)\\bthành phố\\s+"), "TP.");
        PREFIX.put(Pattern.compile("(?i)\\btỉnh\\s+"), "");
        PREFIX.put(Pattern.compile("(?i)\\bthị xã\\s+"), "TX.");
        PREFIX.put(Pattern.compile("(?i)\\bthị trấn\\s+"), "TT.");
        PREFIX.put(Pattern.compile("(?i)\\bphường\\s+"), "P.");
        PREFIX.put(Pattern.compile("(?i)\\bxã\\s+"), "X.");
        PREFIX.put(Pattern.compile("(?i)\\bquận\\s+"), "Q.");
        PREFIX.put(Pattern.compile("(?i)\\bhuyện\\s+"), "H.");
        CITY.put("ho chi minh", "SGN");
        CITY.put("sai gon", "SGN");
        CITY.put("tphcm", "SGN");
        CITY.put("hcm", "SGN");
        CITY.put("ha noi", "HAN");
        CITY.put("nam dinh", "HAN");
        CITY.put("ninh binh", "HAN");
        CITY.put("hoa lu", "HAN");
        CITY.put("thai binh", "HAN");
        CITY.put("hung yen", "HAN");
        CITY.put("phu tho", "HAN");
        CITY.put("viet tri", "HAN");
        CITY.put("yen bai", "HAN");
        CITY.put("lao cai", "HAN");
        CITY.put("hai phong", "HPH");
        CITY.put("da nang", "DAD");
        CITY.put("can tho", "VCA");
        CITY.put("hue", "HUI");
        CITY.put("nha trang", "CXR");
        CITY.put("khanh hoa", "CXR");
        CITY.put("da lat", "DLI");
        CITY.put("lam dong", "DLI");
        CITY.put("vinh", "VII");
        CITY.put("nghe an", "VII");
        CITY.put("thanh hoa", "THD");
        CITY.put("quy nhon", "UIH");
        CITY.put("binh dinh", "UIH");
        CITY.put("buon ma thuot", "BMV");
        CITY.put("dak lak", "BMV");
        CITY.put("pleiku", "PXU");
        CITY.put("gia lai", "PXU");
        CITY.put("phu quoc", "PQC");
        CITY.put("ha long", "VDO");
        CITY.put("quang ninh", "VDO");
    }

    private GrabAddress() {}

    static String format(String raw) {
        if (raw == null) {
            return "";
        }
        String out = raw.trim();
        out = VIETNAM_TAIL.matcher(out).replaceAll("");
        out = POSTAL_AFTER_PLACE.matcher(out).replaceAll("");
        out = POSTAL_SEGMENT.matcher(out).replaceAll("");
        out = TRAILING_NOTE.matcher(out).replaceAll("");
        for (Map.Entry<Pattern, String> e : PREFIX.entrySet()) {
            out = e.getKey().matcher(out).replaceAll(e.getValue());
        }
        return out.replaceAll("\\s+,", ",").replaceAll(",\\s+", ", ").replaceAll("\\s{2,}", " ").replaceAll("^,\\s*|\\s*,$", "").trim();
    }

    /** Số nhà + đường: đoạn trước dấu phẩy đầu. */
    static String keywords(String formatted) {
        String addr = format(formatted);
        if (addr.isBlank()) {
            return "";
        }
        return FIRST_COMMA.split(addr, 2)[0].trim();
    }

    static String cityCode(String... texts) {
        String joined = "";
        if (texts != null) {
            joined = String.join(" ", texts);
        }
        String fold = fold(joined);
        if (fold.isBlank()) {
            return null;
        }
        String best = null;
        int bestLen = -1;
        for (Map.Entry<String, String> e : CITY.entrySet()) {
            if (fold.contains(e.getKey()) && e.getKey().length() > bestLen) {
                best = e.getValue();
                bestLen = e.getKey().length();
            }
        }
        return best;
    }

    static String cityCodeOr(String fallback, String... texts) {
        String found = cityCode(texts);
        return found != null ? found : fallback;
    }

    static String itineraryCity(String point) {
        if (point == null || point.isBlank()) {
            return null;
        }
        return switch (point.trim().toUpperCase(Locale.ROOT)) {
            case "BC", "GA", "HD", "HĐ", "PHOCO", "HN" -> "HAN";
            case "ND", "NĐ", "TB", "YB", "PT", "TC", "NB", "VT" -> "HAN";
            default -> null;
        };
    }

    private static String fold(String s) {
        String n = Normalizer.normalize(s == null ? "" : s, Normalizer.Form.NFD);
        n = n.replace('đ', 'd').replace('Đ', 'd');
        Matcher m = Pattern.compile("\\p{M}").matcher(n);
        return m.replaceAll("").toLowerCase(Locale.ROOT);
    }
}
