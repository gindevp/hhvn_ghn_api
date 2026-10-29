package com.mycompany.myapp.service.vehicle;

import com.mycompany.myapp.config.ApplicationProperties;
import com.mycompany.myapp.domain.Office;
import com.mycompany.myapp.domain.VehicleReportPolicy;
import com.mycompany.myapp.domain.VehicleScheduleTrip;
import com.mycompany.myapp.repository.OfficeRepository;
import com.mycompany.myapp.repository.VehicleReportPolicyRepository;
import com.mycompany.myapp.repository.VehicleScheduleTripRepository;
import com.mycompany.myapp.security.ScreenKey;
import com.mycompany.myapp.security.StaffAccessService;
import com.mycompany.myapp.service.dto.vehicle.VehicleScheduleDtos;
import com.mycompany.myapp.web.rest.errors.BadRequestAlertException;
import java.time.LocalDate;
import java.util.List;
import java.util.Locale;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class VehicleScheduleService {

    private static final String ENTITY = "vehicleScheduleTrip";

    private final VehicleScheduleTripRepository repository;
    private final OfficeRepository officeRepository;
    private final StaffAccessService staffAccessService;
    private final ApplicationProperties.Schedule scheduleYaml;
    private final VehicleReportPolicyRepository policyRepository;

    public VehicleScheduleService(
        VehicleScheduleTripRepository repository,
        OfficeRepository officeRepository,
        StaffAccessService staffAccessService,
        ApplicationProperties applicationProperties,
        VehicleReportPolicyRepository policyRepository
    ) {
        this.repository = repository;
        this.officeRepository = officeRepository;
        this.staffAccessService = staffAccessService;
        this.scheduleYaml = applicationProperties.getSchedule();
        this.policyRepository = policyRepository;
    }

    @Transactional(readOnly = true)
    public VehicleScheduleDtos.ScheduleModeInfo mode() {
        ApplicationProperties.Schedule.Mode mode = resolvedMode();
        boolean internal = mode == ApplicationProperties.Schedule.Mode.INTERNAL || mode == ApplicationProperties.Schedule.Mode.HYBRID;
        boolean crm = mode == ApplicationProperties.Schedule.Mode.CRM || mode == ApplicationProperties.Schedule.Mode.HYBRID;
        return new VehicleScheduleDtos.ScheduleModeInfo(mode.name(), internal, crm);
    }

    private ApplicationProperties.Schedule.Mode resolvedMode() {
        String fromDb = policyRepository
            .findById(VehicleReportPolicy.SINGLETON_ID)
            .map(VehicleReportPolicy::getScheduleMode)
            .orElse(null);
        if (fromDb != null && !fromDb.isBlank()) {
            try {
                return ApplicationProperties.Schedule.Mode.valueOf(fromDb.trim().toUpperCase(Locale.ROOT));
            } catch (IllegalArgumentException ignored) {
                // fall through
            }
        }
        return scheduleYaml.getMode();
    }

    @Transactional(readOnly = true)
    public VehicleScheduleDtos.ScheduleList list(Long officeId, LocalDate from, LocalDate to, String itineraryCode) {
        staffAccessService.requireScreenRead(ScreenKey.MASTER, ScreenKey.BAO_GIO_XE);
        List<VehicleScheduleDtos.ScheduleTrip> items = repository
            .findFiltered(officeId, from, to, blankToNull(itineraryCode))
            .stream()
            .map(this::toDto)
            .toList();
        return new VehicleScheduleDtos.ScheduleList(items, mode());
    }

    public VehicleScheduleDtos.ScheduleTrip create(VehicleScheduleDtos.ScheduleTripRequest req) {
        staffAccessService.requireScreenWrite(ScreenKey.MASTER);
        VehicleScheduleTrip row = fromRequest(new VehicleScheduleTrip(), req, true);
        return toDto(repository.save(row));
    }

    public VehicleScheduleDtos.ScheduleTrip update(Long id, VehicleScheduleDtos.ScheduleTripRequest req) {
        staffAccessService.requireScreenWrite(ScreenKey.MASTER);
        VehicleScheduleTrip row = repository
            .findById(id)
            .orElseThrow(() -> new BadRequestAlertException("Không tìm thấy lịch chuyến", ENTITY, "notFound"));
        fromRequest(row, req, false);
        return toDto(repository.save(row));
    }

    public void delete(Long id) {
        staffAccessService.requireScreenWrite(ScreenKey.MASTER);
        if (!repository.existsById(id)) {
            throw new BadRequestAlertException("Không tìm thấy lịch chuyến", ENTITY, "notFound");
        }
        repository.deleteById(id);
    }

    private VehicleScheduleTrip fromRequest(VehicleScheduleTrip row, VehicleScheduleDtos.ScheduleTripRequest req, boolean creating) {
        if (req == null) {
            throw new BadRequestAlertException("Thiếu dữ liệu", ENTITY, "bodyRequired");
        }
        if (req.officeId() == null) {
            throw new BadRequestAlertException("Chưa chọn văn phòng", ENTITY, "officeRequired");
        }
        if (blankToNull(req.itineraryCode()) == null) {
            throw new BadRequestAlertException("Chưa chọn lộ trình", ENTITY, "itineraryRequired");
        }
        if (req.serviceDate() == null) {
            throw new BadRequestAlertException("Chưa chọn ngày", ENTITY, "dateRequired");
        }
        if (req.plannedDepartAt() == null) {
            throw new BadRequestAlertException("Chưa có giờ xuất bến", ENTITY, "departRequired");
        }
        final String tripCode = blankToNull(req.tripCode()) != null
            ? blankToNull(req.tripCode())
            : "INT-" + req.officeId() + "-" + System.currentTimeMillis() % 1_000_000;
        repository
            .findOneByTripCode(tripCode)
            .filter(existing -> creating || !existing.getId().equals(row.getId()))
            .ifPresent(existing -> {
                throw new BadRequestAlertException("Mã chuyến đã tồn tại: " + tripCode, ENTITY, "tripCodeExists");
            });

        Office office = officeRepository
            .findById(req.officeId())
            .orElseThrow(() -> new BadRequestAlertException("Không tìm thấy văn phòng", ENTITY, "officeNotFound"));

        row.setOffice(office);
        row.setItineraryCode(req.itineraryCode().trim());
        row.setServiceDate(req.serviceDate());
        row.setTripCode(tripCode);
        row.setVehiclePlate(blankToNull(req.vehiclePlate()));
        row.setDriverName(blankToNull(req.driverName()));
        row.setRouteLabel(blankToNull(req.routeLabel()));
        row.setPlannedDepartAt(req.plannedDepartAt());
        row.setActive(req.active() == null ? Boolean.TRUE : req.active());
        return row;
    }

    private VehicleScheduleDtos.ScheduleTrip toDto(VehicleScheduleTrip t) {
        Office o = t.getOffice();
        return new VehicleScheduleDtos.ScheduleTrip(
            t.getId(),
            o != null ? o.getId() : null,
            o != null ? o.getCode() : null,
            o != null ? o.getName() : null,
            t.getItineraryCode(),
            t.getServiceDate(),
            t.getTripCode(),
            t.getVehiclePlate(),
            t.getDriverName(),
            t.getRouteLabel(),
            t.getPlannedDepartAt(),
            Boolean.TRUE.equals(t.getActive())
        );
    }

    private static String blankToNull(String s) {
        if (s == null) {
            return null;
        }
        String t = s.trim();
        return t.isEmpty() ? null : t;
    }
}
