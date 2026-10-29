# BE_ghn — GHN báo giờ xe đến/đi

Spring Boot API tách từ CPN, tập trung **báo giờ xe đến/rời VP** + nền tảng tài khoản / nhóm quyền / phiên đăng nhập / master.

## Chạy local

- Java 21+, MySQL 8
- Port mặc định: **7082**
- DB: `cpn_ghn` (tạo tự động nếu thiếu)

```bash
./mvnw -Pdev spring-boot:run
```

FE_ghn trỏ `VITE_API_BASE_URL=http://localhost:7082`.

## Nguồn lịch chuyến (`application.schedule.mode`)

| Mode | Ý nghĩa |
|------|---------|
| `INTERNAL` (mặc định) | Chỉ master `vehicle_schedule_trip` (tab Lịch chuyến trên FE) |
| `CRM` | Chỉ CRM/VTHK Limousine như CPN |
| `HYBRID` | Gộp cả hai |

Cấu hình trong `src/main/resources/config/application.yml`:

```yaml
application:
  schedule:
    mode: INTERNAL   # hoặc CRM | HYBRID
```

API master lịch: `/api/vehicle-schedules`.

## Role

Builtin seed: **Admin (AD)** + **Điều phối (DH)**. Cả hai có quyền `bao-gio-xe`; master/tài khoản/nhóm quyền/phiên chủ yếu Admin.

## Ảnh khi báo rời VP

Mặc định **không bắt buộc**. Web/webapp có thể upload (webapp thêm chụp camera). Bật bắt buộc qua `PUT /api/vehicle-events/photo-policy` (quyền cấu hình).

## Lưu ý

- Repo này vẫn chứa nhiều module CPN (đơn/POD/…) trong classpath; sản phẩm GHN chỉ dùng surface báo giờ xe + auth/master.
- Không dùng chung DB/port với `BE` CPN (7080 / `cpn`).
