package com.music.user.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;  // ✅ ADD THIS
import org.springframework.stereotype.Service;

import com.music.user.entity.User;
import com.music.user.repository.UserRepository;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;  // password encoder
    
    // Create User (used internally)
    public User createUser(User user) {
        //  ENCRYPT PASSWORD BEFORE SAVING
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        return userRepository.save(user);
    }
    
    // Add User (Registration)
    public User addUser(User user) {
        if (userRepository.existsByUserName(user.getUserName())) {
            throw new RuntimeException("Username already exists!");
        }
        if (userRepository.existsByEmail(user.getEmail())) {
            throw new RuntimeException("Email already exists!");
        }
        
        // ✅ ENCRYPT PASSWORD BEFORE SAVING
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        
        return userRepository.save(user);
    }
    
    public boolean testPassword(String email, String plainPassword) {
        User user = userRepository.findByEmail(email).orElse(null);
        if (user != null) {
            boolean matches = passwordEncoder.matches(plainPassword, user.getPassword());
            System.out.println("🔍 Password match for " + email + ": " + matches);
            System.out.println("Plain: " + plainPassword);
            System.out.println("Encoded: " + user.getPassword());
            return matches;
        }
        return false;
    }

    
    // Show All Users
    public java.util.List<User> getAllUsers() {
        return userRepository.findAll();
    }
    
    // Get User by ID
    public Optional<User> getUserById(Integer id) {
        return userRepository.findById(id);
    }
    
    // Login User
    public User loginUser(String userName, String password) {
        Optional<User> user = userRepository.findByUserName(userName);
        
        if (user.isPresent()) {
            //  USE BCRYPT TO COMPARE PASSWORDS
            if (passwordEncoder.matches(password, user.get().getPassword())) {
                return user.get();
            } else {
                throw new RuntimeException("Invalid password!");
            }
        } else {
            throw new RuntimeException("User not found!");
        }
    }
    
    // Update User
    public User updateUser(Integer id, User userDetails) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found!"));
        
        user.setFirstName(userDetails.getFirstName());
        user.setLastName(userDetails.getLastName());
        user.setEmail(userDetails.getEmail());
        user.setMobile(userDetails.getMobile());
        user.setAddress1(userDetails.getAddress1());
        user.setAddress2(userDetails.getAddress2());
        user.setCity(userDetails.getCity());
        user.setState(userDetails.getState());
        user.setZipCode(userDetails.getZipCode());
        user.setCountry(userDetails.getCountry());
        
        // ✅ IF PASSWORD IS BEING UPDATED, ENCRYPT IT
        if (userDetails.getPassword() != null && !userDetails.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(userDetails.getPassword()));
        }
        
        return userRepository.save(user);
    }
    
    // Delete User
    public void deleteUser(Integer id) {
        userRepository.deleteById(id);
    }
}
