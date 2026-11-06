package com.mycompany.myapp.security;

import java.util.Arrays;
import java.util.Optional;
import java.util.stream.Stream;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.jose.jws.MacAlgorithm;
import org.springframework.security.oauth2.jwt.Jwt;

/**
 * Utility class for Spring Security.
 */
public final class SecurityUtils {

    public static final MacAlgorithm JWT_ALGORITHM = MacAlgorithm.HS512;

    public static final String AUTHORITIES_KEY = "auth";

    /** Mã phiên đăng nhập trong JWT ({@code user_session.sid}). */
    public static final String SID_CLAIM = "sid";

    private SecurityUtils() {}

    /**
     * Get the login of the current user.
     * Anonymous / synthetic principals ({@code anonymousUser}, {@code system}, {@code customer}) → empty
     * so business code falls back to {@code system} or a real staff actor — never ghi nợ / thu tiền cho user ảo.
     *
     * @return the login of the current user.
     */
    public static Optional<String> getCurrentUserLogin() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        return Optional.ofNullable(extractPrincipal(securityContext.getAuthentication()));
    }

    /** Actor ảo (Spring anonymous / job / khách) — không phải NV thật. */
    public static boolean isSyntheticLogin(String login) {
        if (login == null || login.isBlank()) {
            return true;
        }
        String a = login.trim();
        return (
            "anonymousUser".equalsIgnoreCase(a) ||
            "anonymous".equalsIgnoreCase(a) ||
            "system".equalsIgnoreCase(a) ||
            "customer".equalsIgnoreCase(a)
        );
    }

    private static String extractPrincipal(Authentication authentication) {
        if (authentication == null) {
            return null;
        }
        // AnonymousAuthenticationFilter: isAuthenticated()=true nhưng principal = "anonymousUser".
        if (getAuthorities(authentication).anyMatch(AuthoritiesConstants.ANONYMOUS::equals)) {
            return null;
        }
        String principal;
        if (authentication.getPrincipal() instanceof UserDetails springSecurityUser) {
            principal = springSecurityUser.getUsername();
        } else if (authentication.getPrincipal() instanceof Jwt jwt) {
            principal = jwt.getSubject();
        } else if (authentication.getPrincipal() instanceof String s) {
            principal = s;
        } else {
            return null;
        }
        if (principal == null || principal.isBlank()) {
            return null;
        }
        String trimmed = principal.trim();
        // Chỉ bỏ anonymous* khỏi login hiện tại — "system"/"customer" vẫn trả về nếu JWT subject thật là vậy (hiếm).
        if ("anonymousUser".equalsIgnoreCase(trimmed) || "anonymous".equalsIgnoreCase(trimmed)) {
            return null;
        }
        return trimmed;
    }

    /**
     * Get the JWT of the current user.
     *
     * @return the JWT of the current user.
     */
    public static Optional<String> getCurrentUserJWT() {
        SecurityContext securityContext = SecurityContextHolder.getContext();
        return Optional.ofNullable(securityContext.getAuthentication())
            .filter(authentication -> authentication.getCredentials() instanceof String)
            .map(authentication -> (String) authentication.getCredentials());
    }

    /**
     * Check if a user is authenticated.
     *
     * @return true if the user is authenticated, false otherwise.
     */
    public static boolean isAuthenticated() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authentication != null && getAuthorities(authentication).noneMatch(AuthoritiesConstants.ANONYMOUS::equals);
    }

    /**
     * Checks if the current user has any of the authorities.
     *
     * @param authorities the authorities to check.
     * @return true if the current user has any of the authorities, false otherwise.
     */
    public static boolean hasCurrentUserAnyOfAuthorities(String... authorities) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return (
            authentication != null && getAuthorities(authentication).anyMatch(authority -> Arrays.asList(authorities).contains(authority))
        );
    }

    /**
     * Checks if the current user has none of the authorities.
     *
     * @param authorities the authorities to check.
     * @return true if the current user has none of the authorities, false otherwise.
     */
    public static boolean hasCurrentUserNoneOfAuthorities(String... authorities) {
        return !hasCurrentUserAnyOfAuthorities(authorities);
    }

    /**
     * Checks if the current user has a specific authority.
     *
     * @param authority the authority to check.
     * @return true if the current user has the authority, false otherwise.
     */
    public static boolean hasCurrentUserThisAuthority(String authority) {
        return hasCurrentUserAnyOfAuthorities(authority);
    }

    private static Stream<String> getAuthorities(Authentication authentication) {
        return authentication.getAuthorities().stream().map(GrantedAuthority::getAuthority);
    }
}
