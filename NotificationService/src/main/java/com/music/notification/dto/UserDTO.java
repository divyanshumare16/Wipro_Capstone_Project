package com.music.notification.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserDTO {
	private Integer userId;
	private String firstName;
	private String lastName;
	private String userName;
	private String email;
	private String mobile;
}
