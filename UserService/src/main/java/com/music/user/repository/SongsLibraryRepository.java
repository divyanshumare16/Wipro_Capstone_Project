package com.music.user.repository;

import com.music.user.entity.SongsLibrary;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SongsLibraryRepository extends JpaRepository<SongsLibrary, Integer> {
    
    List<SongsLibrary> findBySongType(String songType);
    
    List<SongsLibrary> findBySongStatus(String songStatus);
    
    List<SongsLibrary> findBySongNameContainingIgnoreCase(String songName);
}
