<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
   <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    
    body { 
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        min-height: 100vh;
        position: relative;
        
        background-image: url('/images/ITACHI.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        background-attachment: fixed;
    }
    
    /*MINIMAL BLUR*/
    body::before {
        content: '';
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        background-image: url('/images/ITACHI.jpg');
        background-size: cover;
        background-position: center;
        filter: blur(1px); 
        z-index: -2;
    }
    
    /*  LIGHTER OVERLAY */
    body::after {
        content: '';
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0, 0, 0, 0.75); /* Less dark */
        z-index: -1;
    }
    
    .container {
        background: rgba(20, 20, 20, 0.92); /* Slightly more transparent */
        backdrop-filter: blur(10px); /* Reduced blur */
        padding: 45px 40px;
        border-radius: 20px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.4); /* Softer shadow */
        max-width: 420px;
        width: 90%;
        margin: 60px auto;
        border: 1px solid rgba(255, 100, 100, 0.2); /* Subtle red border */
    }
    
    h2 { 
        color: #ff8e8e; /* Softer red */
        margin-bottom: 30px; 
        text-align: center; 
        font-size: 32px;
        font-weight: 700;
        text-shadow: 0 1px 5px rgba(0,0,0,0.6); /* Subtle shadow */
    }
    
    .form-group { margin-bottom: 25px; }
    
    label { 
        display: block; 
        margin-bottom: 10px; 
        font-weight: 600; 
        color: #fff;
        font-size: 15px;
    }
    
    input {
        width: 100%;
        padding: 16px 20px;
        border: 2px solid rgba(255,255,255,0.15); /* Subtle border */
        border-radius: 12px;
        background: rgba(35,35,35,0.9);
        color: #fff;
        font-size: 16px;
        transition: all 0.3s ease;
    }
    
    input:focus {
        outline: none;
        border-color: #ff8e8e; /* Softer red */
        box-shadow: 0 0 12px rgba(255,142,142,0.2); /* Much less glow */
        background: rgba(45,45,45,0.95);
    }
    
    input::placeholder { color: rgba(255,255,255,0.4); }
    
    .btn {
        width: 100%;
        padding: 18px;
        background: linear-gradient(135deg, #ff8e8e 0%, #ff6b6b 100%); /* Softer orange-red */
        color: white;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-size: 18px;
        font-weight: 700;
        transition: all 0.3s ease;
        box-shadow: 0 5px 15px rgba(255,142,142,0.3); /* Subtle shadow */
    }
    
    .btn:hover:not(:disabled) { 
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(255,142,142,0.4); /* Less intense */
        background: linear-gradient(135deg, #ff6b6b 0%, #ff8e8e 100%);
    }
    
    .btn:disabled { opacity: 0.6; cursor: not-allowed; transform: none; }
    
    .message { 
        padding: 15px; 
        margin-bottom: 20px; 
        border-radius: 12px; 
        text-align: center;
        font-weight: 600;
        font-size: 15px;
        display: none;
        border: 2px solid;
    }
    
    .error { 
        background: rgba(244,67,54,0.15); 
        color: #ff8e8e; 
        border-color: #ff6b6b;
    }
    
    .link { text-align: center; margin-top: 25px; }
    .link a { 
        color: #ff8e8e; 
        text-decoration: none; 
        font-weight: 600;
        font-size: 15px;
        transition: all 0.3s ease;
    }
    .link a:hover { 
        color: #ff6b6b; 
        text-shadow: 0 0 8px rgba(255,107,107,0.3); 
    }
</style>
</head>
<body>
    <div class="container">
        <h2>🔐 Admin Login</h2>
        <div id="message" class="message"></div>
        
        <form id="adminLoginForm">
            <div class="form-group">
                <label>📧 Email</label>
                <input type="email" id="email" name="userName" required placeholder="admin@music.com">
            </div>
            
            <div class="form-group">
                <label>🔒 Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>
            
            <button type="submit" class="btn">🚀 Login as Admin</button>
        </form>
        
        <div class="link">
            <a href="http://localhost:8081/">← Back to Home</a>
        </div>
    </div>
    
   <script>
document.getElementById('adminLoginForm').addEventListener('submit', async function(e) {
    e.preventDefault();

    const submitBtn = this.querySelector('button[type="submit"]');
    const messageDiv = document.getElementById('message');

    //  Disable button
    submitBtn.disabled = true;
    submitBtn.textContent = 'Logging in...';
    messageDiv.style.display = 'none';

    const loginData = {
        email: document.getElementById('email').value,      // ✅ Email as credential
        password: document.getElementById('password').value
    };

    //  Upload file to file service
    const response = await fetch('http://localhost:8082/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(loginData)
    });

    if (response.ok) {
        const auth = await response.json();
        localStorage.setItem('admin', JSON.stringify(auth));
        window.location.href = '/admin/dashboard';
    } else {
        const error = await response.text();  
        messageDiv.className = 'message error';
        messageDiv.textContent = error;       //  Shows "Invalid credentials"
        messageDiv.style.display = 'block';
    }
    

    submitBtn.disabled = false;
    submitBtn.textContent = 'Login as Admin';
});
</script>
</body>
</html>
