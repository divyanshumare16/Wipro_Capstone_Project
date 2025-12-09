<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Music Library - Dashboard</title>
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
    
    .top-navbar {
        background: rgba(20, 20, 20, 0.95);
        backdrop-filter: blur(10px);
        padding: 15px 40px;
        box-shadow: 0 2px 20px rgba(0,0,0,0.5);
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    .navbar-left {
        display: flex;
        gap: 20px;
        align-items: center;
    }
    
    .logo {
        font-size: 24px;
        font-weight: 700;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }
    
    .search-container {
        display: flex;
        gap: 10px;
    }
    
    .search-box {
        padding: 8px 15px;
        border: 2px solid rgba(255, 255, 255, 0.1);
        border-radius: 20px;
        width: 200px;
        font-size: 14px;
        background: rgba(40, 40, 40, 0.8);
        color: white;
        transition: all 0.3s ease;
    }
    
    .search-box::placeholder {
        color: rgba(255, 255, 255, 0.5);
    }
    
    .search-box:focus {
        outline: none;
        border-color: #667eea;
        background: rgba(50, 50, 50, 0.9);
    }
    
    .navbar-right {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    
    .user-info {
        font-weight: 600;
        color: white;
        margin-right: 10px;
    }
    
    .btn {
        padding: 10px 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
    }
    
    .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 20px rgba(102, 126, 234, 0.6);
    }
    
    .btn-create {
        background: linear-gradient(135deg, #4caf50 0%, #45a049 100%);
    }
    
    .btn-create:hover {
        box-shadow: 0 4px 20px rgba(76, 175, 80, 0.6);
    }
    
    .btn-logout {
        background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);
    }
    
    .btn-logout:hover {
        box-shadow: 0 4px 20px rgba(244, 67, 54, 0.6);
    }
    
    .container {
        max-width: 1400px;
        margin: 30px auto;
        padding: 0 20px;
        padding-bottom: 130px;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: rgba(30, 30, 30, 0.9);
        backdrop-filter: blur(10px);
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.5);
        display: flex;
        align-items: center;
        gap: 20px;
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 30px rgba(102, 126, 234, 0.4);
        border-color: rgba(102, 126, 234, 0.5);
    }
    
    .stat-icon {
        font-size: 48px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        width: 70px;
        height: 70px;
        border-radius: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .stat-info h3 {
        font-size: 32px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        margin-bottom: 5px;
    }
    
    .stat-info p {
        font-size: 14px;
        color: rgba(255, 255, 255, 0.7);
    }
    
    .section-header {
        background: rgba(30, 30, 30, 0.9);
        backdrop-filter: blur(10px);
        padding: 20px 30px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.5);
        margin-bottom: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    .section-header h2 {
        color: white;
        font-size: 24px;
    }
    
    .filter-buttons {
        display: flex;
        gap: 10px;
    }
    
    .filter-btn {
        padding: 8px 16px;
        background: rgba(50, 50, 50, 0.8);
        border: 2px solid rgba(255, 255, 255, 0.1);
        border-radius: 20px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        color: rgba(255, 255, 255, 0.7);
        transition: all 0.3s ease;
    }
    
    .filter-btn:hover {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-color: transparent;
    }
    
    .filter-btn.active {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-color: transparent;
    }
    
    .songs-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 20px;
    }
    
    .song-card {
        background: rgba(30, 30, 30, 0.9);
        backdrop-filter: blur(10px);
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.5);
        transition: all 0.3s ease;
        position: relative;
        border: 1px solid rgba(255, 255, 255, 0.1);
        cursor: pointer;
    }
    
    .song-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        border-color: rgba(102, 126, 234, 0.5);
    }

    .song-card.now-playing {
        border-color: #8c7bff;
        box-shadow: 0 0 20px rgba(140, 123, 255, 0.5);
    }
    
    .song-header {
        display: flex;
        justify-content: space-between;
        align-items: start;
        margin-bottom: 15px;
    }
    
    .song-icon {
        font-size: 40px;
    }
    
    .badge {
        padding: 5px 12px;
        border-radius: 15px;
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
    }
    
    .badge-free {
        background: linear-gradient(135deg, #4caf50 0%, #45a049 100%);
        color: white;
    }
    
    .badge-premium {
        background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%);
        color: white;
    }
    
    .song-name {
        font-size: 20px;
        font-weight: 700;
        color: white;
        margin-bottom: 10px;
    }
    
    .song-meta {
        font-size: 14px;
        color: rgba(255, 255, 255, 0.6);
        margin-bottom: 5px;
    }
    
    .song-meta strong {
        color: rgba(255, 255, 255, 0.9);
    }

    .song-duration {
        font-size: 12px;
        color: #8c7bff;
        margin-top: 8px;
    }
    
    .song-actions {
        display: flex;
        gap: 10px;
        margin-top: 15px;
    }

    .song-card-unavailable {
        opacity: 0.5;
        filter: grayscale(0.4);
    }

    .badge-unavailable {
        background: linear-gradient(135deg, #9e9e9e 0%, #616161 100%);
        color: #fff;
    }

    .disabled-btn {
        cursor: not-allowed;
        background: rgba(120,120,120,0.6);
        border-color: rgba(120,120,120,0.8);
    }
    
    .btn-small {
        padding: 8px 15px;
        font-size: 12px;
        flex: 1;
    }
    
    .btn-playlist {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }

    .btn-play {
        background: linear-gradient(135deg, #4caf50 0%, #45a049 100%);
    }
    
    .loading {
        text-align: center;
        padding: 60px;
        color: white;
        font-size: 20px;
        background: rgba(20, 20, 20, 0.8);
        border-radius: 15px;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    .no-songs {
        background: rgba(30, 30, 30, 0.9);
        backdrop-filter: blur(10px);
        padding: 60px;
        text-align: center;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.5);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    .no-songs h3 {
        color: rgba(255, 255, 255, 0.5);
        font-size: 24px;
        margin-top: 20px;
    }
    
    .no-songs p {
        color: rgba(255, 255, 255, 0.4);
    }
    
    .empty-icon {
        font-size: 80px;
    }
    
    .message {
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 10px;
        text-align: center;
        display: none;
        font-weight: 600;
    }
    
    .success {
        background: rgba(76, 175, 80, 0.2);
        color: #4caf50;
        border: 2px solid #4caf50;
    }
    
    .error {
        background: rgba(244, 67, 54, 0.2);
        color: #f44336;
        border: 2px solid #f44336;
    }
    
    /* Real Audio Player */
    .dashboard-player {
        position: fixed;
        left: 0;
        right: 0;
        bottom: 0;
        z-index: 30;
        background: rgba(10, 10, 10, 0.98);
        backdrop-filter: blur(10px);
        box-shadow: 0 -8px 30px rgba(0,0,0,0.8);
        padding: 12px 40px 18px 40px;
        color: #fff;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .player-progress-row {
        display: flex;
        align-items: center;
        gap: 12px;
        font-size: 12px;
        color: rgba(255,255,255,0.7);
    }

    .player-progress-bar {
        flex: 1;
    }

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
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .player-now-subtitle {
        font-size: 12px;
        color: rgba(255,255,255,0.6);
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .player-icon-btn {
        border: none;
        background: transparent;
        cursor: pointer;
        font-size: 20px;
        color: rgba(255,255,255,0.8);
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.15s ease;
        border-radius: 50%;
    }

    .player-icon-btn:hover {
        background: rgba(255,255,255,0.1);
        color: #ffffff;
    }

    .player-icon-btn.active {
        color: #8c7bff;
    }

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
        box-shadow: 0 8px 25px rgba(140,123,255,0.7);
        transition: transform 0.15s ease, box-shadow 0.15s ease;
    }

    .player-play-btn:hover {
        transform: scale(1.05);
        box-shadow: 0 10px 30px rgba(140,123,255,0.9);
    }

    .player-volume {
        position: absolute;
        right: 0;
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 12px;
        color: rgba(255,255,255,0.7);
    }

    #playerVolume {
        width: 100px;
        accent-color: #8c7bff;
    }

    .no-audio-badge {
        background: rgba(244, 67, 54, 0.3);
        color: #ff6b6b;
        padding: 2px 8px;
        border-radius: 10px;
        font-size: 10px;
        margin-left: 8px;
    }
</style>

</head>
<body>
    <div class="top-navbar">
        <div class="navbar-left">
            <div class="logo">🎵 Music Library</div>
            <div class="search-container">
                <input type="text" id="searchSongs" class="search-box" placeholder="🔍 Search songs...">
                <input type="text" id="searchPlaylists" class="search-box" placeholder="🔍 Search playlists...">
            </div>
        </div>
        
        <div class="navbar-right">
            <span class="user-info">👤 <span id="userName"></span></span>
            <a href="/playlists/create" class="btn btn-create">➕ Create Playlist</a>
            <a href="/playlists" class="btn">📝 My Playlists</a>
            <button onclick="logout()" class="btn btn-logout">Logout</button>
        </div>
    </div>
    
    <div class="container">
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">🎵</div>
                <div class="stat-info">
                    <h3 id="totalSongs">0</h3>
                    <p>Total Songs</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">📝</div>
                <div class="stat-info">
                    <h3 id="totalPlaylists">0</h3>
                    <p>My Playlists</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">⭐</div>
                <div class="stat-info">
                    <h3 id="premiumSongs">0</h3>
                    <p>Premium Songs</p>
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">🆓</div>
                <div class="stat-info">
                    <h3 id="freeSongs">0</h3>
                    <p>Free Songs</p>
                </div>
            </div>
        </div>
        
        <div class="section-header">
            <h2>🎧 Available Songs</h2>
            <div class="filter-buttons">
                <button class="filter-btn active" onclick="filterSongs('ALL')">All</button>
                <button class="filter-btn" onclick="filterSongs('FREE')">Free</button>
                <button class="filter-btn" onclick="filterSongs('PREMIUM')">Premium</button>
            </div>
        </div>
        
        <div id="message" class="message"></div>
        
        <div id="songsList" class="loading">Loading songs...</div>
    </div>

    <!-- Hidden audio element for real playback -->
    <audio id="audioElement" style="display:none;"></audio>
    
    <!-- Player UI -->
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
    var allSongs = [];
    var allPlaylists = [];
    var currentUser = null;
    var currentFilter = 'ALL';
    var jwtToken = null;

    // REAL AUDIO PLAYER STATE
    var audioElement = null;
    var isPlaying = false;
    var isShuffled = false;
    var isRepeating = false;
    var currentSongIndex = -1;
    var playerSongs = [];

    var ADMIN_BASE_URL = 'http://localhost:8082';
    
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
        
        currentUser = user;
        document.getElementById('userName').textContent = user.firstName + ' ' + user.lastName;
        
        // Initialize audio element
        audioElement = document.getElementById('audioElement');
        setupAudioEvents();
        
        loadDashboardData();
    };

    function setupAudioEvents() {
        // Update time display as song plays
        audioElement.addEventListener('timeupdate', function() {
            if (audioElement.duration) {
                var percent = (audioElement.currentTime / audioElement.duration) * 100;
                document.getElementById('playerSeek').value = percent;
                document.getElementById('currentTime').textContent = formatTime(audioElement.currentTime);
                document.getElementById('totalTime').textContent = formatTime(audioElement.duration);
            }
        });

        // When song ends
        audioElement.addEventListener('ended', function() {
            if (isRepeating) {
                audioElement.currentTime = 0;
                audioElement.play();
            } else {
                nextTrack();
            }
        });

        // When metadata loads (duration available)
        audioElement.addEventListener('loadedmetadata', function() {
            document.getElementById('totalTime').textContent = formatTime(audioElement.duration);
        });

        // Seek bar interaction
        document.getElementById('playerSeek').addEventListener('input', function() {
            if (audioElement.duration) {
                audioElement.currentTime = (this.value / 100) * audioElement.duration;
            }
        });

        // Set initial volume
        audioElement.volume = 0.7;
    }
    
    document.getElementById('searchSongs').addEventListener('input', function(e) {
        var searchTerm = e.target.value.toLowerCase();
        var filtered = allSongs.filter(function(song) {
            return (song.songName && song.songName.toLowerCase().indexOf(searchTerm) !== -1) ||
                   (song.singer && song.singer.toLowerCase().indexOf(searchTerm) !== -1) ||
                   (song.albumName && song.albumName.toLowerCase().indexOf(searchTerm) !== -1);
        });
        displaySongs(filtered);
    });
    
    document.getElementById('searchPlaylists').addEventListener('input', function(e) {
        var searchTerm = e.target.value.toLowerCase();
        if (searchTerm) {
            window.location.href = '/playlists';
        }
    });
    
    async function loadDashboardData() {
        try {
            var songsResponse = await fetch(ADMIN_BASE_URL + '/api/songs/all');
            
            if (songsResponse.ok) {
                allSongs = await songsResponse.json();
                updateStats();
                displaySongs(allSongs);
                
                // Set playable songs (only AVAILABLE with audio)
                playerSongs = allSongs.filter(function(s) {
                    return s.songStatus === 'AVAILABLE';
                });
            } else {
                var errorData = await songsResponse.json();
                throw new Error(errorData.message || 'Failed to load songs');
            }
            
            var playlistsResponse = await fetch('http://localhost:8081/api/playlists/user/' + currentUser.userId, {
                headers: {
                    'Authorization': 'Bearer ' + jwtToken,
                    'Content-Type': 'application/json'
                }
            });
            
            if (playlistsResponse.ok) {
                allPlaylists = await playlistsResponse.json();
                document.getElementById('totalPlaylists').textContent = allPlaylists.length;
            } else if (playlistsResponse.status === 403 || playlistsResponse.status === 401) {
                handleTokenExpired();
            }
            
        } catch (error) {
            console.error('Error loading dashboard:', error);
            showMessage('Error loading data: ' + error.message, 'error');
            document.getElementById('songsList').innerHTML = 
                '<div class="no-songs">' +
                    '<div class="empty-icon">❌</div>' +
                    '<h3>Failed to load songs</h3>' +
                    '<p>' + error.message + '</p>' +
                '</div>';
        }
    }
    
    function updateStats() {
        var freeSongs = allSongs.filter(function(s) { return s.songType === 'FREE'; }).length;
        var premiumSongs = allSongs.filter(function(s) { return s.songType === 'PREMIUM'; }).length;
        
        document.getElementById('totalSongs').textContent = allSongs.length;
        document.getElementById('freeSongs').textContent = freeSongs;
        document.getElementById('premiumSongs').textContent = premiumSongs;
    }
    
    function filterSongs(type) {
        currentFilter = type;
        
        var buttons = document.querySelectorAll('.filter-btn');
        buttons.forEach(function(btn) {
            btn.classList.remove('active');
        });
        event.target.classList.add('active');
        
        var filtered = allSongs;
        if (type !== 'ALL') {
            filtered = allSongs.filter(function(song) {
                return song.songType === type;
            });
        }
        
        displaySongs(filtered);
    }
    
    function displaySongs(songs) {
        var container = document.getElementById('songsList');
        
        if (songs.length === 0) {
            container.innerHTML = 
                '<div class="no-songs">' +
                    '<div class="empty-icon">🎵</div>' +
                    '<h3>No songs found</h3>' +
                    '<p>Try adjusting your filters or search</p>' +
                '</div>';
            return;
        }
        
        container.className = 'songs-grid';
        
        var html = '';
        for (var i = 0; i < songs.length; i++) {
            var song = songs[i];
            var isUnavailable = song.songStatus !== 'AVAILABLE';
            var hasAudio = song.audioFilePath && song.audioFilePath.length > 0;

            var cardClass = isUnavailable ? 'song-card song-card-unavailable' : 'song-card';
            var statusLabel = isUnavailable ? 'UNAVAILABLE' : song.songType;
            var badgeClass = isUnavailable
                ? 'badge badge-unavailable'
                : 'badge ' + (song.songType === 'FREE' ? 'badge-free' : 'badge-premium');

            var durationText = '';
            if (song.duration && song.duration > 0) {
                durationText = '<div class="song-duration">⏱️ ' + formatTime(song.duration) + '</div>';
            }

            var noAudioBadge = '';
            if (!hasAudio && !isUnavailable) {
                noAudioBadge = '<span class="no-audio-badge">No Audio</span>';
            }

            var buttonHtml;
            if (isUnavailable) {
                buttonHtml =
                    '<button class="btn btn-small btn-playlist disabled-btn" disabled>' +
                        '🔒 Unavailable' +
                    '</button>';
            } else {
                var playBtnDisabled = hasAudio ? '' : 'disabled';
                var playBtnClass = hasAudio ? 'btn btn-small btn-play' : 'btn btn-small disabled-btn';
                
                buttonHtml =
                    '<button class="' + playBtnClass + '" onclick="playSongByLibraryId(' + song.libraryId + ')" ' + playBtnDisabled + '>' +
                        '▶️ Play' +
                    '</button>' +
                    '<button class="btn btn-small btn-playlist" ' +
                        'onclick="event.stopPropagation(); showPlaylistOptions(' + song.libraryId + ', \'' + escapeHtml(song.songName) + '\')">' +
                        '➕ Add' +
                    '</button>';
            }

            html += '<div class="' + cardClass + '" id="song-card-' + song.libraryId + '" onclick="playSongByLibraryId(' + song.libraryId + ')">' +
                '<div class="song-header">' +
                    '<div class="song-icon">🎵</div>' +
                    '<span class="' + badgeClass + '">' + statusLabel + '</span>' +
                '</div>' +
                '<div class="song-name">' + escapeHtml(song.songName) + noAudioBadge + '</div>' +
                '<div class="song-meta"><strong>🎤 Artist:</strong> ' + escapeHtml(song.singer || 'Unknown') + '</div>' +
                '<div class="song-meta"><strong>🎹 Music Director:</strong> ' + escapeHtml(song.musicDirector || 'Unknown') + '</div>' +
                '<div class="song-meta"><strong>💿 Album:</strong> ' + escapeHtml(song.albumName || 'Unknown') + '</div>' +
                durationText +
                '<div class="song-actions" onclick="event.stopPropagation()">' + buttonHtml + '</div>' +
            '</div>';
        }
        
        container.innerHTML = html;
        updateNowPlayingHighlight();
    }
    
    function escapeHtml(text) {
        if (!text) return '';
        var div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Play song by library ID
    function playSongByLibraryId(libraryId) {
        var songIndex = -1;
        for (var i = 0; i < playerSongs.length; i++) {
            if (playerSongs[i].libraryId === libraryId) {
                songIndex = i;
                break;
            }
        }
        
        if (songIndex === -1) {
            showMessage('Song not available for playback', 'error');
            return;
        }

        var song = playerSongs[songIndex];
        if (!song.audioFilePath) {
            showMessage('No audio file available for this song', 'error');
            return;
        }

        currentSongIndex = songIndex;
        playCurrentSong();
    }

    function playCurrentSong() {
        if (currentSongIndex < 0 || currentSongIndex >= playerSongs.length) return;
        
        var song = playerSongs[currentSongIndex];
        
        if (!song.audioFilePath) {
            showMessage('No audio file for: ' + song.songName, 'error');
            nextTrack();
            return;
        }

        // Build audio URL
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
            showMessage('Failed to play audio: ' + error.message, 'error');
        });
    }

    function togglePlay() {
        if (!playerSongs.length) {
            showMessage('No songs available to play.', 'error');
            return;
        }

        if (currentSongIndex === -1) {
            // Find first song with audio
            for (var i = 0; i < playerSongs.length; i++) {
                if (playerSongs[i].audioFilePath) {
                    currentSongIndex = i;
                    break;
                }
            }
            if (currentSongIndex === -1) {
                showMessage('No songs have audio files uploaded yet.', 'error');
                return;
            }
            playCurrentSong();
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
        
        // Find previous song with audio
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
            // Find random song with audio
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
            // Find next song with audio
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
        // Remove previous highlight
        var allCards = document.querySelectorAll('.song-card');
        allCards.forEach(function(card) {
            card.classList.remove('now-playing');
        });

        // Add highlight to current song
        if (currentSongIndex >= 0 && currentSongIndex < playerSongs.length) {
            var currentSong = playerSongs[currentSongIndex];
            var currentCard = document.getElementById('song-card-' + currentSong.libraryId);
            if (currentCard) {
                currentCard.classList.add('now-playing');
            }
        }
    }

    function formatTime(seconds) {
        if (isNaN(seconds) || seconds === null) return '00:00';
        var mins = Math.floor(seconds / 60);
        var secs = Math.floor(seconds % 60);
        return (mins < 10 ? '0' : '') + mins + ':' + (secs < 10 ? '0' : '') + secs;
    }
    
    async function showPlaylistOptions(libraryId, songName) {
        if (allPlaylists.length === 0) {
            if (confirm('You don\'t have any playlists yet. Create one now?')) {
                window.location.href = '/playlists/create';
            }
            return;
        }
        
        var message = 'Choose a playlist for "' + songName + '":\n\n';
        for (var i = 0; i < allPlaylists.length; i++) {
            message += (i + 1) + '. ' + allPlaylists[i].playlistName + '\n';
        }
        
        var choice = prompt(message + '\nEnter playlist number:');
        
        if (choice) {
            var index = parseInt(choice) - 1;
            if (index >= 0 && index < allPlaylists.length) {
                await addToPlaylist(allPlaylists[index].playlistId, libraryId, songName);
            } else {
                showMessage('Invalid playlist number', 'error');
            }
        }
    }
    
    async function addToPlaylist(playlistId, libraryId, songName) {
        try {
            var data = {
                playlistId: playlistId,
                libraryId: libraryId,
                songOrder: 0
            };
            
            var response = await fetch('http://localhost:8081/api/playlist-songs/add', {
                method: 'POST',
                headers: { 
                    'Authorization': 'Bearer ' + jwtToken,
                    'Content-Type': 'application/json' 
                },
                body: JSON.stringify(data)
            });
            
            var responseData = await response.json();
            
            if (response.ok) {
                showMessage('"' + songName + '" added to playlist!', 'success');
            } else if (response.status === 403 || response.status === 401) {
                handleTokenExpired();
            } else {
                showMessage('Error: ' + (responseData.message || 'Failed to add song'), 'error');
            }
        } catch (error) {
            console.error('Add to playlist error:', error);
            showMessage('Network error: ' + error.message, 'error');
        }
    }
    
    function handleTokenExpired() {
        showMessage('Your session has expired. Please login again.', 'error');
        setTimeout(function() {
            logout();
        }, 2000);
    }
    
    function logout() {
        localStorage.removeItem('user');
        localStorage.removeItem('jwt_token');
        localStorage.removeItem('user_id');
        localStorage.removeItem('user_email');
        localStorage.removeItem('user_name');
        window.location.href = '/login';
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
