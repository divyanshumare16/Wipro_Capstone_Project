package com.music.user.repository;

import com.music.user.entity.PlaylistSongs;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface PlaylistSongsRepository extends JpaRepository<PlaylistSongs, Integer> {
    
    // Find all songs in a playlist
    List<PlaylistSongs> findByPlaylistId(Integer playlistId);
    
    // Find all songs in a playlist ordered by song_order
    List<PlaylistSongs> findByPlaylistIdOrderBySongOrderAsc(Integer playlistId);
    
    // Check if a song exists in a playlist
    Optional<PlaylistSongs> findByPlaylistIdAndLibraryId(Integer playlistId, Integer libraryId);
    
    // Delete all songs from a playlist
    void deleteByPlaylistId(Integer playlistId);
    
    // Count songs in a playlist
    Long countByPlaylistId(Integer playlistId);
}
