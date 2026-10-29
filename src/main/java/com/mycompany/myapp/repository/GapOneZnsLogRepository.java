package com.mycompany.myapp.repository;

import com.mycompany.myapp.domain.GapOneZnsLog;
import java.util.Collection;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface GapOneZnsLogRepository extends JpaRepository<GapOneZnsLog, Long>, JpaSpecificationExecutor<GapOneZnsLog> {
    List<GapOneZnsLog> findByMessageIdOrderByCreatedAtDesc(String messageId);

    boolean existsByOrderCodeAndSourceAndKindAndResultIn(String orderCode, String source, String kind, Collection<String> results);
}
