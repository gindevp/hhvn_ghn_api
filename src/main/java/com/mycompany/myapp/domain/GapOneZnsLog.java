package com.mycompany.myapp.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.io.Serializable;
import java.time.Instant;

/** Nhật ký gửi thử ZNS (SEND) và delivery callback GapOne (CALLBACK). */
@Entity
@Table(name = "gapone_zns_log")
public class GapOneZnsLog implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotNull
    @Column(name = "created_at", nullable = false)
    private Instant createdAt;

    @NotNull
    @Size(max = 16)
    @Column(name = "kind", length = 16, nullable = false)
    private String kind;

    @NotNull
    @Size(max = 16)
    @Column(name = "result", length = 16, nullable = false)
    private String result;

    @Size(max = 80)
    @Column(name = "request_id", length = 80)
    private String requestId;

    @Size(max = 80)
    @Column(name = "message_id", length = 80)
    private String messageId;

    @Size(max = 32)
    @Column(name = "phone", length = 32)
    private String phone;

    @Size(max = 64)
    @Column(name = "oa_id", length = 64)
    private String oaId;

    @Size(max = 64)
    @Column(name = "template_id", length = 64)
    private String templateId;

    @Size(max = 32)
    @Column(name = "delivery_channel", length = 32)
    private String deliveryChannel;

    @Column(name = "delivery_status")
    private Integer deliveryStatus;

    @Size(max = 255)
    @Column(name = "delivery_description", length = 255)
    private String deliveryDescription;

    @Size(max = 500)
    @Column(name = "error_message", length = 500)
    private String errorMessage;

    @Size(max = 4000)
    @Column(name = "raw_json", length = 4000)
    private String rawJson;

    /** TEST | AUTOCALL_DAY0 | CALLBACK (null = cũ). */
    @Size(max = 32)
    @Column(name = "source", length = 32)
    private String source;

    @Size(max = 64)
    @Column(name = "order_code", length = 64)
    private String orderCode;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Instant getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Instant createdAt) {
        this.createdAt = createdAt;
    }

    public String getKind() {
        return kind;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getRequestId() {
        return requestId;
    }

    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getOaId() {
        return oaId;
    }

    public void setOaId(String oaId) {
        this.oaId = oaId;
    }

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
    }

    public String getDeliveryChannel() {
        return deliveryChannel;
    }

    public void setDeliveryChannel(String deliveryChannel) {
        this.deliveryChannel = deliveryChannel;
    }

    public Integer getDeliveryStatus() {
        return deliveryStatus;
    }

    public void setDeliveryStatus(Integer deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
    }

    public String getDeliveryDescription() {
        return deliveryDescription;
    }

    public void setDeliveryDescription(String deliveryDescription) {
        this.deliveryDescription = deliveryDescription;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getRawJson() {
        return rawJson;
    }

    public void setRawJson(String rawJson) {
        this.rawJson = rawJson;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }
}
