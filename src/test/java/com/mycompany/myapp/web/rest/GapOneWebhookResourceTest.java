package com.mycompany.myapp.web.rest;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

class GapOneWebhookResourceTest {

    @Test
    void docsFormulaSha256Concat() {
        // Giống ví dụ portal (thay client_id thật của app).
        String clientId = "demo-client";
        String messageId = "233fe814-40b7-4243-89c2-b91b46cc71ff";
        String channel = "zalo";
        String timestamp = "2026-10-26T10:48:41.186+0700";
        String expected = GapOneWebhookResource.sha256Hex(clientId + messageId + channel + timestamp);
        assertThat(GapOneWebhookResource.signatureMatches(expected, clientId, null, messageId, channel, timestamp)).isTrue();
    }

    @Test
    void rejectsWrongSignature() {
        assertThat(
            GapOneWebhookResource.signatureMatches(
                "0000000000000000000000000000000000000000000000000000000000000000",
                "demo-client",
                null,
                "233fe814-40b7-4243-89c2-b91b46cc71ff",
                "zalo",
                "2026-10-26T10:48:41.186+0700"
            )
        ).isFalse();
    }

    @Test
    void acceptsHmacVariantWithClientIdKey() {
        String clientId = "demo-client";
        String messageId = "mid";
        String channel = "zalo";
        String ts = "2026-10-26T10:48:41.186+0700";
        String sig = GapOneWebhookResource.hmacSha256Hex(clientId, messageId + channel + ts);
        assertThat(GapOneWebhookResource.signatureMatches(sig, clientId, "secret", messageId, channel, ts)).isTrue();
    }
}
