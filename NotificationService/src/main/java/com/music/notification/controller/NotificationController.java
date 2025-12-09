package com.music.notification.controller;

import com.music.notification.dto.SongNotificationDTO;
import com.music.notification.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/notifications")
@CrossOrigin(origins = "*")
public class NotificationController {

    @Autowired
    private EmailService emailService;

    // ✅ ENDPOINT: Send notification when new song is added
    @PostMapping("/song-added")
    public ResponseEntity<String> notifySongAdded(@RequestBody SongNotificationDTO song) {
        try {
            System.out.println("📧 Received request to notify users about new song: " + song.getSongName());
            
            String result = emailService.sendNewSongNotification(song);
            
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // ✅ ENDPOINT: Test email functionality
    @GetMapping("/test-email")
    public ResponseEntity<String> testEmail(@RequestParam String email) {
        try {
            String result = emailService.sendTestEmail(email);
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Error: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // ✅ ENDPOINT: Health check
    @GetMapping("/health")
    public ResponseEntity<String> healthCheck() {
        return new ResponseEntity<>("✅ Notification Service is running!", HttpStatus.OK);
    }
}
