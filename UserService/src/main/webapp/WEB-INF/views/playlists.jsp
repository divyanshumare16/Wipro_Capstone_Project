<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Playlists</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
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
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .navbar h2 {
            color: #667eea;
            font-size: 24px;
        }
        .nav-buttons {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 10px 20px;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
        }
        .btn:hover {
            background: #764ba2;
            transform: translateY(-2px);
        }
        .btn-create {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .btn-back {
            background: #333;
        }
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 20px;
        }
        .header-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        h1 { 
            color: #667eea;
            font-size: 32px;
        }
        .user-info {
            font-size: 14px;
            color: #666;
        }
        .search-section {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .search-box input {
            width: 100%;
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            font-size: 15px;
            transition: all 0.3s ease;
        }
        .search-box input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .playlists-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }
        .playlist-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
        }
        .playlist-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        .playlist-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        .playlist-name {
            font-size: 22px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        .playlist-description {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
            min-height: 40px;
        }
        .playlist-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 1px solid #e0e0e0;
            font-size: 13px;
            color: #999;
        }
        .song-count {
            display: flex;
            align-items: center;
            gap: 5px;
            font-weight: 600;
            color: #667eea;
        }
        .playlist-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        .btn-small {
            padding: 8px 15px;
            font-size: 12px;
            flex: 1;
        }
        .btn-view {
            background: #667eea;
        }
        .btn-edit {
            background: #ff9800;
        }
        .btn-delete {
            background: #f44336;
        }
        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }
        .badge-public {
            background: #4caf50;
            color: white;
        }
        .badge-private {
            background: #999;
            color: white;
        }
        .loading {
            text-align: center;
            padding: 60px;
            color: white;
            font-size: 20px;
        }
        .no-playlists {
            background: white;
            padding: 60px;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .no-playlists h3 {
            color: #999;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .empty-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 10px;
            text-align: center;
            display: none;
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
    </style>
</head>
<body>
    <div class="navbar">
        <h2>🎵 My Playlists</h2>
        <div class="nav-buttons">
            <a href="/playlists/create" class="btn btn-create">+ Create New Playlist</a>
            <a href="/dashboard" class="btn btn-back">← Back to Dashboard</a>
        </div>
    </div>
    
    <div class="container">
        <div class="header-section">
            <div>
                <h1>My Music Collection</h1>
                <p class="user-info">Welcome back, <span id="userName"></span>!</p>
            </div>
            <div>
                <div style="text-align: center;">
                    <div style="font-size: 36px; font-weight: 700; color: #667eea;" id="totalPlaylists">0</div>
                    <div style="font-size: 12px; color: #999;">Total Playlists</div>
                </div>
            </div>
        </div>
        
        <div class="search-section">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="🔍 Search your playlists...">
            </div>
        </div>
        
        <div id="message" class="message"></div>
        
        <div id="playlistsList" class="loading">Loading your playlists...</div>
    </div>
    
    <script>
        let allPlaylists = [];
        let currentUser = null;
        let jwtToken = null;
        
        window.onload = function() {
            // Get user from localStorage
            jwtToken = localStorage.getItem('jwt_token');
            if(!jwtToken){
                window.location.href = '/login';
                return;
            }
            
            const user = JSON.parse(localStorage.getItem('user'));
            
            if (!user) {
                window.location.href = '/login';
                return;
            }
            
            currentUser = user;
            document.getElementById('userName').textContent = user.firstName + ' ' + user.lastName;
            
            loadPlaylists();
        };
        
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const filtered = allPlaylists.filter(function(playlist) {
                const nameMatch = playlist.playlistName ? playlist.playlistName.toLowerCase().includes(searchTerm) : false;
                const descMatch = playlist.description ? playlist.description.toLowerCase().includes(searchTerm) : false;
                return nameMatch || descMatch;
            });
            displayPlaylists(filtered);
        });
        
        async function loadPlaylists() {
            try {
                const response = await fetch('http://localhost:8081/api/playlists/user/' + currentUser.userId, {
                    headers: {
                        'Authorization': 'Bearer ' + jwtToken,
                        'Content-Type': 'application/json'
                    }
                });

                if (!response.ok) {
                    if (response.status === 401 || response.status === 403) {
                        handleTokenExpired();
                        return;
                    }
                    const err = await response.json();
                    throw new Error(err.message || 'Failed to fetch playlists');
                }

                allPlaylists = await response.json();

                // load song counts
                for (let i = 0; i < allPlaylists.length; i++) {
                    try {
                        const countResp = await fetch(
                            'http://localhost:8081/api/playlist-songs/playlist/' + allPlaylists[i].playlistId + '/count',
                            {
                                headers: {
                                    'Authorization': 'Bearer ' + jwtToken,
                                    'Content-Type': 'application/json'
                                }
                            }
                        );
                        if (countResp.ok) {
                            allPlaylists[i].songCount = await countResp.json();
                        } else {
                            allPlaylists[i].songCount = 0;
                        }
                    } catch (e) {
                        allPlaylists[i].songCount = 0;
                    }
                }

                displayPlaylists(allPlaylists);
                document.getElementById('totalPlaylists').textContent = allPlaylists.length;

            } catch (error) {
                console.error('Error loading playlists:', error);
                showMessage('Error loading playlists: ' + error.message, 'error');
                document.getElementById('playlistsList').innerHTML =
                    '<div class="no-playlists"><div class="empty-icon">❌</div>' +
                    '<h3>Failed to load playlists</h3></div>';
            }
        }
        function displayPlaylists(playlists) {
            const container = document.getElementById('playlistsList');
            
            if (playlists.length === 0) {
                container.innerHTML = 
                    '<div class="no-playlists">' +
                        '<div class="empty-icon">🎵</div>' +
                        '<h3>No playlists yet</h3>' +
                        '<p>Create your first playlist to organize your favorite songs!</p>' +
                        '<br>' +
                        '<a href="/playlists/create" class="btn btn-create">+ Create Your First Playlist</a>' +
                    '</div>';
                return;
            }
            
            container.className = 'playlists-grid';
            
            let html = '';
            for (let i = 0; i < playlists.length; i++) {
                const playlist = playlists[i];
                const createdDate = new Date(playlist.createdAt).toLocaleDateString();
                const songCountValue = playlist.songCount ? playlist.songCount : 0;
                const visibilityBadge = playlist.isPublic ? 
                    '<span class="badge badge-public">Public</span>' : 
                    '<span class="badge badge-private">Private</span>';
                
                html += '<div class="playlist-card">' +
                    '<div class="playlist-icon">🎧</div>' +
                    '<div class="playlist-name">' + escapeHtml(playlist.playlistName) + '</div>' +
                    '<div class="playlist-description">' + escapeHtml(playlist.description || 'No description') + '</div>' +
                    '<div class="playlist-meta">' +
                        '<div class="song-count">' +
                            '<span>🎵</span>' +
                            '<span>' + songCountValue + ' songs</span>' +
                        '</div>' +
                        visibilityBadge +
                    '</div>' +
                    '<div style="font-size: 12px; color: #999; margin-top: 10px;">' +
                        'Created: ' + createdDate +
                    '</div>' +
                    '<div class="playlist-actions">' +
                        '<button class="btn btn-small btn-view" onclick="viewPlaylist(' + playlist.playlistId + ')">' +
                            '👁️ View' +
                        '</button>' +
                        '<button class="btn btn-small btn-edit" onclick="editPlaylist(' + playlist.playlistId + ')">' +
                            '✏️ Edit' +
                        '</button>' +
                        '<button class="btn btn-small btn-delete" onclick="deletePlaylist(' + playlist.playlistId + ', \'' + escapeHtml(playlist.playlistName) + '\')">' +
                            '🗑️ Delete' +
                        '</button>' +
                    '</div>' +
                '</div>';
            }
            
            container.innerHTML = html;
        }
        
        function escapeHtml(text) {
            if (!text) return '';
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
        
        function viewPlaylist(playlistId) {
            window.location.href = '/playlists/' + playlistId;
        }
        
        function editPlaylist(playlistId) {
            window.location.href = '/playlists/' + playlistId + '/edit';
        }
        
        async function deletePlaylist(playlistId, playlistName) {
            if (!confirm('Are you sure you want to delete "' + playlistName + '"? This will remove all songs from the playlist.')) {
                return;
            }

            try {
                const response = await fetch('http://localhost:8081/api/playlists/' + playlistId, {
                    method: 'DELETE',
                    headers: {
                        'Authorization': 'Bearer ' + jwtToken,
                        'Content-Type': 'application/json'
                    }
                });

                const data = await response.json();  // ✅ parse JSON error/success

                if (response.ok) {
                    showMessage('Playlist deleted successfully!', 'success');
                    loadPlaylists();
                } else if (response.status === 401 || response.status === 403) {
                    handleTokenExpired();
                } else {
                    showMessage('Error: ' + (data.message || 'Failed to delete playlist'), 'error');
                }
            } catch (error) {
                showMessage('Error deleting playlist: ' + error.message, 'error');
            }
        }

        function showMessage(text, type) {
            const messageDiv = document.getElementById('message');
            messageDiv.className = 'message ' + type;
            messageDiv.textContent = text;
            messageDiv.style.display = 'block';
            
            setTimeout(function() {
                messageDiv.style.display = 'none';
            }, 5000);
        }
        function handleTokenExpired() {
            showMessage('Your session has expired. Please login again.', 'error');
            setTimeout(function() {
                localStorage.removeItem('user');
                localStorage.removeItem('jwt_token');
                localStorage.removeItem('user_id');
                localStorage.removeItem('user_email');
                localStorage.removeItem('user_name');
                window.location.href = '/login';
            }, 2000);
        }
                

        
    </script>
</body>
</html>
