package com.music.admin.service;

import com.music.admin.entity.SongsLibrary;
import com.music.admin.exception.BadRequestException;
import com.music.admin.exception.ResourceNotFoundException;
import com.music.admin.repository.SongsLibraryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SongsService {

    @Autowired
    private SongsLibraryRepository songsRepository;

    public List<SongsLibrary> getAllSongs() {
        return songsRepository.findAll();
    }

    public SongsLibrary getSongById(Integer id) {
        return songsRepository.findById(id)
            .orElseThrow(() -> new ResourceNotFoundException("Song not found with id: " + id));
    }

    // ✅ FIXED: Both addSong() AND saveSong() methods
    public SongsLibrary addSong(SongsLibrary song) {
        if (song.getSongName() == null || song.getSongName().trim().isEmpty()) {
            throw new BadRequestException("Song name is required");
        } // ADD: Song ID validation
        if (song.getSongId() == null || song.getSongId().trim().isEmpty()) {
            throw new BadRequestException("Song ID is required");
        }
        
        //  Check duplicate songId BEFORE save
        if (songsRepository.existsBySongId(song.getSongId())) {
            throw new BadRequestException("Song ID already exists");
        }
        return songsRepository.save(song);
    }

    // ✅ ALIAS for controller compatibility
    public SongsLibrary saveSong(SongsLibrary song) {
        return addSong(song);
    }

    public SongsLibrary updateSong(Integer id, SongsLibrary updatedSong) {
        SongsLibrary existingSong = getSongById(id);
        if (updatedSong.getSongName() != null) existingSong.setSongName(updatedSong.getSongName());
        if (updatedSong.getSinger() != null) existingSong.setSinger(updatedSong.getSinger());
        if (updatedSong.getMusicDirector() != null) existingSong.setMusicDirector(updatedSong.getMusicDirector());
        if (updatedSong.getAlbumName() != null) existingSong.setAlbumName(updatedSong.getAlbumName());
        if (updatedSong.getSongType() != null) existingSong.setSongType(updatedSong.getSongType());
        if (updatedSong.getSongStatus() != null) existingSong.setSongStatus(updatedSong.getSongStatus());
        if (updatedSong.getAudioFilePath() != null) existingSong.setAudioFilePath(updatedSong.getAudioFilePath());
        if (updatedSong.getDuration() != null) existingSong.setDuration(updatedSong.getDuration());
        return songsRepository.save(existingSong);
    }

    public void deleteSong(Integer id) {
        SongsLibrary song = getSongById(id);
        songsRepository.delete(song);
    }

    public List<SongsLibrary> getSongsBySinger(String singer) {
        return songsRepository.findAll(); // Add custom query later
    }

    public List<SongsLibrary> getSongsByAlbum(String album) {
        return songsRepository.findAll(); // Add custom query later
    }
}
