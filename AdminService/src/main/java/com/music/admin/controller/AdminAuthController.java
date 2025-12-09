package com.music.admin.controller;

import com.music.admin.config.JwtUtil;
import com.music.admin.dto.AuthResponse;
import com.music.admin.dto.LoginRequest;
import com.music.admin.dto.RegisterRequest;
import com.music.admin.entity.Admin;
import com.music.admin.service.AdminService;
import com.music.admin.service.CustomAdminDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AdminAuthController {
    
    @Autowired
    private AdminService adminService;
    
    @Autowired
    private AuthenticationManager authenticationManager;
    
    @Autowired
    private JwtUtil jwtUtil;
    
    @Autowired
    private CustomAdminDetailsService adminDetailsService;
    
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody LoginRequest loginRequest) {
        // Authenticate
        authenticationManager.authenticate(
            new UsernamePasswordAuthenticationToken(loginRequest.getEmail(), loginRequest.getPassword())
        );
        
        // Get admin details
        Admin admin = adminService.loginAdmin(loginRequest.getEmail(), loginRequest.getPassword());
        
        // Generate JWT token
        UserDetails userDetails = adminDetailsService.loadUserByUsername(loginRequest.getEmail());
        String token = jwtUtil.generateToken(userDetails);
        
        // Create response - ✅ FIXED to match Admin entity fields
        AuthResponse response = new AuthResponse(
            token,
            admin.getAdminId().longValue(),  // Convert Integer to Long
            admin.getEmail(),
            admin.getAdminName(),
            admin.getUserName(),  // ✅ Use userName instead of firstName
            ""  // ✅ Empty string for lastName (not in entity)
        );
        
        return ResponseEntity.ok(response);
    }
    
    @PostMapping("/admin/login")
    public ResponseEntity<?> adminLogin(@RequestBody LoginRequest loginRequest) {
        // fill email from userName if you want to log in by username
        if (loginRequest.getEmail() == null && loginRequest.getEmail() != null) {
            loginRequest.setEmail(loginRequest.getEmail());
        }
        return login(loginRequest); // reuse existing login method
    }

    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@RequestBody RegisterRequest registerRequest) {
        // Create new admin
        Admin admin = new Admin();
        admin.setAdminName(registerRequest.getAdminName());
        admin.setUserName(registerRequest.getAdminName());  // ✅ Use adminName as userName
        admin.setEmail(registerRequest.getEmail());
        admin.setPassword(registerRequest.getPassword());
        admin.setMobileNo(registerRequest.getMobile());  // ✅ Use setMobileNo not setMobile
        
        // Save admin
        Admin savedAdmin = adminService.registerAdmin(admin);
        
        // Generate JWT token
        UserDetails userDetails = adminDetailsService.loadUserByUsername(savedAdmin.getEmail());
        String token = jwtUtil.generateToken(userDetails);
        
        // Create response - ✅ FIXED to match Admin entity fields
        AuthResponse response = new AuthResponse(
            token,
            savedAdmin.getAdminId().longValue(),  // Convert Integer to Long
            savedAdmin.getEmail(),
            savedAdmin.getAdminName(),
            savedAdmin.getUserName(),  // ✅ Use userName
            ""  // Empty string for lastName
        );
        
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}
