<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <link rel="preload" as="image" href="/images/LoginBG3.jpg">
    
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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
            padding: 20px;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            max-width: 700px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
        }
        h2 { 
            color: #667eea; 
            margin-bottom: 30px; 
            text-align: center;
            font-size: 28px;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        label { 
            display: block; 
            margin-bottom: 8px; 
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        label .required {
            color: #e74c3c;
            margin-left: 3px;
        }
        input, select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            margin-top: 10px;
            transition: transform 0.2s ease;
        }
        .btn:hover { 
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .btn:active {
            transform: translateY(0);
        }
        .message { 
            padding: 12px; 
            margin-bottom: 20px; 
            border-radius: 8px; 
            text-align: center;
            display: none;
            font-weight: 500;
        }
        .success { 
            background: #d4edda; 
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error { 
            background: #f8d7da; 
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .link { 
            text-align: center; 
            margin-top: 20px;
            font-size: 14px;
        }
        .link a { 
            color: #667eea; 
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        .link a:hover {
            color: #764ba2;
            text-decoration: underline;
        }
        .section-title {
            color: #667eea;
            font-size: 16px;
            font-weight: 600;
            margin: 25px 0 15px 0;
            padding-bottom: 8px;
            border-bottom: 2px solid #e0e0e0;
        }
        .section-title:first-of-type {
            margin-top: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>📝 User Registration</h2>
        <div id="message" class="message"></div>
        
        <form id="registerForm">
            <!-- Personal Information -->
            <div class="section-title">Personal Information</div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>First Name <span class="required">*</span></label>
                    <input type="text" name="firstName" required placeholder="Enter first name">
                </div>
                
                <div class="form-group">
                    <label>Last Name <span class="required">*</span></label>
                    <input type="text" name="lastName" required placeholder="Enter last name">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Username <span class="required">*</span></label>
                    <input type="text" name="userName" required placeholder="Choose a username">
                </div>
                
                <div class="form-group">
                    <label>Email <span class="required">*</span></label>
                    <input type="email" name="email" required placeholder="your.email@example.com">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>Password <span class="required">*</span></label>
                    <input type="password" name="password" required placeholder="Create a strong password">
                </div>
                
                <div class="form-group">
                    <label>Mobile</label>
                    <input type="text" name="mobile" placeholder="Enter mobile number">
                </div>
            </div>
            
            <!-- Address Information -->
            <div class="section-title">Address Information</div>
            
            <div class="form-group full-width">
                <label>Address Line 1</label>
                <input type="text" name="address1" placeholder="Street address, P.O. box">
            </div>
            
            <div class="form-group full-width">
                <label>Address Line 2</label>
                <input type="text" name="address2" placeholder="Apartment, suite, unit, building, floor, etc.">
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>City</label>
                    <input type="text" name="city" placeholder="Enter city">
                </div>
                
                <div class="form-group">
                    <label>State</label>
                    <input type="text" name="state" placeholder="Enter state/province">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label>ZIP/Postal Code</label>
                    <input type="text" name="zipCode" placeholder="Enter ZIP/postal code">
                </div>
                
                <div class="form-group">
                    <label>Country</label>
                    <input type="text" name="country" placeholder="Enter country">
                </div>
            </div>
            
            <button type="submit" class="btn">Register</button>
        </form>
        
        <div class="link">
            Already have an account? <a href="/login">Login here</a>
        </div>
    </div>
    
   <script>
    document.getElementById('registerForm').addEventListener('submit', async function(e) {
        e.preventDefault();
        
        const formData = {
            firstName: this.firstName.value.trim(),
            lastName: this.lastName.value.trim(),
            userName: this.userName.value.trim(),
            password: this.password.value,
            email: this.email.value.trim(),
            mobile: this.mobile.value.trim() || null,
            address1: this.address1.value.trim() || null,
            address2: this.address2.value.trim() || null,
            city: this.city.value.trim() || null,
            state: this.state.value.trim() || null,
            zipCode: this.zipCode.value.trim() || null,
            country: this.country.value.trim() || null
        };
        
        const messageDiv = document.getElementById('message');
        messageDiv.style.display = 'none'; // Clear previous messages
        
        try {
            const response = await fetch('http://localhost:8081/api/auth/register', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });
            
            // ✅ ALWAYS PARSE AS JSON (both success and error)
            const data = await response.json();
            
            if (response.ok) {
                //  Store JWT and redirect
                messageDiv.className = 'message success';
                messageDiv.textContent = '✅ Registration successful! Redirecting to dashboard...';
                messageDiv.style.display = 'block';
                
                // Save JWT token and user data
                localStorage.setItem('jwt_token', data.token);
                localStorage.setItem('user_id', data.userId);
                localStorage.setItem('user_email', data.email);
                localStorage.setItem('user_name', data.username);
                
                // Clear form
                this.reset();
                
                // Redirect after 2 seconds
                setTimeout(() => {
                    window.location.href = '/dashboard';
                }, 2000);
                
            } else {
                //  Extract message from ErrorResponse JSON
                messageDiv.className = 'message error';
                messageDiv.textContent = data.message || 'Registration failed. Please try again.';
                messageDiv.style.display = 'block';
                
                // Hide message after 5 seconds
                setTimeout(() => {
                    messageDiv.style.display = 'none';
                }, 5000);
            }
            
        } catch (error) {
            console.error('Registration error:', error);
            messageDiv.className = 'message error';
            messageDiv.textContent = 'Network error. Please check your connection and try again.';
            messageDiv.style.display = 'block';
            
            setTimeout(() => {
                messageDiv.style.display = 'none';
            }, 5000);
        }
    });
</script>

</body>
</html>
