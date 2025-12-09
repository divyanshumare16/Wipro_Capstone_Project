package com.music.user.entity;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "playlist_songs")
public class PlaylistSongs {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "playlist_song_id")
    private Integer playlistSongId;
    
    @Column(name = "playlist_id", nullable = false)
    private Integer playlistId;
    
    @Column(name = "library_id", nullable = false)
    private Integer libraryId;
    
    @Column(name = "added_at")
    private LocalDateTime addedAt;
    
    @Column(name = "song_order")
    private Integer songOrder;
    
    @PrePersist
    protected void onCreate() {
        addedAt = LocalDateTime.now();
    }
    
    // Constructors
    public PlaylistSongs() {}
    
    // Getters and Setters
    public Integer getPlaylistSongId() { return playlistSongId; }
    public void setPlaylistSongId(Integer playlistSongId) { this.playlistSongId = playlistSongId; }
    
    public Integer getPlaylistId() { return playlistId; }
    public void setPlaylistId(Integer playlistId) { this.playlistId = playlistId; }
    
    public Integer getLibraryId() { return libraryId; }
    public void setLibraryId(Integer libraryId) { this.libraryId = libraryId; }
    
    public LocalDateTime getAddedAt() { return addedAt; }
    public void setAddedAt(LocalDateTime addedAt) { this.addedAt = addedAt; }
    
    public Integer getSongOrder() { return songOrder; }
    public void setSongOrder(Integer songOrder) { this.songOrder = songOrder; }
}