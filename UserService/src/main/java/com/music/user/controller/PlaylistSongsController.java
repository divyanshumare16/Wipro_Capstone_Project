package com.music.user.controller;

import com.music.user.entity.PlaylistSongs;
import com.music.user.exception.BadRequestException;
import com.music.user.exception.ResourceNotFoundException;
import com.music.user.service.PlaylistSongsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/playlist-songs")
@CrossOrigin(origins = "*")
public class PlaylistSongsController {

    @Autowired
    private PlaylistSongsService playlistSongsService;

    @PostMapping("/add")
    public ResponseEntity<PlaylistSongs> addSongToPlaylist(@RequestBody PlaylistSongs playlistSong) {
        if (playlistSong.getPlaylistId() == null || playlistSong.getLibraryId() == null) {
            throw new BadRequestException("Playlist ID and Library ID are required");
        }
        PlaylistSongs added = playlistSongsService.addSongToPlaylist(playlistSong);
        return new ResponseEntity<>(added, HttpStatus.CREATED);
    }

    @GetMapping("/playlist/{playlistId}")
    public ResponseEntity<List<PlaylistSongs>> getSongsInPlaylist(@PathVariable Integer playlistId) {
        List<PlaylistSongs> songs = playlistSongsService.getSongsInPlaylist(playlistId);
        return new ResponseEntity<>(songs, HttpStatus.OK);
    }

    @DeleteMapping("/{playlistSongId}")
    public ResponseEntity<String> removeSongFromPlaylist(@PathVariable Integer playlistSongId) {
        playlistSongsService.removeSongFromPlaylist(playlistSongId);
        return new ResponseEntity<>("Song removed from playlist successfully!", HttpStatus.OK);
    }

    @DeleteMapping("/playlist/{playlistId}/song/{libraryId}")
    public ResponseEntity<String> removeSongByIds(
            @PathVariable Integer playlistId,
            @PathVariable Integer libraryId) {
        playlistSongsService.removeSongFromPlaylistByIds(playlistId, libraryId);
        return new ResponseEntity<>("Song removed from playlist successfully!", HttpStatus.OK);
    }

    @PutMapping("/{playlistSongId}/order")
    public ResponseEntity<PlaylistSongs> updateSongOrder(
            @PathVariable Integer playlistSongId,
            @RequestParam Integer newOrder) {
        PlaylistSongs updated = playlistSongsService.updateSongOrder(playlistSongId, newOrder);
        return new ResponseEntity<>(updated, HttpStatus.OK);
    }

    @DeleteMapping("/playlist/{playlistId}/clear")
    public ResponseEntity<String> clearPlaylist(@PathVariable Integer playlistId) {
        playlistSongsService.clearPlaylist(playlistId);
        return new ResponseEntity<>("All songs removed from playlist!", HttpStatus.OK);
    }

    @GetMapping("/playlist/{playlistId}/count")
    public ResponseEntity<Long> countSongs(@PathVariable Integer playlistId) {
        Long count = playlistSongsService.countSongsInPlaylist(playlistId);
        return new ResponseEntity<>(count, HttpStatus.OK);
    }
}
