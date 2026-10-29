package com.mycompany.myapp.web.rest;

import com.mycompany.myapp.security.ClientIpResolver;
import com.mycompany.myapp.service.customer.CustomerAuthService;
import com.mycompany.myapp.service.customer.CustomerPortalService;
import com.mycompany.myapp.service.dto.order.TrackOrderResponse;
import jakarta.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.web.bind.annotation.*;

/**
 * Trang khách cpn.xevietnam.com: đăng nhập SĐT + OTP, xem đơn của mình.
 * Không dùng JWT nhân viên — token khách qua header {@code X-Customer-Token}.
 */
@RestController
@RequestMapping("/api/public/customer")
public class CustomerPortalResource {

    static final String TOKEN_HEADER = "X-Customer-Token";

    private final CustomerAuthService customerAuthService;
    private final CustomerPortalService customerPortalService;

    public CustomerPortalResource(CustomerAuthService customerAuthService, CustomerPortalService customerPortalService) {
        this.customerAuthService = customerAuthService;
        this.customerPortalService = customerPortalService;
    }

    @PostMapping("/otp/send")
    public CustomerAuthService.SendResult sendOtp(@RequestBody Map<String, String> body, HttpServletRequest http) {
        return customerAuthService.sendOtp(body != null ? body.get("phone") : null, ClientIpResolver.resolve(http));
    }

    @PostMapping("/otp/verify")
    public CustomerAuthService.LoginResult verifyOtp(@RequestBody Map<String, String> body) {
        return customerAuthService.verifyOtp(body != null ? body.get("phone") : null, body != null ? body.get("otp") : null);
    }

    @GetMapping("/me")
    public Map<String, Object> me(@RequestHeader(value = TOKEN_HEADER, required = false) String token) {
        String phone = customerAuthService.requirePhoneOf(token);
        Map<String, Object> out = new LinkedHashMap<>();
        out.put("phone", phone);
        out.put("name", customerAuthService.latestSenderName(phone));
        return out;
    }

    @GetMapping("/summary")
    public Map<String, Object> summary(@RequestHeader(value = TOKEN_HEADER, required = false) String token) {
        String phone = customerAuthService.requirePhoneOf(token);
        return customerPortalService.summary(phone, customerAuthService.latestSenderName(phone));
    }

    @GetMapping("/orders")
    public List<CustomerPortalService.OrderRow> orders(@RequestHeader(value = TOKEN_HEADER, required = false) String token) {
        return customerPortalService.orders(customerAuthService.requirePhoneOf(token));
    }

    @GetMapping("/orders/{code}")
    public TrackOrderResponse order(@RequestHeader(value = TOKEN_HEADER, required = false) String token, @PathVariable String code) {
        return customerPortalService.detail(customerAuthService.requirePhoneOf(token), code);
    }
}
