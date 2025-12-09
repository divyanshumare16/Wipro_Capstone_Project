<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Song</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

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

        .navbar {
            background: rgba(20, 20, 20, 0.95);
            color: white;
            padding: 15px 40px;
            box-shadow: 0 2px 20px rgba(0,0,0,0.5);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        .navbar h2 {
            font-size: 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 25px 30px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.35);
        }

        h2 { 
            color: #f44336; 
            margin-bottom: 20px; 
            text-align: center; 
        }

        .form-group { margin-bottom: 15px; }

        label { 
            display: block; 
            margin-bottom: 5px; 
            font-weight: 600; 
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        input[type="file"] {
            padding: 8px;
            background: #f8f9fa;
            cursor: pointer;
        }

        .file-info {
            margin-top: 8px;
            padding: 10px;
            background: #e8f5e9;
            border-radius: 5px;
            font-size: 13px;
            color: #2e7d32;
            display: none;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: #f44336;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn:hover { background: #e91e63; }
        .btn:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        .message { 
            padding: 10px; 
            margin-bottom: 15px; 
            border-radius: 5px; 
            text-align: center;
            display: none;
            font-weight: 600;
        }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }

        .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background: #333;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .back-btn:hover {
            background: #000;
        }

        .upload-progress {
            width: 100%;
            height: 6px;
            background: #ddd;
            border-radius: 3px;
            margin-top: 10px;
            display: none;
            overflow: hidden;
        }
        .upload-progress-bar {
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            width: 0%;
            transition: width 0.3s ease;
        }

        .audio-preview {
            margin-top: 10px;
            display: none;
        }
        .audio-preview audio {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>🎵 Music Library - Add Song</h2>
        <a href="/admin/dashboard" class="back-btn">← Back to Dashboard</a>
    </div>
    
    <div class="container">
        <h2>📝 Add New Song with Audio</h2>
        <div id="message" class="message"></div>
        
        <form id="addSongForm">
            <div class="form-group">
                <label>Song ID *</label>
                <input type="text" name="songId" id="songId" required placeholder="e.g., SONG001">
            </div>
            
            <div class="form-group">
                <label>Song Name *</label>
                <input type="text" name="songName" id="songName" required>
            </div>
            
            <div class="form-group">
                <label>Music Director</label>
                <input type="text" name="musicDirector" id="musicDirector">
            </div>
            
            <div class="form-group">
                <label>Singer *</label>
                <input type="text" name="singer" id="singer" required>
            </div>
            
            <div class="form-group">
                <label>Release Date</label>
                <input type="date" name="releaseDate" id="releaseDate">
            </div>
            
            <div class="form-group">
                <label>Album Name</label>
                <input type="text" name="albumName" id="albumName">
            </div>
            
            <div class="form-group">
                <label>Song Type *</label>
                <select name="songType" id="songType" required>
                    <option value="FREE">FREE</option>
                    <option value="PREMIUM">PREMIUM</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Song Status *</label>
                <select name="songStatus" id="songStatus" required>
                    <option value="AVAILABLE">AVAILABLE</option>
                    <option value="UNAVAILABLE">UNAVAILABLE</option>
                </select>
            </div>

            <div class="form-group">
                <label>🎵 Audio File (MP3) *</label>
                <input type="file" id="audioFile" accept="audio/mp3,audio/mpeg,audio/*" required>
                <div class="upload-progress" id="uploadProgress">
                    <div class="upload-progress-bar" id="uploadProgressBar"></div>
                </div>
                <div class="file-info" id="fileInfo"></div>
                <div class="audio-preview" id="audioPreview">
                    <label>Preview:</label>
                    <audio id="audioPlayer" controls></audio>
                </div>
            </div>
            
            <button type="submit" class="btn" id="submitBtn">🎵 Upload & Add Song</button>
        </form>
    </div>
    
    <script>
        var audioFilePath = '';
        var audioDuration = 0;

        // Preview audio when file is selected
        document.getElementById('audioFile').addEventListener('change', function(e) {
            var file = e.target.files[0];
            if (file) {
                var fileInfo = document.getElementById('fileInfo');
                var audioPreview = document.getElementById('audioPreview');
                var audioPlayer = document.getElementById('audioPlayer');

                // Show file info
                var sizeMB = (file.size / (1024 * 1024)).toFixed(2);
                fileInfo.innerHTML = '📁 File: ' + file.name + ' (' + sizeMB + ' MB)';
                fileInfo.style.display = 'block';

                // Create preview
                var url = URL.createObjectURL(file);
                audioPlayer.src = url;
                audioPreview.style.display = 'block';

                // Get duration when metadata loads
                audioPlayer.onloadedmetadata = function() {
                    audioDuration = Math.floor(audioPlayer.duration);
                    fileInfo.innerHTML += '<br>⏱️ Duration: ' + formatTime(audioDuration);
                };
            }
        });

        function formatTime(seconds) {
            var mins = Math.floor(seconds / 60);
            var secs = seconds % 60;
            return (mins < 10 ? '0' : '') + mins + ':' + (secs < 10 ? '0' : '') + secs;
        }

        document.getElementById('addSongForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            var submitBtn = document.getElementById('submitBtn');
            var messageDiv = document.getElementById('message');
            var fileInput = document.getElementById('audioFile');

            if (!fileInput.files[0]) {
                messageDiv.className = 'message error';
                messageDiv.textContent = 'Please select an audio file';
                messageDiv.style.display = 'block';
                return;
            }

            submitBtn.disabled = true;
            submitBtn.textContent = '⏳ Uploading...';

            try {
                // Show progress bar
                var progressDiv = document.getElementById('uploadProgress');
                var progressBar = document.getElementById('uploadProgressBar');
                progressDiv.style.display = 'block';

                // Step 1: Upload the audio file
                var formData = new FormData();
                formData.append('file', fileInput.files[0]);

                var uploadResponse = await fetch('http://localhost:8082/api/files/upload', {
                    method: 'POST',
                    body: formData
                });

                progressBar.style.width = '50%';

                var uploadResult = await uploadResponse.json();

                if (!uploadResult.success) {
                    throw new Error(uploadResult.error || 'Failed to upload audio file');
                }

                audioFilePath = uploadResult.filePath;
                progressBar.style.width = '75%';

                // Step 2: Save song with audio path
                var songData = {
                    songId: document.getElementById('songId').value,
                    songName: document.getElementById('songName').value,
                    musicDirector: document.getElementById('musicDirector').value,
                    singer: document.getElementById('singer').value,
                    releaseDate: document.getElementById('releaseDate').value || null,
                    albumName: document.getElementById('albumName').value,
                    songType: document.getElementById('songType').value,
                    songStatus: document.getElementById('songStatus').value,
                    audioFilePath: audioFilePath,
                    duration: audioDuration
                };

                var response = await fetch('http://localhost:8082/api/songs/add', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(songData)
                });

                progressBar.style.width = '100%';

                if (response.ok) {
                    messageDiv.className = 'message success';
                    messageDiv.textContent = '✅ Song added successfully with audio!';
                    messageDiv.style.display = 'block';
                    
                    // Reset form
                    document.getElementById('addSongForm').reset();
                    document.getElementById('fileInfo').style.display = 'none';
                    document.getElementById('audioPreview').style.display = 'none';
                    audioFilePath = '';
                    audioDuration = 0;
                    
                    setTimeout(function() {
                        progressDiv.style.display = 'none';
                        progressBar.style.width = '0%';
                        messageDiv.style.display = 'none';
                    }, 3000);
                } else {
                    var error = await response.text();
                    throw new Error(error);
                }
            } catch (error) {
                messageDiv.className = 'message error';
                messageDiv.textContent = '❌ Error: ' + error.message;
                messageDiv.style.display = 'block';
                document.getElementById('uploadProgress').style.display = 'none';
            } finally {
                submitBtn.disabled = false;
                submitBtn.textContent = '🎵 Upload & Add Song';
            }
        });
    </script>
</body>
</html>
