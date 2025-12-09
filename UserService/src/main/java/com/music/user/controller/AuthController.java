package com.music.user.controller;

import com.music.user.dto.AuthResponse;
import com.music.user.dto.LoginRequest;
import com.music.user.entity.User;
import com.music.user.exception.BadRequestException;
import com.music.user.exception.UnauthorizedException;
import com.music.user.security.JwtUtil;
import com.music.user.service.CustomUserDetailsService;
import com.music.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private CustomUserDetailsService userDetailsService;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody LoginRequest loginRequest) {
        System.out.println("🔐 Login attempt: " + loginRequest.getEmail());
        
        try {
            authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginRequest.getEmail(), loginRequest.getPassword())
            );
        } catch (BadCredentialsException e) {
            throw new UnauthorizedException("Invalid email or password");
        }
        
        UserDetails userDetails = userDetailsService.loadUserByUsername(loginRequest.getEmail());
        User user = userDetailsService.getUserByEmail(loginRequest.getEmail());
        
        String jwt = jwtUtil.generateToken(userDetails.getUsername(), user.getUserId());
        System.out.println("✅ Login successful: " + user.getEmail());
        
        AuthResponse response = new AuthResponse(jwt, user.getUserId(), user.getEmail(), user.getUserName());
        return ResponseEntity.ok(response);
    }


    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@RequestBody User user) {
        System.out.println("📝 Register attempt: " + user.getEmail());
        
        if (user.getEmail() == null || user.getPassword() == null) {
            throw new BadRequestException("Email and password are required");
        }
        
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        User createdUser = userService.createUser(user);
        String jwt = jwtUtil.generateToken(createdUser.getEmail(), createdUser.getUserId());

        System.out.println("✅ Registration successful: " + createdUser.getEmail());
        AuthResponse response = new AuthResponse(jwt, createdUser.getUserId(), createdUser.getEmail(), createdUser.getUserName());
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }
}

