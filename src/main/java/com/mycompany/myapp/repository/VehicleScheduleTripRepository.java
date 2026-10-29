package com.mycompany.myapp.repository;

import com.mycompany.myapp.domain.VehicleScheduleTrip;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface VehicleScheduleTripRepository extends JpaRepository<VehicleScheduleTrip, Long> {
    Optional<VehicleScheduleTrip> findOneByTripCode(String tripCode);

    @Query(
        """
        select t from VehicleScheduleTrip t
        where t.active = true
          and t.office.id = :officeId
          and t.itineraryCode = :itineraryCode
          and t.serviceDate = :serviceDate
        order by t.plannedDepartAt asc
        """
    )
    List<VehicleScheduleTrip> findActiveForBoard(
        @Param("officeId") Long officeId,
        @Param("itineraryCode") String itineraryCode,
        @Param("serviceDate") LocalDate serviceDate
    );

    @Query(
        """
        select t from VehicleScheduleTrip t
        where (:officeId is null or t.office.id = :officeId)
          and (:fromDate is null or t.serviceDate >= :fromDate)
          and (:toDate is null or t.serviceDate <= :toDate)
          and (:itineraryCode is null or t.itineraryCode = :itineraryCode)
        order by t.serviceDate desc, t.plannedDepartAt asc
        """
    )
    List<VehicleScheduleTrip> findFiltered(
        @Param("officeId") Long officeId,
        @Param("fromDate") LocalDate fromDate,
        @Param("toDate") LocalDate toDate,
        @Param("itineraryCode") String itineraryCode
    );
}
