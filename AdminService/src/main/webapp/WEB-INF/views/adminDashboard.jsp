<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
        }
        
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            position: relative;
        }
        
        /* Blurred Background Image */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('/images/BG-IMG.jpeg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            filter: blur(8px);
            -webkit-filter: blur(8px);
            z-index: -2;
        }
        
        /* Dark overlay for better readability */
        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: -1;
        }
        
        /* Navbar - Dark Theme */
        .navbar {
            background: rgba(20, 20, 20, 0.95);
            backdrop-filter: blur(10px);
            color: white;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 20px rgba(0,0,0,0.5);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .navbar h2 {
            font-size: 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        /* Container */
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 20px;
        }
        
        /* Admin Info Section - Dark Theme */
        .admin-info {
            background: rgba(30, 30, 30, 0.9);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.5);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .admin-info h3 {
            color: white;
            font-size: 26px;
            margin-bottom: 10px;
        }
        
        .admin-info p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 16px;
        }
        
        /* Menu Cards - Keep Original White Style */
        .menu-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .card {
            background: white;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
        }
        
        .card h3 { 
            color: #f44336;
            margin-bottom: 15px;
            font-size: 22px;
        }
        
        .card p {
            color: #666;
            margin-bottom: 20px;
            font-size: 15px;
        }
        
        /* Buttons */
        .btn {
            display: inline-block;
            padding: 12px 25px;
            background: #f44336;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            margin: 5px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn:hover { 
            background: #e91e63;
            transform: scale(1.05);
        }
        
        .logout-btn {
            background: linear-gradient(135deg, #333 0%, #1a1a1a 100%);
            padding: 10px 25px;
        }
        
        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <div>
            <h2>🎵 Music Library - Admin Dashboard</h2>
        </div>
        <div>
            <button class="btn logout-btn" onclick="logout()">Logout</button>
        </div>
    </div>
    
	    
	<div id="networkError" style="display: none; background: #f8d7da; color: #721c24; padding: 15px; margin: 20px; border-radius: 8px; text-align: center;">
	    ⚠️ Network error. Please check if all services are running.
	    <br><button class="btn" onclick="location.reload()" style="margin-top: 10px;">Retry</button>
	</div>
    
    
    <!-- Main Container -->
    <div class="container">
        <!-- Admin Info Section -->
        <div class="admin-info">
            <h3>Welcome, <span id="adminName"></span>!</h3>
            <p>Email: <span id="adminEmail"></span></p>
        </div>
        
        <!-- Menu Cards -->
        <div class="menu-cards">
            <div class="card">
                <h3>📝 Add Song</h3>
                <p>Add new songs to the library</p>
                <a href="/admin/add-song" class="btn">Go to Add Song</a>
            </div>
            
            <div class="card">
                <h3>🎵 View All Songs</h3>
                <p>See all songs in the library</p>
                <a href="/admin/songs" class="btn">View Songs</a>
            </div>
            
            <div class="card">
                <h3>👥 View Users</h3>
                <p>Manage registered users</p>
                <a href="http://localhost:8081/users" class="btn">View Users</a>
            </div>
        </div>
    </div>
   
<script>
window.addEventListener('online', () => document.getElementById('networkError')?.style.setProperty('display', 'none'));
window.addEventListener('offline', () => document.getElementById('networkError')?.style.setProperty('display', 'block'));


const adminData = localStorage.getItem('admin');
if (!adminData) {
    window.location.href = '/admin/login';
} else {
    const admin = JSON.parse(adminData);
    console.log('Admin data:', admin); // DEBUG
    
    //  AuthResponse: adminName, email, token
    document.getElementById('adminName').textContent = admin.adminName || 'Admin';
    document.getElementById('adminEmail').textContent = admin.email || 'No email';
}

function logout() {
    if (confirm('Are you sure you want to logout?')) {
        localStorage.removeItem('admin');
        window.location.href = '/admin/login';
    }
}
</script>
</body>
</html>
