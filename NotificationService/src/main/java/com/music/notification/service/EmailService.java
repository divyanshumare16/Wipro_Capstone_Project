package com.music.notification.service;


import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.music.notification.dto.SongNotificationDTO;
import com.music.notification.dto.UserDTO;

@Service
public class EmailService {
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private RestTemplate restTemplate;
	
	@Value ("${user.service.url}")
	private String userServiceUrl;
	
	public String sendNewSongNotification(SongNotificationDTO song) {
		try {
			List<UserDTO> users = fetchAllUsers();
			
			if(users == null || users.isEmpty()) {
				return "No users found to notify";
			}
			
			int emailsSent = 0;
			
	           for (UserDTO user : users) {
	                if (user.getEmail() != null && !user.getEmail().isEmpty()) {
	                    sendEmail(user, song);
	                    emailsSent++;
	                }
	            }

	            return "✅ Notification sent to " + emailsSent + " users successfully!";

	        } catch (Exception e) {
	            e.printStackTrace();
	            return "❌ Error sending notifications: " + e.getMessage();
	        }
	    }

	    // ✅ FETCH ALL USERS FROM USER SERVICE
	    private List<UserDTO> fetchAllUsers() {
	        try {
	            String url = "http://localhost:8081/api/users/all";
	            UserDTO[] usersArray = restTemplate.getForObject(url, UserDTO[].class);
	            return Arrays.asList(usersArray);
	        } catch (Exception e) {
	            System.err.println("Error fetching users: " + e.getMessage());
	            return null;
	        }
	    }

	    // ✅ SEND EMAIL TO SINGLE USER
	    private void sendEmail(UserDTO user, SongNotificationDTO song) {
	        try {
	            SimpleMailMessage message = new SimpleMailMessage();
	            
	            message.setTo(user.getEmail());
	            message.setSubject("🎵 New Song Added to Music Library!");
	            
	            String emailBody = buildEmailBody(user, song);
	            message.setText(emailBody);
	            
	            mailSender.send(message);
	            
	            System.out.println("✅ Email sent to: " + user.getEmail());
	            
	        } catch (Exception e) {
	            System.err.println("❌ Failed to send email to " + user.getEmail() + ": " + e.getMessage());
	        }
	    }

	    // ✅ BUILD EMAIL BODY
	    private String buildEmailBody(UserDTO user, SongNotificationDTO song) {
	        StringBuilder body = new StringBuilder();
	        
	        body.append("Hi ").append(user.getFirstName()).append(",\n\n");
	        body.append("Great news! A new song has been added to the Music Library:\n\n");
	        body.append("🎵 Song: ").append(song.getSongName()).append("\n");
	        body.append("🎤 Artist: ").append(song.getSinger()).append("\n");
	        
	        if (song.getMusicDirector() != null) {
	            body.append("🎹 Music Director: ").append(song.getMusicDirector()).append("\n");
	        }
	        
	        if (song.getAlbumName() != null) {
	            body.append("💿 Album: ").append(song.getAlbumName()).append("\n");
	        }
	        
	        if (song.getReleaseDate() != null) {
	            body.append("📅 Release Date: ").append(song.getReleaseDate()).append("\n");
	        }
	        
	        body.append("\nLogin to your account to listen now!\n\n");
	        body.append("Best regards,\n");
	        body.append("Music Library Team");
	        
	        return body.toString();
	    }
	    // ✅ TEST EMAIL (For testing purposes)
	    public String sendTestEmail(String toEmail) {
	        try {
	            SimpleMailMessage message = new SimpleMailMessage();
	            message.setTo(toEmail);
	            message.setSubject("🎵 Test Email from Music Library");
	            message.setText("This is a test email from Notification Service!\n\nIf you received this, email service is working perfectly! ✅");
	            
	            mailSender.send(message);
	            
	            return "✅ Test email sent to " + toEmail;
	        } catch (Exception e) {
	            return "❌ Failed to send test email: " + e.getMessage();
	        }
	    }
}
