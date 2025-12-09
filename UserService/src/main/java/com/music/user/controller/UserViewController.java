package com.music.user.controller;

import org.springframework.stereotype.Controller;


import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class UserViewController {

    // Home page
    @GetMapping("/")
    public String home() {
        return "home";
    }

    // User Registration Page
    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    // User Login Page
    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    // User Dashboard
    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/users")
    public String viewUsers() {
        return "users";
    }

    // ✅ COMMENTED OUT - Using PlaylistViewController.myPlaylists() instead
    // @GetMapping("/playlists")
    // public String viewPlaylists() {
    //     return "playlists";
    // }

    // ✅ COMMENTED OUT - Using PlaylistViewController.viewPlaylist() instead
    // @GetMapping("/playlists/{id}")
    // public String viewPlaylistDetails(@PathVariable Integer id) {
    //     return "viewPlaylist";
    // }

    // Add songs to playlist page
    @GetMapping("/playlists/add-songs")
    public String addSongsToPlaylist() {
        return "addSongsToPlaylist";
    }
}