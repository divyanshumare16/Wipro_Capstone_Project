package com.music.admin.controller;

import com.music.admin.entity.SongsLibrary;
import com.music.admin.service.SongsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/songs")
@CrossOrigin(origins = "*")
public class SongsController {

    @Autowired
    private SongsService songsService;

    @Autowired
    private RestTemplate restTemplate; 

    @GetMapping("/all")
    public ResponseEntity<List<SongsLibrary>> getAllSongs() {
        return ResponseEntity.ok(songsService.getAllSongs());
    }

    @GetMapping("/{id}")
    public ResponseEntity<SongsLibrary> getSongById(@PathVariable Integer id) {
        return ResponseEntity.ok(songsService.getSongById(id));
    }

    @PostMapping("/add")
    public ResponseEntity<Map<String, Object>> addSong(@RequestBody SongsLibrary song) {
        try {
            // ✅ Save song first
            SongsLibrary savedSong = songsService.saveSong(song);
            
            // ✅ Send notification to notification microservice
            sendNotification(savedSong);
            
            return ResponseEntity.ok(Map.of(
                "success", true,
                "message", "Song added successfully with audio!",
                "songId", savedSong.getLibraryId()
            ));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of(
                "success", false, 
                "error", e.getMessage()
            ));
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<SongsLibrary> updateSong(@PathVariable Integer id, @RequestBody SongsLibrary song) {
        return ResponseEntity.ok(songsService.updateSong(id, song));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSong(@PathVariable Integer id) {
        songsService.deleteSong(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/singer/{singer}")
    public ResponseEntity<List<SongsLibrary>> getSongsBySinger(@PathVariable String singer) {
        return ResponseEntity.ok(songsService.getSongsBySinger(singer));
    }

    @GetMapping("/album/{album}")
    public ResponseEntity<List<SongsLibrary>> getSongsByAlbum(@PathVariable String album) {
        return ResponseEntity.ok(songsService.getSongsByAlbum(album));
    }

    private void sendNotification(SongsLibrary song) {
        try {
            System.out.println("🚀 Sending notification for: " + song.getSongName());
            
            // ✅ FIXED: Use HttpEntity + correct RestTemplate method
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            
            HttpEntity<Map<String, Object>> request = new HttpEntity<>(
                Map.of(
                    "songName", song.getSongName(),
                    "singer", song.getSinger() != null ? song.getSinger() : "Unknown",
                    "songType", song.getSongType(),
                    "musicDirector", song.getMusicDirector() != null ? song.getMusicDirector() : "Unknown",
                    "releaseDate", song.getReleaseDate() != null ? song.getReleaseDate().toString() : "N/A"
                ),
                headers
            );
            
            ResponseEntity<String> response = restTemplate.exchange(
                "http://localhost:8083/api/notifications/song-added",
                HttpMethod.POST,
                request,
                String.class
            );
            
            System.out.println("✅ NOTIFICATION SUCCESS: " + response.getBody());
            System.out.println("📧 Email sent for: " + song.getSongName());
            
        } catch (Exception e) {
            System.err.println("❌ NOTIFICATION FAILED: " + e.getMessage());
            e.printStackTrace();
        }
    }

}
