package com.mycompany.myapp.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Properties specific to GHN vehicle-report API.
 * <p>
 * Properties are configured in the {@code application.yml} file.
 */
@ConfigurationProperties(prefix = "application", ignoreUnknownFields = false)
public class ApplicationProperties {

    private final Liquibase liquibase = new Liquibase();
    private final Schedule schedule = new Schedule();

    public Liquibase getLiquibase() {
        return liquibase;
    }

    public Schedule getSchedule() {
        return schedule;
    }

    public static class Liquibase {

        private Boolean asyncStart = true;

        public Boolean getAsyncStart() {
            return asyncStart;
        }

        public void setAsyncStart(Boolean asyncStart) {
            this.asyncStart = asyncStart;
        }
    }

    /**
     * Nguồn lịch chuyến: INTERNAL | CRM | HYBRID.
     */
    public static class Schedule {

        public enum Mode {
            INTERNAL,
            CRM,
            HYBRID,
        }

        private Mode mode = Mode.INTERNAL;

        public Mode getMode() {
            return mode;
        }

        public void setMode(Mode mode) {
            this.mode = mode == null ? Mode.INTERNAL : mode;
        }

        public boolean usesInternal() {
            return mode == Mode.INTERNAL || mode == Mode.HYBRID;
        }

        public boolean usesCrm() {
            return mode == Mode.CRM || mode == Mode.HYBRID;
        }
    }
}
