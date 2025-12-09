package com.music.user.dto;

public class AuthResponse {
    private String token;
    private Integer userId;
    private String email;
    private String userName;

    public AuthResponse() {}

    public AuthResponse(String token, Integer userId, String email, String username) {
        this.token = token;
        this.userId = userId;
        this.email = email;
        this.userName = username;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
