package com.music.user.service;

import com.music.user.entity.Playlist;
import com.music.user.repository.PlaylistRepository;
import com.music.user.repository.PlaylistSongsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class PlaylistService {
    
    @Autowired
    private PlaylistRepository playlistRepository;
    
    @Autowired
    private PlaylistSongsRepository playlistSongsRepository;
    
    // Create new playlist
    public Playlist createPlaylist(Playlist playlist) {
        return playlistRepository.save(playlist);
    }
    // Get user's playlists - THIS IS THE MISSING METHOD
    public List<Playlist> getUserPlaylists(Integer userId) {
        return playlistRepository.findByUserId(userId);
    }
    
    // Get all playlists
    public List<Playlist> getAllPlaylists() {
        return playlistRepository.findAll();
    }
    
    // Get playlists by user ID
    public List<Playlist> getPlaylistsByUserId(Integer userId) {
        return playlistRepository.findByUserId(userId);
    }
    
    // Get playlist by ID
    public Optional<Playlist> getPlaylistById(Integer playlistId) {
        return playlistRepository.findById(playlistId);
    }
    
    // Search playlists by name
    public List<Playlist> searchPlaylistsByName(String name) {
        return playlistRepository.findByPlaylistNameContainingIgnoreCase(name);
    }
    
    // Search user's playlists by name
    public List<Playlist> searchUserPlaylistsByName(Integer userId, String name) {
        return playlistRepository.findByUserIdAndPlaylistNameContainingIgnoreCase(userId, name);
    }
    
    // Update playlist
    public Playlist updatePlaylist(Integer playlistId, Playlist playlistDetails) {
        Playlist playlist = playlistRepository.findById(playlistId)
                .orElseThrow(() -> new RuntimeException("Playlist not found with id: " + playlistId));
        
        playlist.setPlaylistName(playlistDetails.getPlaylistName());
        playlist.setDescription(playlistDetails.getDescription());
        playlist.setIsPublic(playlistDetails.getIsPublic());
        
        return playlistRepository.save(playlist);
    }
    
    // Delete playlist (will cascade delete all playlist songs)
    @Transactional
    public void deletePlaylist(Integer playlistId) {
        if (!playlistRepository.existsById(playlistId)) {
            throw new RuntimeException("Playlist not found with id: " + playlistId);
        }
        playlistRepository.deleteById(playlistId);
    }
    
    // Get song count in playlist
    public Long getSongCountInPlaylist(Integer playlistId) {
        return playlistSongsRepository.countByPlaylistId(playlistId);
    }
}
