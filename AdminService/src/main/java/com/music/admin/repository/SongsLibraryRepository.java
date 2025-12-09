package com.music.admin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.music.admin.entity.SongsLibrary;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface SongsLibraryRepository extends JpaRepository<SongsLibrary, Integer> {  // ✅ ADDED <SongsLibrary, Integer>
    List<SongsLibrary> findBySongStatus(String songStatus);
    List<SongsLibrary> findBySongType(String songType);
    List<SongsLibrary> findBySongStatusAndSongType(String songStatus, String songType);
    List<SongsLibrary> findBySinger(String singer);
    List<SongsLibrary> findByAlbumName(String albumName);
    
 
    boolean existsBySongId(String songId);

}  
