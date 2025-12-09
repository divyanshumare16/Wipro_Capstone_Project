package com.music.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class PlaylistViewController {
    
    @GetMapping("/playlists")
    public String myPlaylists() {
        return "playlists";
    }
    
    @GetMapping("/playlists/create")
    public String createPlaylistPage() {
        return "createPlaylist";
    }
    
    @GetMapping("/playlists/{playlistId}")
    public String viewPlaylist(@PathVariable Integer playlistId) {
        return "viewPlaylist";
    }
    
    @GetMapping("/playlists/{playlistId}/edit")
    public String editPlaylist(@PathVariable Integer playlistId) {
        return "editPlaylist";
    }
    
    @GetMapping("/playlists/{playlistId}/add-songs")
    public String addSongsToPlaylist(@PathVariable Integer playlistId) {
        return "addSongsToPlaylist";
    }
}
