<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Playlist</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            max-width: 600px;
            width: 100%;
        }
        h2 { 
            color: #667eea; 
            margin-bottom: 30px; 
            text-align: center;
            font-size: 28px;
        }
        .form-group {
            margin-bottom: 20px;
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
        input, textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
            font-family: inherit;
        }
        input:focus, textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .checkbox-group input[type="checkbox"] {
            width: auto;
            cursor: pointer;
        }
        .checkbox-group label {
            margin: 0;
            cursor: pointer;
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
        .icon {
            font-size: 48px;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">🎵</div>
        <h2>Create New Playlist</h2>
        <div id="message" class="message"></div>
        
        <form id="createPlaylistForm">
            <div class="form-group">
                <label>Playlist Name <span class="required">*</span></label>
                <input type="text" name="playlistName" required placeholder="Enter playlist name">
            </div>
            
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" placeholder="Describe your playlist..."></textarea>
            </div>
            
            <div class="form-group">
                <div class="checkbox-group">
                    <input type="checkbox" id="isPublic" name="isPublic">
                    <label for="isPublic">Make this playlist public</label>
                </div>
                <small style="color: #999; display: block; margin-top: 5px;">
                    Public playlists can be viewed by other users
                </small>
            </div>
            
            <button type="submit" class="btn">Create Playlist</button>
        </form>
        
        <div class="link">
            <a href="/playlists">← Back to My Playlists</a>
        </div>
    </div>
    
    <script>
        const currentUser = JSON.parse(localStorage.getItem('user'));
        
        if (!currentUser) {
            window.location.href = '/login';
        }
        
        document.getElementById('createPlaylistForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const formData = {
                userId: currentUser.userId,
                playlistName: this.playlistName.value.trim(),
                description: this.description.value.trim() || null,
                isPublic: this.isPublic.checked
            };
            
            try {
                const response = await fetch('http://localhost:8081/api/playlists/create', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(formData)
                });
                
                const messageDiv = document.getElementById('message');
                
                if (response.ok) {
                    const playlist = await response.json();
                    messageDiv.className = 'message success';
                    messageDiv.textContent = 'Playlist created successfully! Redirecting...';
                    messageDiv.style.display = 'block';
                    
                    // Clear form
                    this.reset();
                    
                    // Redirect to playlists page after 1.5 seconds
                    setTimeout(() => {
                        window.location.href = '/playlists';
                    }, 1500);
                } else {
                    const error = await response.text();
                    messageDiv.className = 'message error';
                    messageDiv.textContent = error || 'Failed to create playlist. Please try again.';
                    messageDiv.style.display = 'block';
                    
                    setTimeout(() => {
                        messageDiv.style.display = 'none';
                    }, 5000);
                }
            } catch (error) {
                const messageDiv = document.getElementById('message');
                messageDiv.className = 'message error';
                messageDiv.textContent = 'Network error: ' + error.message;
                messageDiv.style.display = 'block';
                
                setTimeout(() => {
                    messageDiv.style.display = 'none';
                }, 5000);
            }
        });
    </script>
</body>
</html>
