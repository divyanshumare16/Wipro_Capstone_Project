package com.music.user.repository;

import com.music.user.entity.Playlist;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PlaylistRepository extends JpaRepository<Playlist, Integer> {
    
    // Find all playlists by user ID
    List<Playlist> findByUserId(Integer userId);
    
    // Find public playlists
    List<Playlist> findByIsPublic(Boolean isPublic);
    
    // Find playlists by name (search functionality)
    List<Playlist> findByPlaylistNameContainingIgnoreCase(String name);
    
    // Find user's playlists by name
    List<Playlist> findByUserIdAndPlaylistNameContainingIgnoreCase(Integer userId, String name);
}
