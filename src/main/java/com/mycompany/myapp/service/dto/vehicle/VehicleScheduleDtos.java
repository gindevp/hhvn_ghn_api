package com.mycompany.myapp.service.dto.vehicle;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

public final class VehicleScheduleDtos {

    private VehicleScheduleDtos() {}

    public record ScheduleTrip(
        Long id,
        Long officeId,
        String officeCode,
        String officeName,
        String itineraryCode,
        LocalDate serviceDate,
        String tripCode,
        String vehiclePlate,
        String driverName,
        String routeLabel,
        Instant plannedDepartAt,
        boolean active
    ) {}

    public record ScheduleTripRequest(
        Long officeId,
        String itineraryCode,
        LocalDate serviceDate,
        String tripCode,
        String vehiclePlate,
        String driverName,
        String routeLabel,
        Instant plannedDepartAt,
        Boolean active
    ) {}

    public record ScheduleModeInfo(String mode, boolean usesInternal, boolean usesCrm) {}

    public record ScheduleList(List<ScheduleTrip> items, ScheduleModeInfo mode) {}
}
