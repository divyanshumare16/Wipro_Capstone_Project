<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <link rel="preload" as ="image" href="/images/LoginBG3.jpg">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: Arial, sans-serif; 
            /* ✅ BACKGROUND IMAGE INSTEAD OF GRADIENT */
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
            max-width: 550px;
            width: 90%;
        }
        h2 { color: #667eea; margin-bottom: 30px; text-align: center; font-size: 28px;}
        .form-group {
            margin-bottom: 20px;
        }
        label { display: block; margin-bottom: 8px; font-weight: bold; font-size: 16px;}
        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        .btn {
            width: 100%;
            padding: 16px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            font-weight: bold;
        	margin-top: 10px;
        }
        .btn:hover { background: #764ba2; }
        .message { 
            padding: 12px; 
            margin-bottom: 20px; 
            border-radius: 5px; 
            text-align: center;
            display: none;
            font-size: 15px;
        }
        .error { background: #f8d7da; color: #721c24; }
        .link { text-align: center; margin-top: 15px; }
        .link a { color: #667eea; text-decoration: none; }
    </style>
</head>
<body>
    <div class="container">
        <h2>🔐 User Login</h2>
        <div id="message" class="message"></div>
        
        <form id="loginForm">
            <div class="form-group">
                <label>Email</label>
                <input type="text" name="userName" required>
            </div>
            
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required>
            </div>
            
            <button type="submit" class="btn">Login</button>
        </form>
        
        <div class="link">
            Don't have an account? <a href="/register">Register here</a>
        </div>
    </div>
    
  <script>
    document.getElementById('loginForm').addEventListener('submit', async function(e) {
        e.preventDefault();
        
        const loginData = {
            email: this.userName.value,
            password: this.password.value
        };
        
        const messageDiv = document.getElementById('message');
        messageDiv.style.display = 'none'; // Clear previous messages
        
        try {
            const response = await fetch('http://localhost:8081/api/auth/login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(loginData)
            });
            
            // ✅ ALWAYS PARSE AS JSON (both success and error)
            const data = await response.json();
            
            if (response.ok) {
                // ✅ SUCCESS - Save JWT and user data
                localStorage.setItem('jwt_token', data.token);
                localStorage.setItem('user_id', data.userId);
                localStorage.setItem('user_email', data.email);
                localStorage.setItem('user_name', data.username);
                
                // ✅ Fetch full user details
                try {
                    const userResponse = await fetch('http://localhost:8081/api/users/' + data.userId, {
                        headers: {
                            'Authorization': 'Bearer ' + data.token
                        }
                    });
                    
                    if (userResponse.ok) {
                        const user = await userResponse.json();
                        localStorage.setItem('user', JSON.stringify(user));
                    }
                } catch (err) {
                    console.warn('Could not fetch full user details:', err);
                }
                
                // Redirect to dashboard
                window.location.href = '/dashboard';
                
            } else {
                // ✅ ERROR - Extract message from ErrorResponse JSON
                messageDiv.className = 'message error';
                messageDiv.textContent = data.message || 'Login failed. Please try again.';
                messageDiv.style.display = 'block';
            }
            
        } catch (error) {
            console.error('Login error:', error);
            messageDiv.className = 'message error';
            messageDiv.textContent = 'Network error. Please check your connection and try again.';
            messageDiv.style.display = 'block';
        }
    });
</script>


</body>
</html>
