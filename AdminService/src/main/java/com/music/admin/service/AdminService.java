package com.music.admin.service;

import com.music.admin.entity.Admin;
import com.music.admin.exception.BadRequestException;
import com.music.admin.exception.ResourceNotFoundException;
import com.music.admin.exception.UnauthorizedException;
import com.music.admin.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
    
    @Autowired
    private AdminRepository adminRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    public Admin registerAdmin(Admin admin) {
        // Check if email already exists
        if (adminRepository.findByEmail(admin.getEmail()).isPresent()) {
            throw new BadRequestException("Email already exists");
        }
        
        // Check if username already exists 
        if (adminRepository.findByUserName(admin.getUserName()).isPresent()) {
            throw new BadRequestException("Username already exists");
        }
        
        // Encode password
        admin.setPassword(passwordEncoder.encode(admin.getPassword()));
        return adminRepository.save(admin);
    }
    
    public Admin loginAdmin(String email, String password) {
        Admin admin = adminRepository.findByEmail(email)
            .orElseThrow(() -> new UnauthorizedException("Invalid email or password"));
        
        if (!passwordEncoder.matches(password, admin.getPassword())) {
            throw new UnauthorizedException("Invalid email or password");
        }
        
        return admin;
    }
    

    public Admin getAdminById(Integer id) {
        return adminRepository.findById(id)
            .orElseThrow(() -> new ResourceNotFoundException("Admin not found with id: " + id));
    }
    
    public Admin getAdminByEmail(String email) {
        return adminRepository.findByEmail(email)
            .orElseThrow(() -> new ResourceNotFoundException("Admin not found with email: " + email));
    }
}
