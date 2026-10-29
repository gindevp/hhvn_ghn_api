package com.mycompany.myapp.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * Singleton cấu hình nghiệp vụ báo giờ xe GHN.
 * {@code scheduleMode} null = dùng {@code application.schedule.mode} trong YAML.
 */
@Entity
@Table(name = "vehicle_report_policy")
public class VehicleReportPolicy implements Serializable {

    private static final long serialVersionUID = 1L;

    public static final long SINGLETON_ID = 1L;
    public static final int DEFAULT_LATE_MINUTES = 5;

    @Id
    private Long id;

    @NotNull
    @Column(name = "depart_photo_required", nullable = false)
    private Boolean departPhotoRequired = Boolean.FALSE;

    @NotNull
    @Column(name = "late_minutes", nullable = false)
    private Integer lateMinutes = DEFAULT_LATE_MINUTES;

    /** INTERNAL | CRM | HYBRID — null = theo YAML. */
    @Column(name = "schedule_mode", length = 16)
    private String scheduleMode;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Boolean getDepartPhotoRequired() {
        return departPhotoRequired;
    }

    public void setDepartPhotoRequired(Boolean departPhotoRequired) {
        this.departPhotoRequired = departPhotoRequired;
    }

    public Integer getLateMinutes() {
        return lateMinutes;
    }

    public void setLateMinutes(Integer lateMinutes) {
        this.lateMinutes = lateMinutes;
    }

    public String getScheduleMode() {
        return scheduleMode;
    }

    public void setScheduleMode(String scheduleMode) {
        this.scheduleMode = scheduleMode;
    }
}
