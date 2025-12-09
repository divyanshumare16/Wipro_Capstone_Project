<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Music Library - Home</title>
    <link rel="preload" as="image" href="/images/LoginBG3.jpg">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body { 
            font-family: Arial, sans-serif; 
            /* Background image instead of gradient */
            background-image: url('/images/LoginBG3.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 550px;
            width: 90%;
        }
        
        h1 { 
            color: #667eea; 
            margin-bottom: 15px;
            font-size: 32px;
        }
        
        p {
            color: #333;
            margin-bottom: 30px;
            font-size: 16px;
        }
        
        .btn {
            display: inline-block;
            padding: 14px 35px;
            margin: 8px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s;
            font-size: 16px;
            font-weight: 600;
        }
        
        .btn:hover { 
            background: #764ba2;
            transform: translateY(-2px);
        }
        
        .admin-btn {
            background: #f44336;
            margin-top: 15px;
        }
        
        .admin-btn:hover {
            background: #d32f2f;
        }
        
        .button-group {
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎵 Music Library</h1>
        <p>Welcome to Music Library Application</p>
        
        <div class="button-group">
            <a href="/login" class="btn">User Login</a>
            <a href="/register" class="btn">Register</a>
        </div>
        
        <a href="http://localhost:8082/admin/login" class="btn admin-btn">Admin Login</a>
    </div>
</body>
</html>
