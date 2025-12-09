<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Playlist</title>
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
        .btn-add { background: #4caf50; }
        .btn-back { background: #333; }
        .btn-play { background: #4caf50; }
        .btn-play:hover { background: #45a049; }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            padding-bottom: 140px;
        }
        .playlist-header {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .playlist-info {
            display: flex;
            gap: 30px;
            align-items: start;
        }
        .playlist-icon-large {
            font-size: 80px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            width: 150px;
            height: 150px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .playlist-details { flex: 1; }
        .playlist-title {
            font-size: 32px;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        .playlist-description {
            font-size: 16px;
            color: #666;
            margin-bottom: 20px;
        }
        .playlist-stats {
            display: flex;
            gap: 30px;
            margin-top: 20px;
        }
        .stat-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            color: #999;
        }
        .stat-value {
            font-weight: 700;
            color: #667eea;
            font-size: 18px;
        }
        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            display: inline-block;
            margin-top: 10px;
        }
        .badge-public { background: #4caf50; color: white; }
        .badge-private { background: #999; color: white; }

        .dashboard-player {
            position: fixed;
            left: 0;
            right: 0;
            bottom: 0;
            z-index: 30;
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            box-shadow: 0 -8px 30px rgba(0,0,0,0.2);
            padding: 12px 40px 18px 40px;
            color: #222;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .player-progress-row {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 12px;
            color: #555;
        }
        .player-progress-bar { flex: 1; }
        #playerSeek {
            width: 100%;
            accent-color: #8c7bff;
            cursor: pointer;
        }
        .player-controls-row {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 24px;
            margin-top: 4px;
            position: relative;
        }
        .player-now {
            position: absolute;
            left: 0;
            display: flex;
            flex-direction: column;
            gap: 2px;
            max-width: 250px;
        }
        .player-now-title {
            font-size: 14px;
            font-weight: 600;
            color: #222;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .player-now-subtitle {
            font-size: 12px;
            color: #777;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .player-icon-btn {
            border: none;
            background: transparent;
            cursor: pointer;
            font-size: 20px;
            color: #666;
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.15s ease;
            border-radius: 50%;
        }
        .player-icon-btn:hover {
            background: rgba(0,0,0,0.1);
            color: #333;
        }
        .player-icon-btn.active { color: #8c7bff; }
        .player-play-btn {
            border: none;
            cursor: pointer;
            width: 56px;
            height: 56px;
            border-radius: 50%;
            background: #8c7bff;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            box-shadow: 0 8px 25px rgba(140,123,255,0.5);
            transition: transform 0.15s ease;
        }
        .player-play-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 30px rgba(140,123,255,0.7);
        }
        .player-volume {
            position: absolute;
            right: 0;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 12px;
            color: #555;
        }
        #playerVolume {
            width: 100px;
            accent-color: #8c7bff;
        }

        .songs-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 24px;
            font-weight: 700;
            color: #333;
        }
        .song-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .song-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        .song-item:hover {
            background: #e9ecef;
            transform: translateX(5px);
        }
        .song-item.now-playing {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.15) 0%, rgba(118, 75, 162, 0.15) 100%);
            border: 2px solid #8c7bff;
        }
        .song-info { flex: 1; }
        .song-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        .song-meta {
            font-size: 13px;
            color: #666;
        }
        .song-duration {
            font-size: 12px;
            color: #8c7bff;
            margin-top: 4px;
        }
        .song-actions {
            display: flex;
            gap: 10px;
        }
        .btn-small {
            padding: 8px 15px;
            font-size: 12px;
        }
        .btn-remove { background: #f44336; }
        .loading {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 16px;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        .empty-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }
        .empty-state h3 {
            color: #999;
            margin-bottom: 10px;
        }
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 10px;
            text-align: center;
            display: none;
        }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }

        .no-audio-badge {
            background: rgba(244, 67, 54, 0.2);
            color: #d32f2f;
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 10px;
            margin-left: 8px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h2 id="navTitle">🎵 Playlist Details</h2>
        <div class="nav-buttons">
            <button class="btn btn-add" onclick="addSongs()">+ Add Songs</button>
            <a href="/playlists" class="btn btn-back">← Back to Playlists</a>
        </div>
    </div>
    
    <div class="container">
        <div id="message" class="message"></div>
        
        <div class="playlist-header" id="playlistHeader">
            <div class="loading">Loading playlist details...</div>
        </div>
        
        <div class="songs-section">
            <div class="section-header">
                <div class="section-title">🎵 Songs in this Playlist</div>
                <button class="btn btn-play" onclick="playAll()">▶️ Play All</button>
            </div>
            <div id="songsList" class="loading">Loading songs...</div>
        </div>
    </div>

    <!-- Hidden audio element -->
    <audio id="audioElement" style="display:none;"></audio>
    
    <!-- Player -->
    <div class="dashboard-player">
        <div class="player-progress-row">
            <span id="currentTime">00:00</span>
            <div class="player-progress-bar">
                <input type="range" id="playerSeek" min="0" max="100" value="0">
            </div>
            <span id="totalTime">00:00</span>
        </div>

        <div class="player-controls-row">
            <div class="player-now">
                <span class="player-now-title" id="nowTitle">Select a song</span>
                <span class="player-now-subtitle" id="nowArtist">to start listening</span>
            </div>

            <button class="player-icon-btn" id="shuffleBtn" onclick="toggleShuffle()" title="Shuffle">🔀</button>
            <button class="player-icon-btn" id="prevBtn" onclick="prevTrack()" title="Previous">⏮</button>
            <button class="player-play-btn" id="playBtn" onclick="togglePlay()" title="Play/Pause">▶</button>
            <button class="player-icon-btn" id="nextBtn" onclick="nextTrack()" title="Next">⏭</button>
            <button class="player-icon-btn" id="repeatBtn" onclick="toggleRepeat()" title="Repeat">🔁</button>

            <div class="player-volume">
                <span>🔊</span>
                <input type="range" id="playerVolume" min="0" max="100" value="70" oninput="changeVolume(this.value)">
            </div>
        </div>
    </div>

<script>
    var currentPlaylistId = null;
    var currentPlaylist = null;
    var playlistSongs = [];
    var jwtToken = null;

    var ADMIN_BASE_URL = 'http://localhost:8082';

    // REAL AUDIO PLAYER STATE
    var audioElement = null;
    var isPlaying = false;
    var isShuffled = false;
    var isRepeating = false;
    var currentSongIndex = -1;
    var playerSongs = [];

    window.onload = function() {
        jwtToken = localStorage.getItem('jwt_token');
        
        if (!jwtToken) {
            window.location.href = '/login';
            return;
        }
        
        var user = JSON.parse(localStorage.getItem('user'));
        if (!user) {
            window.location.href = '/login';
            return;
        }
        
        var pathParts = window.location.pathname.split('/');
        currentPlaylistId = pathParts[pathParts.length - 1];

        // Initialize audio
        audioElement = document.getElementById('audioElement');
        setupAudioEvents();
        
        loadPlaylist();
        loadSongs();
    };

    function setupAudioEvents() {
        audioElement.addEventListener('timeupdate', function() {
            if (audioElement.duration) {
                var percent = (audioElement.currentTime / audioElement.duration) * 100;
                document.getElementById('playerSeek').value = percent;
                document.getElementById('currentTime').textContent = formatTime(audioElement.currentTime);
                document.getElementById('totalTime').textContent = formatTime(audioElement.duration);
            }
        });

        audioElement.addEventListener('ended', function() {
            if (isRepeating) {
                audioElement.currentTime = 0;
                audioElement.play();
            } else {
                nextTrack();
            }
        });

        audioElement.addEventListener('loadedmetadata', function() {
            document.getElementById('totalTime').textContent = formatTime(audioElement.duration);
        });

        document.getElementById('playerSeek').addEventListener('input', function() {
            if (audioElement.duration) {
                audioElement.currentTime = (this.value / 100) * audioElement.duration;
            }
        });

        audioElement.volume = 0.7;
    }
    
    async function loadPlaylist() {
        try {
            var response = await fetch('http://localhost:8081/api/playlists/' + currentPlaylistId, {
                headers: {
                    'Authorization': 'Bearer ' + jwtToken,
                    'Content-Type': 'application/json'
                }
            });
            
            var data = await response.json();
            
            if (response.ok) {
                currentPlaylist = data;
                displayPlaylistHeader(data);
            } else if (response.status === 403 || response.status === 401) {
                handleTokenExpired();
            } else {
                throw new Error(data.message || 'Playlist not found');
            }
        } catch (error) {
            console.error('Error loading playlist:', error);
            document.getElementById('playlistHeader').innerHTML = 
                '<div class="error">Failed to load playlist: ' + error.message + '</div>';
        }
    }
    
    function displayPlaylistHeader(playlist) {
        var visibilityBadge = playlist.isPublic ? 
            '<span class="badge badge-public">Public</span>' : 
            '<span class="badge badge-private">Private</span>';
        
        var createdDate = new Date(playlist.createdAt).toLocaleDateString();
        
        document.getElementById('playlistHeader').innerHTML = 
            '<div class="playlist-info">' +
                '<div class="playlist-icon-large">🎧</div>' +
                '<div class="playlist-details">' +
                    '<div class="playlist-title">' + escapeHtml(playlist.playlistName) + '</div>' +
                    '<div class="playlist-description">' + escapeHtml(playlist.description || 'No description') + '</div>' +
                    visibilityBadge +
                    '<div class="playlist-stats">' +
                        '<div class="stat-item">' +
                            '<span>📅</span>' +
                            '<span>Created: ' + createdDate + '</span>' +
                        '</div>' +
                        '<div class="stat-item">' +
                            '<span>🎵</span>' +
                            '<span id="songCount" class="stat-value">0</span>' +
                            '<span>songs</span>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
            '</div>';
        
        document.getElementById('navTitle').textContent = '🎵 ' + playlist.playlistName;
    }
    
    async function loadSongs() {
        try {
            var response = await fetch('http://localhost:8081/api/playlists/' + currentPlaylistId + '/songs', {
                headers: {
                    'Authorization': 'Bearer ' + jwtToken,
                    'Content-Type': 'application/json'
                }
            });
            
            var data = await response.json();
            
            if (response.ok) {
                var songs = Array.isArray(data) ? data : [];
                
                if (songs.length === 0) {
                    document.getElementById('songsList').innerHTML = 
                        '<div class="empty-state">' +
                            '<div class="empty-icon">🎵</div>' +
                            '<h3>No songs in this playlist yet</h3>' +
                            '<p>Click "Add Songs" to start building your playlist!</p>' +
                        '</div>';
                    document.getElementById('songCount').textContent = '0';
                    playlistSongs = [];
                    playerSongs = [];
                    return;
                }
                
                displaySongs(songs);
                document.getElementById('songCount').textContent = songs.length;
                playlistSongs = songs;
                playerSongs = songs.slice();
            } else if (response.status === 403 || response.status === 401) {
                handleTokenExpired();
            } else {
                throw new Error(data.message || 'Failed to load songs');
            }
        } catch (error) {
            console.error('Error loading songs:', error);
            document.getElementById('songsList').innerHTML = 
                '<div class="error">Failed to load songs: ' + error.message + '</div>';
        }
    }

    function displaySongs(songs) {
        var container = document.getElementById('songsList');
        container.className = 'song-list';
        
        var html = '';
        for (var i = 0; i < songs.length; i++) {
            var song = songs[i];
            var hasAudio = song.audioFilePath && song.audioFilePath.length > 0;
            var noAudioBadge = hasAudio ? '' : '<span class="no-audio-badge">No Audio</span>';
            
            var durationText = '';
            if (song.duration && song.duration > 0) {
                durationText = '<div class="song-duration">⏱️ ' + formatTime(song.duration) + '</div>';
            }

            var playBtnClass = hasAudio ? 'btn btn-small btn-play' : 'btn btn-small';
            var playBtnDisabled = hasAudio ? '' : 'disabled style="opacity:0.5;cursor:not-allowed;"';

            html += '<div class="song-item" id="song-item-' + i + '" onclick="playSong(' + i + ')">' +
                '<div class="song-info">' +
                    '<div class="song-name">🎵 ' + escapeHtml(song.songName || 'Unknown Song') + noAudioBadge + '</div>' +
                    '<div class="song-meta">' +
                        '🎤 ' + escapeHtml(song.singer || 'Unknown') + ' • ' +
                        '🎹 ' + escapeHtml(song.musicDirector || 'Unknown') + ' • ' +
                        '💿 ' + escapeHtml(song.albumName || 'Unknown Album') +
                    '</div>' +
                    durationText +
                '</div>' +
                '<div class="song-actions" onclick="event.stopPropagation()">' +
                    '<button class="' + playBtnClass + '" onclick="playSong(' + i + ')" ' + playBtnDisabled + '>▶️ Play</button>' +
                    '<button class="btn btn-small btn-remove" ' +
                        'onclick="removeSongByLibraryId(' + song.libraryId + ', \'' + escapeHtml(song.songName) + '\')">'+
                        '🗑️ Remove' +
                    '</button>' +
                '</div>' +
            '</div>';
        }
        container.innerHTML = html;
    }
    
    function escapeHtml(text) {
        if (!text) return '';
        var div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    function playAll() {
        // Find first song with audio
        for (var i = 0; i < playerSongs.length; i++) {
            if (playerSongs[i].audioFilePath) {
                currentSongIndex = i;
                playCurrentSong();
                return;
            }
        }
        showMessage('No songs have audio files in this playlist.', 'error');
    }

    function playSong(index) {
        if (index < 0 || index >= playerSongs.length) return;
        
        var song = playerSongs[index];
        if (!song.audioFilePath) {
            showMessage('No audio file available for: ' + song.songName, 'error');
            return;
        }

        currentSongIndex = index;
        playCurrentSong();
    }

    function playCurrentSong() {
        if (currentSongIndex < 0 || currentSongIndex >= playerSongs.length) return;
        
        var song = playerSongs[currentSongIndex];
        
        if (!song.audioFilePath) {
            nextTrack();
            return;
        }

        var audioUrl = ADMIN_BASE_URL + song.audioFilePath;
        
        audioElement.src = audioUrl;
        audioElement.load();
        audioElement.play().then(function() {
            isPlaying = true;
            document.getElementById('playBtn').textContent = '❚❚';
            updateNowPlaying();
            updateNowPlayingHighlight();
        }).catch(function(error) {
            console.error('Play error:', error);
            showMessage('Failed to play: ' + error.message, 'error');
        });
    }

    function togglePlay() {
        if (!playerSongs.length) {
            showMessage('No songs to play.', 'error');
            return;
        }

        if (currentSongIndex === -1) {
            playAll();
            return;
        }

        if (isPlaying) {
            audioElement.pause();
            isPlaying = false;
            document.getElementById('playBtn').textContent = '▶';
        } else {
            audioElement.play();
            isPlaying = true;
            document.getElementById('playBtn').textContent = '❚❚';
        }
    }

    function toggleShuffle() {
        isShuffled = !isShuffled;
        document.getElementById('shuffleBtn').classList.toggle('active', isShuffled);
    }

    function toggleRepeat() {
        isRepeating = !isRepeating;
        document.getElementById('repeatBtn').classList.toggle('active', isRepeating);
    }

    function changeVolume(v) {
        audioElement.volume = parseInt(v, 10) / 100;
    }

    function prevTrack() {
        if (!playerSongs.length) return;
        
        var attempts = 0;
        do {
            currentSongIndex--;
            if (currentSongIndex < 0) {
                currentSongIndex = playerSongs.length - 1;
            }
            attempts++;
        } while (!playerSongs[currentSongIndex].audioFilePath && attempts < playerSongs.length);

        if (playerSongs[currentSongIndex].audioFilePath) {
            playCurrentSong();
        }
    }

    function nextTrack() {
        if (!playerSongs.length) return;
        
        if (isShuffled) {
            var songsWithAudio = playerSongs.filter(function(s) { return s.audioFilePath; });
            if (songsWithAudio.length > 0) {
                var randomSong = songsWithAudio[Math.floor(Math.random() * songsWithAudio.length)];
                for (var i = 0; i < playerSongs.length; i++) {
                    if (playerSongs[i].libraryId === randomSong.libraryId) {
                        currentSongIndex = i;
                        break;
                    }
                }
            }
        } else {
            var attempts = 0;
            do {
                currentSongIndex = (currentSongIndex + 1) % playerSongs.length;
                attempts++;
            } while (!playerSongs[currentSongIndex].audioFilePath && attempts < playerSongs.length);
        }

        if (playerSongs[currentSongIndex].audioFilePath) {
            playCurrentSong();
        }
    }

    function updateNowPlaying() {
        if (currentSongIndex < 0 || currentSongIndex >= playerSongs.length) return;
        var s = playerSongs[currentSongIndex];
        document.getElementById('nowTitle').textContent = s.songName || 'Unknown song';
        document.getElementById('nowArtist').textContent = s.singer || 'Unknown artist';
    }

    function updateNowPlayingHighlight() {
        var allItems = document.querySelectorAll('.song-item');
        allItems.forEach(function(item) {
            item.classList.remove('now-playing');
        });

        if (currentSongIndex >= 0) {
            var currentItem = document.getElementById('song-item-' + currentSongIndex);
            if (currentItem) {
                currentItem.classList.add('now-playing');
            }
        }
    }

    function formatTime(seconds) {
        if (isNaN(seconds) || seconds === null) return '00:00';
        var mins = Math.floor(seconds / 60);
        var secs = Math.floor(seconds % 60);
        return (mins < 10 ? '0' : '') + mins + ':' + (secs < 10 ? '0' : '') + secs;
    }
    
    async function removeSongByLibraryId(libraryId, songName) {
        if (!confirm('Remove "' + songName + '" from this playlist?')) return;
        
        try {
            var response = await fetch('http://localhost:8081/api/playlist-songs/playlist/' + currentPlaylistId + '/song/' + libraryId, {
                method: 'DELETE',
                headers: {
                    'Authorization': 'Bearer ' + jwtToken,
                    'Content-Type': 'application/json'
                }
            });
            
            var data = await response.json();
            
            if (response.ok) {
                showMessage('Song removed successfully!', 'success');
                loadSongs();
            } else if (response.status === 403 || response.status === 401) {
                handleTokenExpired();
            } else {
                showMessage('Error: ' + (data.message || 'Failed to remove song'), 'error');
            }
        } catch (error) {
            console.error('Error removing song:', error);
            showMessage('Network error: ' + error.message, 'error');
        }
    }
    
    function addSongs() {
        window.location.href = '/playlists/' + currentPlaylistId + '/add-songs';
    }
    
    function handleTokenExpired() {
        showMessage('Your session has expired. Please login again.', 'error');
        setTimeout(function() {
            localStorage.removeItem('user');
            localStorage.removeItem('jwt_token');
            window.location.href = '/login';
        }, 2000);
    }
    
    function showMessage(text, type) {
        var messageDiv = document.getElementById('message');
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
