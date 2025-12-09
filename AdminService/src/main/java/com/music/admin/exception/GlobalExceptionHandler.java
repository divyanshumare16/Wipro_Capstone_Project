package com.music.admin.exception;

import com.music.admin.dto.ErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ControllerAdvice;  // ✅ CHANGED: ControllerAdvice
import org.springframework.web.context.request.WebRequest;

@ControllerAdvice  // ✅ CHANGED: Remove @Rest
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<String> handleResourceNotFoundException(  // ✅ CHANGED: String
            ResourceNotFoundException ex, WebRequest request) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
            .body(ex.getMessage());  // ✅ CHANGED: Plain text
    }
    

    @ExceptionHandler(BadRequestException.class)
    public ResponseEntity<String> handleBadRequestException(BadRequestException ex, WebRequest request) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ex.getMessage());
    }

    @ExceptionHandler(UnauthorizedException.class)
    public ResponseEntity<String> handleUnauthorizedException(  // ✅ CHANGED: String
            UnauthorizedException ex, WebRequest request) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
            .body(ex.getMessage());  // ✅ CHANGED: Plain text
    }
    
    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleGlobalException(  // ✅ CHANGED: String
            Exception ex, WebRequest request) {
        ex.printStackTrace();
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
            .body("Something went wrong. Please try again.");  // ✅ CHANGED: Plain text
    }
}
