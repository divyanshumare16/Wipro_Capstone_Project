<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Songs to Playlist</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
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
        .btn-back {
            padding: 10px 20px;
            background: #333;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
        }
        .header-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        h1 {
            color: #667eea;
            font-size: 28px;
            margin-bottom: 10px;
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
        }
        .search-box input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .songs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }
        .song-card {
            background: white;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .song-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .song-name {
            font-size: 18px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        .song-meta {
            font-size: 13px;
            color: #666;
            margin-bottom: 15px;
        }
        .btn-add {
            width: 100%;
            padding: 10px;
            background: #4caf50;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-add:hover {
            background: #45a049;
        }
        .btn-add:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        .badge {
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            display: inline-block;
            margin-top: 5px;
        }
        .badge-free {
            background: #4caf50;
            color: white;
        }
        .badge-premium {
            background: #ff9800;
            color: white;
        }
        .badge-added {
            background: #999;
            color: white;
        }
        .loading {
            text-align: center;
            padding: 60px;
            color: white;
            font-size: 20px;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 10px;
            text-align: center;
            display: none;
        }
        .success {
            background: #d4edda;
            color: #155724;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
        }
        .no-songs {
            background: white;
            padding: 60px;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            color: #999;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h2 id="pageTitle">🎵 Add Songs to Playlist</h2>
        <a href="#" onclick="goBack(); return false;" class="btn-back">← Back to Playlist</a>
    </div>
    
    <div class="container">
        <div class="header-section">
            <h1>Available Songs</h1>
            <p>Browse and add songs to your playlist</p>
        </div>
        
        <div class="search-section">
            <div class="search-box">
                <input type="text" id="searchInput" placeholder="🔍 Search songs by name, artist, album, or music director...">
            </div>
        </div>
        
        <div id="message" class="message"></div>
        
        <div id="songsList" class="loading">Loading available songs...</div>
    </div>
    
    <script>
        let currentPlaylistId = null;
        let allSongs = [];
        let playlistSongIds = [];
        
        window.onload = function() {
            const user = JSON.parse(localStorage.getItem('user'));
            if (!user) {
                window.location.href = '/login';
                return;
            }
            
            const pathParts = window.location.pathname.split('/');
            currentPlaylistId = pathParts[2];
            
            console.log('Playlist ID:', currentPlaylistId);
            
            loadPlaylistInfo();
            loadExistingSongs();
            loadAvailableSongs();
        };
        
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const filtered = allSongs.filter(function(song) {
                return (song.songName && song.songName.toLowerCase().includes(searchTerm)) ||
                       (song.singer && song.singer.toLowerCase().includes(searchTerm)) ||
                       (song.albumName && song.albumName.toLowerCase().includes(searchTerm)) ||
                       (song.musicDirector && song.musicDirector.toLowerCase().includes(searchTerm));
            });
            displaySongs(filtered);
        });
        
        async function loadPlaylistInfo() {
            try {
                const response = await fetch('http://localhost:8081/api/playlists/' + currentPlaylistId);
                if (!response.ok) {
                    throw new Error('Failed to load playlist');
                }
                const playlist = await response.json();
                document.getElementById('pageTitle').textContent = '🎵 Add Songs to "' + playlist.playlistName + '"';
            } catch (error) {
                console.error('Error loading playlist info:', error);
                showMessage('Error loading playlist: ' + error.message, 'error');
            }
        }
        
        async function loadExistingSongs() {
            try {
                const response = await fetch('http://localhost:8081/api/playlist-songs/playlist/' + currentPlaylistId);
                if (!response.ok) {
                    console.log('No existing songs in playlist');
                    playlistSongIds = [];
                    return;
                }
                const songs = await response.json();
                playlistSongIds = songs.map(function(s) { return s.libraryId; });
                console.log('Existing song IDs:', playlistSongIds);
            } catch (error) {
                console.error('Error loading existing songs:', error);
                playlistSongIds = [];
            }
        }
        
        async function loadAvailableSongs() {
            try {
                console.log('Fetching songs from Admin Service...');
                
                // Try to fetch all songs from Admin Service
                const response = await fetch('http://localhost:8082/api/songs/all');
                
                if (!response.ok) {
                    throw new Error('Failed to fetch songs from Admin Service (Status: ' + response.status + ')');
                }
                
                const songs = await response.json();
                console.log('Loaded songs:', songs);
                
                // Filter only available songs
                allSongs = songs.filter(function(song) {
                    return song.songStatus === 'AVAILABLE';
                });
                
                console.log('Available songs:', allSongs);
                
                if (allSongs.length === 0) {
                    document.getElementById('songsList').innerHTML = 
                        '<div class="no-songs">' +
                            '<h3>No songs available</h3>' +
                            '<p>The admin hasn\'t added any songs yet.</p>' +
                        '</div>';
                } else {
                    displaySongs(allSongs);
                }
                
            } catch (error) {
                console.error('Error loading songs:', error);
                showMessage('Error loading songs: ' + error.message, 'error');
                document.getElementById('songsList').innerHTML = 
                    '<div class="no-songs">' +
                        '<h3>Failed to load songs</h3>' +
                        '<p>Error: ' + error.message + '</p>' +
                        '<p>Make sure Admin Service is running on port 8082</p>' +
                    '</div>';
            }
        }
        
        function displaySongs(songs) {
            const container = document.getElementById('songsList');
            
            if (songs.length === 0) {
                container.innerHTML = '<div class="no-songs"><h3>No songs found</h3></div>';
                return;
            }
            
            container.className = 'songs-grid';
            
            let html = '';
            for (let i = 0; i < songs.length; i++) {
                const song = songs[i];
                const isAdded = playlistSongIds.indexOf(song.libraryId) !== -1;
                const addedBadge = isAdded ? '<span class="badge badge-added">✓ Already Added</span>' : '';
                
                html += '<div class="song-card">' +
                    '<div class="song-name">🎵 ' + escapeHtml(song.songName) + '</div>' +
                    '<div class="song-meta">' +
                        '🎤 ' + escapeHtml(song.singer || 'Unknown') + '<br>' +
                        '🎹 ' + escapeHtml(song.musicDirector || 'Unknown') + '<br>' +
                        '💿 ' + escapeHtml(song.albumName || 'Unknown Album') +
                    '</div>' +
                    '<span class="badge badge-' + song.songType.toLowerCase() + '">' + song.songType + '</span> ' +
                    addedBadge +
                    '<br><br>' +
                    '<button class="btn-add" ' +
                        'onclick="addToPlaylist(' + song.libraryId + ', \'' + escapeHtml(song.songName) + '\')" ' +
                        (isAdded ? 'disabled' : '') + '>' +
                        (isAdded ? '✓ Added' : '+ Add to Playlist') +
                    '</button>' +
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
        
        async function addToPlaylist(libraryId, songName) {
            try {
                const data = {
                    playlistId: parseInt(currentPlaylistId),
                    libraryId: libraryId,
                    songOrder: playlistSongIds.length
                };
                
                console.log('Adding song to playlist:', data);
                
                const response = await fetch('http://localhost:8081/api/playlist-songs/add', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(data)
                });
                
                if (response.ok) {
                    showMessage('"' + songName + '" added to playlist!', 'success');
                    playlistSongIds.push(libraryId);
                    displaySongs(allSongs); // Refresh display
                } else {
                    const error = await response.text();
                    showMessage('Error: ' + error, 'error');
                }
            } catch (error) {
                console.error('Error adding song:', error);
                showMessage('Error adding song: ' + error.message, 'error');
            }
        }
        
        function goBack() {
            window.location.href = '/playlists/' + currentPlaylistId;
        }
        
        function showMessage(text, type) {
            const messageDiv = document.getElementById('message');
            messageDiv.className = 'message ' + type;
            messageDiv.textContent = text;
            messageDiv.style.display = 'block';
            
            setTimeout(function() {
                messageDiv.style.display = 'none';
            }, 3000);
        }
    </script>
</body>
</html>
