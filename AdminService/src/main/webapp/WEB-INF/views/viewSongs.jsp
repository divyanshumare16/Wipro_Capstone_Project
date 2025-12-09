<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Music Library - All Songs</title>
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
        
        /* Dark overlay */
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
        
        /* Header */
        .header {
            background: rgba(20, 20, 20, 0.95);
            backdrop-filter: blur(10px);
            padding: 15px 40px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.5);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .header-title {
            font-size: 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 700;
        }
        
        .btn-back {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(102, 126, 234, 0.6);
        }
        
        /* Container */
        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 20px;
        }
        
        /* Stats Section */
        .stats-section {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            flex: 1;
            background: rgba(30, 30, 30, 0.9);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
        }
        
        .stat-number {
            font-size: 36px;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .stat-label {
            color: rgba(255, 255, 255, 0.7);
            font-size: 14px;
            margin-top: 5px;
        }
        
        /* Filter Section */
        .filter-section {
            background: rgba(30, 30, 30, 0.9);
            backdrop-filter: blur(10px);
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .filter-btn {
            padding: 10px 20px;
            background: rgba(50, 50, 50, 0.8);
            color: rgba(255, 255, 255, 0.7);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .filter-btn:hover, .filter-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-color: transparent;
        }
        
        .search-box {
            flex: 1;
            min-width: 200px;
            padding: 10px 20px;
            background: rgba(40, 40, 40, 0.8);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 25px;
            color: white;
            font-size: 14px;
        }
        
        .search-box::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }
        
        .search-box:focus {
            outline: none;
            border-color: #667eea;
        }
        
        /* Songs Grid */
        .songs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }
        
        .song-card {
            background: rgba(30, 30, 30, 0.9);
            backdrop-filter: blur(10px);
            padding: 25px;
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }
        
        .song-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            border-color: rgba(102, 126, 234, 0.5);
        }
        
        .song-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 15px;
        }
        
        .song-title {
            font-size: 20px;
            font-weight: 700;
            color: white;
            margin-bottom: 10px;
        }
        
        .song-badge {
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
        
        .song-info {
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
            margin-bottom: 5px;
        }
        
        .song-info strong {
            color: rgba(255, 255, 255, 0.9);
        }
        
        .song-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        
        .btn-edit {
            flex: 1;
            padding: 10px;
            background: linear-gradient(135deg, #2196f3 0%, #1976d2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-edit:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(33, 150, 243, 0.6);
        }
        
        .btn-delete {
            flex: 1;
            padding: 10px;
            background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-delete:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.6);
        }
        
        .loading {
            text-align: center;
            padding: 60px;
            color: white;
            font-size: 20px;
        }
        
        .no-songs {
            text-align: center;
            padding: 60px;
            background: rgba(30, 30, 30, 0.9);
            border-radius: 15px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .no-songs h3 {
            color: rgba(255, 255, 255, 0.5);
            font-size: 24px;
        }
        
        /* Modal for Edit */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        
        .modal-content {
            background: rgba(30, 30, 30, 0.95);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            width: 90%;
            max-width: 600px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            max-height: 90vh;
            overflow-y: auto;
        }
        
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .modal-header h2 {
            color: white;
            font-size: 24px;
        }
        
        .close-modal {
            background: none;
            border: none;
            color: white;
            font-size: 30px;
            cursor: pointer;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 5px;
            font-weight: 600;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 10px 15px;
            background: rgba(50, 50, 50, 0.8);
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: white;
            font-size: 14px;
        }
        
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn-save {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #4caf50 0%, #45a049 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(76, 175, 80, 0.6);
        }
        
        .message {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
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
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <h1 class="header-title">🎵 Music Library - All Songs</h1>
        <a href="/admin/dashboard" class="btn-back">← Back to Dashboard</a>
    </div>
    
    <!-- Container -->
    <div class="container">
        <!-- Message -->
        <div id="message" class="message"></div>
        
        <!-- Stats Section -->
        <div class="stats-section">
            <div class="stat-card">
                <div class="stat-number" id="totalSongs">0</div>
                <div class="stat-label">Total Songs</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="freeSongs">0</div>
                <div class="stat-label">Free Songs</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="premiumSongs">0</div>
                <div class="stat-label">Premium Songs</div>
            </div>
        </div>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <button class="filter-btn active" id="btnAll">All Songs</button>
            <button class="filter-btn" id="btnAvailable">✓ Available</button>
            <button class="filter-btn" id="btnFree">🆓 Free Only</button>
            <button class="filter-btn" id="btnPremium">⭐ Premium</button>
            <input type="text" id="searchBox" class="search-box" placeholder="🔍 Search by song name, artist, album, or music director...">
        </div>
        
        <!-- Songs Grid -->
        <div id="songsList" class="loading">Loading songs...</div>
    </div>
    
    <!-- Edit Modal -->
    <div id="editModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Song</h2>
                <button class="close-modal" onclick="closeModal()">&times;</button>
            </div>
            <form id="editForm">
                <input type="hidden" id="editSongId">
                
                <div class="form-group">
                    <label>Song Name *</label>
                    <input type="text" id="editSongName" required>
                </div>
                
                <div class="form-group">
                    <label>Artist/Singer *</label>
                    <input type="text" id="editSinger" required>
                </div>
                
                <div class="form-group">
                    <label>Music Director *</label>
                    <input type="text" id="editMusicDirector" required>
                </div>
                
                <div class="form-group">
                    <label>Album Name</label>
                    <input type="text" id="editAlbumName">
                </div>
                
                <div class="form-group">
                    <label>Release Date</label>
                    <input type="date" id="editReleaseDate">
                </div>
                
                <div class="form-group">
                    <label>Song Type *</label>
                    <select id="editSongType" required>
                        <option value="FREE">Free</option>
                        <option value="PREMIUM">Premium</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Song Status *</label>
                    <select id="editSongStatus" required>
                        <option value="AVAILABLE">AVAILABLE</option>
                        <option value="NOTAVAILABLE">NOT AVAILABLE</option>
                    </select>
                </div>
                
                <button type="submit" class="btn-save">💾 Save Changes</button>
            </form>
        </div>
    </div>
    
<script>
    let allSongs = [];
    let currentFilter = 'ALL';
    
    window.onload = function() {
        loadSongs();
        
        document.getElementById('btnAll').addEventListener('click', () => filterSongs('ALL'));
        document.getElementById('btnAvailable').addEventListener('click', () => filterSongs('AVAILABLE'));
        document.getElementById('btnFree').addEventListener('click', () => filterSongs('FREE'));
        document.getElementById('btnPremium').addEventListener('click', () => filterSongs('PREMIUM'));
        
        document.getElementById('searchBox').addEventListener('input', handleSearch);
        document.getElementById('editForm').addEventListener('submit', handleUpdate);
    };
    
    async function loadSongs() {
        const response = await fetch('http://localhost:8082/api/songs/all');
        
        if (!response.ok) {
            const error = await response.text();  // ✅ GlobalExceptionHandler plain text
            showMessage(error || 'Failed to load songs', 'error');
            document.getElementById('songsList').innerHTML = 
                '<div class="no-songs"><h3>Error loading songs</h3></div>';
            return;
        }
        
        allSongs = await response.json();
        updateStats();
        displaySongs(allSongs);
    }

    
    function updateStats() {
        const freeSongs = allSongs.filter(s => s.songType === 'FREE').length;
        const premiumSongs = allSongs.filter(s => s.songType === 'PREMIUM').length;
        
        document.getElementById('totalSongs').textContent = allSongs.length;
        document.getElementById('freeSongs').textContent = freeSongs;
        document.getElementById('premiumSongs').textContent = premiumSongs;
    }
    
    function filterSongs(type) {
        currentFilter = type;
        
        document.querySelectorAll('.filter-btn').forEach(btn => btn.classList.remove('active'));
        
        if (type === 'ALL') {
            document.getElementById('btnAll').classList.add('active');
        } else if (type === 'AVAILABLE') {
            document.getElementById('btnAvailable').classList.add('active');
        } else if (type === 'FREE') {
            document.getElementById('btnFree').classList.add('active');
        } else if (type === 'PREMIUM') {
            document.getElementById('btnPremium').classList.add('active');
        }
        
        let filtered = allSongs;
        
        if (type === 'FREE') {
            filtered = allSongs.filter(s => s.songType === 'FREE');
        } else if (type === 'PREMIUM') {
            filtered = allSongs.filter(s => s.songType === 'PREMIUM');
        } else if (type === 'AVAILABLE') {
            filtered = allSongs.filter(s => s.songStatus === 'AVAILABLE');
        }
        
        displaySongs(filtered);
    }
    
    function handleSearch(e) {
        const searchTerm = e.target.value.toLowerCase();
        const filtered = allSongs.filter(song => 
            (song.songName && song.songName.toLowerCase().includes(searchTerm)) ||
            (song.singer && song.singer.toLowerCase().includes(searchTerm)) ||
            (song.albumName && song.albumName.toLowerCase().includes(searchTerm)) ||
            (song.musicDirector && song.musicDirector.toLowerCase().includes(searchTerm))
        );
        displaySongs(filtered);
    }
    
    function displaySongs(songs) {
        const container = document.getElementById('songsList');
        
        if (songs.length === 0) {
            container.innerHTML = '<div class="no-songs"><h3>No songs found</h3></div>';
            return;
        }
        
        container.className = 'songs-grid';
        
        let html = '';
        songs.forEach(song => {
            const songData = encodeURIComponent(JSON.stringify(song));
            
            html += '<div class="song-card">';
            html += '  <div class="song-header">';
            html += '    <div class="song-title">' + escapeHtml(song.songName) + '</div>';
            html += '    <span class="song-badge badge-' + song.songType.toLowerCase() + '">' + song.songType + '</span>';
            html += '  </div>';
            html += '  <div class="song-info"><strong>🎤 Artist:</strong> ' + escapeHtml(song.singer || 'Unknown') + '</div>';
            html += '  <div class="song-info"><strong>🎹 Music Director:</strong> ' + escapeHtml(song.musicDirector || 'Unknown') + '</div>';
            html += '  <div class="song-info"><strong>💿 Album:</strong> ' + escapeHtml(song.albumName || 'Unknown') + '</div>';
            html += '  <div class="song-info"><strong>📅 Release:</strong> ' + (song.releaseDate || 'N/A') + '</div>';
            html += '  <div class="song-info"><strong>📊 Status:</strong> ' + song.songStatus + '</div>';
            html += '  <div class="song-actions">';
            html += '    <button class="btn-edit" onclick="openEditModalEncoded(\'' + songData + '\')">✏️ Edit</button>';
            html += '    <button class="btn-delete" onclick="deleteSong(' + song.libraryId + ', \'' + escapeHtml(song.songName).replace(/'/g, "\\'") + '\')">🗑️ Delete</button>';
            html += '  </div>';
            html += '</div>';
        });
        
        container.innerHTML = html;
    }
    
    function openEditModalEncoded(encodedData) {
        const song = JSON.parse(decodeURIComponent(encodedData));
        openEditModal(song);
    }
    
    function openEditModal(song) {
        document.getElementById('editSongId').value = song.libraryId;
        document.getElementById('editSongName').value = song.songName;
        document.getElementById('editSinger').value = song.singer;
        document.getElementById('editMusicDirector').value = song.musicDirector;
        document.getElementById('editAlbumName').value = song.albumName || '';
        document.getElementById('editReleaseDate').value = song.releaseDate || '';
        document.getElementById('editSongType').value = song.songType;
        document.getElementById('editSongStatus').value = song.songStatus;
        
        document.getElementById('editModal').style.display = 'flex';
    }
    
    function closeModal() {
        document.getElementById('editModal').style.display = 'none';
    }
    
    async function handleUpdate(e) {
        e.preventDefault();
        
        const songId = document.getElementById('editSongId').value;
        const updatedSong = {
            songName: document.getElementById('editSongName').value,
            singer: document.getElementById('editSinger').value,
            musicDirector: document.getElementById('editMusicDirector').value,
            albumName: document.getElementById('editAlbumName').value,
            releaseDate: document.getElementById('editReleaseDate').value,
            songType: document.getElementById('editSongType').value,
            songStatus: document.getElementById('editSongStatus').value
        };
        
        const response = await fetch('http://localhost:8082/api/songs/' + songId, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(updatedSong)
        });
        
        if (response.ok) {
            showMessage('Song updated successfully!', 'success');
            closeModal();
            loadSongs();
        } else {
            const error = await response.text();  // ✅ "Song not found" from GlobalExceptionHandler
            showMessage(error || 'Failed to update song', 'error');
        }
    }
    async function deleteSong(id, name) {
        if (!confirm('Are you sure you want to delete "' + name + '"?')) return;
        
        const response = await fetch('http://localhost:8082/api/songs/' + id, {
            method: 'DELETE'
        });
        
        if (response.ok) {
            showMessage('Song deleted successfully!', 'success');
            loadSongs();
        } else {
            const error = await response.text();  // ✅ "Song not found" from backend
            showMessage(error || 'Failed to delete song', 'error');
        }
    }
    function showMessage(text, type) {
        const msg = document.getElementById('message');
        msg.textContent = text;
        msg.className = 'message ' + type;
        msg.style.display = 'block';
        
        setTimeout(function() {
            msg.style.display = 'none';
        }, 4000);  
    }
    function escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
</script>

</body>
</html>
