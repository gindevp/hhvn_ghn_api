package com.mycompany.myapp.web.rest;

import com.mycompany.myapp.service.dto.vehicle.VehicleScheduleDtos;
import com.mycompany.myapp.service.vehicle.VehicleScheduleService;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/vehicle-schedules")
public class VehicleScheduleResource {

    private final VehicleScheduleService vehicleScheduleService;

    public VehicleScheduleResource(VehicleScheduleService vehicleScheduleService) {
        this.vehicleScheduleService = vehicleScheduleService;
    }

    @GetMapping("/mode")
    public VehicleScheduleDtos.ScheduleModeInfo mode() {
        return vehicleScheduleService.mode();
    }

    @GetMapping
    public VehicleScheduleDtos.ScheduleList list(
        @RequestParam(required = false) Long officeId,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
        @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to,
        @RequestParam(required = false) String itineraryCode
    ) {
        return vehicleScheduleService.list(officeId, from, to, itineraryCode);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public VehicleScheduleDtos.ScheduleTrip create(@RequestBody VehicleScheduleDtos.ScheduleTripRequest body) {
        return vehicleScheduleService.create(body);
    }

    @PutMapping("/{id}")
    public VehicleScheduleDtos.ScheduleTrip update(@PathVariable Long id, @RequestBody VehicleScheduleDtos.ScheduleTripRequest body) {
        return vehicleScheduleService.update(id, body);
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id) {
        vehicleScheduleService.delete(id);
    }
}
