package com.mycompany.myapp.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.Serializable;
import java.time.Instant;
import java.time.LocalDate;

/**
 * Lịch chuyến nội bộ (master) — dùng khi {@code application.schedule.mode} = INTERNAL hoặc HYBRID.
 * {@code tripCode} là mã ổn định để chấm xe (map sang externalTripId trên board).
 */
@Entity
@Table(name = "vehicle_schedule_trip")
public class VehicleScheduleTrip implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @NotNull
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    @JoinColumn(name = "office_id", nullable = false)
    private Office office;

    @NotNull
    @Size(max = 60)
    @Column(name = "itinerary_code", length = 60, nullable = false)
    private String itineraryCode;

    @NotNull
    @Column(name = "service_date", nullable = false)
    private LocalDate serviceDate;

    @NotNull
    @Size(max = 60)
    @Column(name = "trip_code", length = 60, nullable = false, unique = true)
    private String tripCode;

    @Size(max = 30)
    @Column(name = "vehicle_plate", length = 30)
    private String vehiclePlate;

    @Size(max = 120)
    @Column(name = "driver_name", length = 120)
    private String driverName;

    @Size(max = 120)
    @Column(name = "route_label", length = 120)
    private String routeLabel;

    @NotNull
    @Column(name = "planned_depart_at", nullable = false)
    private Instant plannedDepartAt;

    @NotNull
    @Column(name = "active", nullable = false)
    private Boolean active = Boolean.TRUE;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Office getOffice() {
        return office;
    }

    public void setOffice(Office office) {
        this.office = office;
    }

    public String getItineraryCode() {
        return itineraryCode;
    }

    public void setItineraryCode(String itineraryCode) {
        this.itineraryCode = itineraryCode;
    }

    public LocalDate getServiceDate() {
        return serviceDate;
    }

    public void setServiceDate(LocalDate serviceDate) {
        this.serviceDate = serviceDate;
    }

    public String getTripCode() {
        return tripCode;
    }

    public void setTripCode(String tripCode) {
        this.tripCode = tripCode;
    }

    public String getVehiclePlate() {
        return vehiclePlate;
    }

    public void setVehiclePlate(String vehiclePlate) {
        this.vehiclePlate = vehiclePlate;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getRouteLabel() {
        return routeLabel;
    }

    public void setRouteLabel(String routeLabel) {
        this.routeLabel = routeLabel;
    }

    public Instant getPlannedDepartAt() {
        return plannedDepartAt;
    }

    public void setPlannedDepartAt(Instant plannedDepartAt) {
        this.plannedDepartAt = plannedDepartAt;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
}
