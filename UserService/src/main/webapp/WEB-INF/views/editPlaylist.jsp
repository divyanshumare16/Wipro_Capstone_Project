<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Playlist</title>
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
        .message { 
            padding: 12px; 
            margin-bottom: 20px; 
            border-radius: 8px; 
            text-align: center;
            font-weight: 500;
        }
        .success { 
            background: #d4edda; 
            color: #155724;
        }
        .error { 
            background: #f8d7da; 
            color: #721c24;
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
        }
        .loading {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>✏️ Edit Playlist</h2>
        <div id="message" class="message" style="display:none;"></div>
        
        <div id="formContainer" class="loading">Loading playlist...</div>
    </div>
    
    <script>
        // Store globally
        window.playlistData = {
            id: null,
            playlist: null
        };
        
        // Parse ID immediately
        (function() {
            const pathParts = window.location.pathname.split('/');
            const id = parseInt(pathParts[2]);
            
            console.log('Full path:', window.location.pathname);
            console.log('Path parts:', pathParts);
            console.log('Parsed ID:', id);
            console.log('ID type:', typeof id);
            console.log('Is NaN:', isNaN(id));
            
            if (!id || isNaN(id)) {
                showError('Invalid playlist ID: ' + id);
                return;
            }
            
            window.playlistData.id = id;
            loadPlaylist();
        })();
        
        function loadPlaylist() {
            const id = window.playlistData.id;
            const url = '/api/playlists/' + id;
            
            console.log('Loading playlist...');
            console.log('Using ID:', id);
            console.log('Fetching URL:', url);
            
            fetch(url)
                .then(response => {
                    console.log('Response status:', response.status);
                    console.log('Response OK:', response.ok);
                    
                    if (!response.ok) {
                        return response.text().then(text => {
                            throw new Error('HTTP ' + response.status + ': ' + (text || 'Unknown error'));
                        });
                    }
                    
                    return response.json();
                })
                .then(playlist => {
                    console.log('Loaded playlist:', playlist);
                    window.playlistData.playlist = playlist;
                    displayForm(playlist);
                })
                .catch(error => {
                    console.error('Load error:', error);
                    showError('Failed to load playlist: ' + error.message);
                });
        }
        
        function displayForm(playlist) {
            const escapedName = escapeHtml(playlist.playlistName || '');
            const escapedDesc = escapeHtml(playlist.description || '');
            
            document.getElementById('formContainer').innerHTML = `
                <form id="editPlaylistForm">
                    <div class="form-group">
                        <label>Playlist Name <span class="required">*</span></label>
                        <input type="text" name="playlistName" value="${escapedName}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description">${escapedDesc}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <div class="checkbox-group">
                            <input type="checkbox" id="isPublic" name="isPublic" ${playlist.isPublic ? 'checked' : ''}>
                            <label for="isPublic">Make this playlist public</label>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn">Update Playlist</button>
                </form>
                
                <div class="link">
                <a id="backToPlaylistLink" href="#">← Back to Playlist</a>
            </div>

            `;
            
            document.getElementById('editPlaylistForm').addEventListener('submit', updatePlaylist);
        }
        
        function updatePlaylist(e) {
            e.preventDefault();
            
            const playlist = window.playlistData.playlist;
            if (!playlist) {
                showError('No playlist data available');
                return;
            }
            
            const formData = {
                playlistId: playlist.playlistId,
                userId: playlist.userId,
                playlistName: this.playlistName.value.trim(),
                description: this.description.value.trim() || null,
                isPublic: this.isPublic.checked
            };
            
            console.log('Updating playlist:', formData);
            
            const url = '/api/playlists/' + playlist.playlistId;
            console.log('PUT request to:', url);
            
            fetch(url, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            })
            .then(response => {
                console.log('Update response status:', response.status);
                
                if (response.ok) {
                    return response.json();
                } else {
                    return response.text().then(text => {
                        throw new Error(text || 'Failed to update playlist');
                    });
                }
            })
            .then(result => {
                console.log('Update success:', result);
                showSuccess('✅ Playlist updated successfully! Redirecting...');
                
                setTimeout(function() {
                    window.location.href = '/playlists/' + playlist.playlistId;
                }, 1500);
            })
            .catch(error => {
                console.error('Update error:', error);
                showError(error.message);
            });
        }
        
        function showError(message) {
            const messageDiv = document.getElementById('message');
            messageDiv.className = 'message error';
            messageDiv.textContent = '❌ ' + message;
            messageDiv.style.display = 'block';
            
            document.getElementById('formContainer').innerHTML = 
                '<div class="error" style="padding:20px; text-align:center;">' + message + '</div>';
        }
        
        function showSuccess(message) {
            const messageDiv = document.getElementById('message');
            messageDiv.className = 'message success';
            messageDiv.textContent = message;
            messageDiv.style.display = 'block';
        }
        
        function escapeHtml(text) {
            if (!text) return '';
            const map = {
                '&': '&amp;',
                '<': '&lt;',
                '>': '&gt;',
                '"': '&quot;',
                "'": '&#039;'
            };
            return String(text).replace(/[&<>"']/g, function(m) { return map[m]; });
        }
    </script>
</body>
</html>
