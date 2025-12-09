package com.music.user.service;

import com.music.user.entity.PlaylistSongs;
import com.music.user.repository.PlaylistSongsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Map;
import java.util.List;
import java.util.Optional;

@Service
public class PlaylistSongsService {
    
    @Autowired
    private PlaylistSongsRepository playlistSongsRepository;
    
    @Autowired
    private RestTemplate restTemplate;
    
    // Add song to playlist
    public PlaylistSongs addSongToPlaylist(PlaylistSongs playlistSong) {
        // Check if song already exists in playlist
        Optional<PlaylistSongs> existing = playlistSongsRepository
                .findByPlaylistIdAndLibraryId(playlistSong.getPlaylistId(), playlistSong.getLibraryId());
        
        if (existing.isPresent()) {
            throw new RuntimeException("Song already exists in this playlist!");
        }
        
        return playlistSongsRepository.save(playlistSong);
    }
    
    // Get all songs in a playlist
    public List<PlaylistSongs> getSongsInPlaylist(Integer playlistId) {
        return playlistSongsRepository.findByPlaylistIdOrderBySongOrderAsc(playlistId);
    }
    
    // Get playlist songs with full song details from AdminService
    public List<Map<String, Object>> getPlaylistSongsWithDetails(Integer playlistId) {
        List<PlaylistSongs> playlistSongs = playlistSongsRepository
                .findByPlaylistIdOrderBySongOrderAsc(playlistId);
        
        List<Map<String, Object>> songsWithDetails = new ArrayList<>();
        
        for (PlaylistSongs ps : playlistSongs) {
            try {
                // Fetch song details from AdminService
                String url = "http://localhost:8082/api/songs/" + ps.getLibraryId();
                Map<String, Object> songDetails = restTemplate.getForObject(url, Map.class);
                
                if (songDetails != null) {
                    // Add playlist-specific fields
                    songDetails.put("playlistSongId", ps.getPlaylistSongId());
                    songDetails.put("addedAt", ps.getAddedAt());
                    songDetails.put("songOrder", ps.getSongOrder());
                    songsWithDetails.add(songDetails);
                }
            } catch (Exception e) {
                System.err.println("Error fetching song details for libraryId: " + ps.getLibraryId());
                // Continue with next song even if one fails
            }
        }
        
        return songsWithDetails;
    }
    
    // Remove song from playlist by playlist_song_id
    public void removeSongFromPlaylist(Integer playlistSongId) {
        PlaylistSongs playlistSong = playlistSongsRepository.findById(playlistSongId)
                .orElseThrow(() -> new RuntimeException("Playlist song not found!"));
        
        playlistSongsRepository.delete(playlistSong);
    }
    
    // Remove song from playlist by playlistId and libraryId
    @Transactional
    public void removeSongFromPlaylistByIds(Integer playlistId, Integer libraryId) {
        PlaylistSongs playlistSong = playlistSongsRepository
                .findByPlaylistIdAndLibraryId(playlistId, libraryId)
                .orElseThrow(() -> new RuntimeException("Song not found in this playlist!"));
        
        playlistSongsRepository.delete(playlistSong);
    }
    
    // Update song order
    public PlaylistSongs updateSongOrder(Integer playlistSongId, Integer newOrder) {
        PlaylistSongs playlistSong = playlistSongsRepository.findById(playlistSongId)
                .orElseThrow(() -> new RuntimeException("Playlist song not found!"));
        
        playlistSong.setSongOrder(newOrder);
        return playlistSongsRepository.save(playlistSong);
    }
    
    // Clear all songs from playlist
    @Transactional
    public void clearPlaylist(Integer playlistId) {
        playlistSongsRepository.deleteByPlaylistId(playlistId);
    }
    
    // Count songs in playlist
    public Long countSongsInPlaylist(Integer playlistId) {
        return playlistSongsRepository.countByPlaylistId(playlistId);
    }
}