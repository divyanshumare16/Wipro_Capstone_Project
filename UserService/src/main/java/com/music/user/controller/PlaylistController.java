package com.music.user.controller;

import com.music.user.entity.Playlist;
import com.music.user.exception.ResourceNotFoundException;
import com.music.user.service.PlaylistService;
import com.music.user.service.PlaylistSongsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/playlists")
@CrossOrigin(origins = "*")
public class PlaylistController {

    @Autowired
    private PlaylistService playlistService;

    @Autowired
    private PlaylistSongsService playlistSongsService;

    @GetMapping("/all")
    public ResponseEntity<List<Playlist>> getAllPlaylists() {
        List<Playlist> playlists = playlistService.getAllPlaylists();
        return ResponseEntity.ok(playlists);
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Playlist>> getUserPlaylists(@PathVariable Integer userId) {
        List<Playlist> playlists = playlistService.getUserPlaylists(userId);
        return new ResponseEntity<>(playlists, HttpStatus.OK);
    }

    @PostMapping("/create")
    public ResponseEntity<Playlist> createPlaylist(@RequestBody Playlist playlist) {
        Playlist created = playlistService.createPlaylist(playlist);
        return new ResponseEntity<>(created, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Playlist> getPlaylist(@PathVariable Integer id) {
        Playlist playlist = playlistService.getPlaylistById(id)
            .orElseThrow(() -> new ResourceNotFoundException("Playlist not found with ID: " + id));
        return new ResponseEntity<>(playlist, HttpStatus.OK);
    }

    @GetMapping("/{id}/songs")
    public ResponseEntity<List<Map<String, Object>>> getPlaylistSongs(@PathVariable Integer id) {
        List<Map<String, Object>> songs = playlistSongsService.getPlaylistSongsWithDetails(id);
        return new ResponseEntity<>(songs, HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Playlist> updatePlaylist(@PathVariable Integer id, @RequestBody Playlist playlist) {
        Playlist updated = playlistService.updatePlaylist(id, playlist);
        return new ResponseEntity<>(updated, HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deletePlaylist(@PathVariable Integer id) {
        playlistService.deletePlaylist(id);
        return new ResponseEntity<>("Playlist deleted successfully", HttpStatus.OK);
    }
}
