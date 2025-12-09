package com.music.notification.dto;

import lombok.AllArgsConstructor;
import lombok.Data;


@Data
@AllArgsConstructor
public class SongNotificationDTO {
	
	private String songName;
	private String singer;
	private String musicDirector;
	private String albumName;
	private String releaseDate;
	
}


