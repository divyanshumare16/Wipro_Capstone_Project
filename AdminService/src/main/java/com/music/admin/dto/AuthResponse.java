package com.music.admin.dto;

public class AuthResponse {
    private String token;
    private Long adminId;
    private String email;
    private String adminName;
    private String firstName;
    private String lastName;
    
    // Constructors
    public AuthResponse() {}
    
    public AuthResponse(String token, Long adminId, String email, String adminName, String firstName, String lastName) {
        this.token = token;
        this.adminId = adminId;
        this.email = email;
        this.adminName = adminName;
        this.firstName = firstName;
        this.lastName = lastName;
    }
    
    // Getters and Setters
    public String getToken() {
        return token;
    }
    
    public void setToken(String token) {
        this.token = token;
    }
    
    public Long getAdminId() {
        return adminId;
    }
    
    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getAdminName() {
        return adminName;
    }
    
    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
}
