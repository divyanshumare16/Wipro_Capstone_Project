<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Users</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0;
            padding: 20px;
            background: #f5f5f5;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 { color: #f44336; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: #f44336;
            color: white;
        }
        tr:hover {
            background: #f5f5f5;
        }
        .back-btn {
            display: inline-block;
            padding: 10px 20px;
            background: #333;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .loading {
            text-align: center;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="http://localhost:8082/admin/dashboard" class="back-btn">Back to Dashboard</a>
        
        <h1>All Registered Users</h1>
        
        <div>Total Users: <span id="totalUsers">0</span></div>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>City</th>
                    <th>Country</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="usersList">
                <tr>
                    <td colspan="8" class="loading">Loading...</td>
                </tr>
            </tbody>
        </table>
    </div>
    
<script>
async function loadUsers() {
    try {
        var response = await fetch('http://localhost:8081/api/users/all');
        if (!response.ok) {
            console.error('Failed to load users', response.status);
            return;
        }

        var users = await response.json();
        console.log('users => ', users);
        
        var tbody = document.getElementById('usersList');
        document.getElementById('totalUsers').textContent = users.length;

        var html = '';
        for (var i = 0; i < users.length; i++) {
            var user = users[i];
            var firstName = user.firstName || '';
            var lastName = user.lastName || '';
            var fullName = firstName + ' ' + lastName;
            
            html += '<tr>';
            html += '<td>' + (user.userId || '') + '</td>';
            html += '<td>' + fullName + '</td>';
            html += '<td>' + (user.userName || '') + '</td>';
            html += '<td>' + (user.email || '') + '</td>';
            html += '<td>' + (user.mobile || '') + '</td>';
            html += '<td>' + (user.city || '') + '</td>';
            html += '<td>' + (user.country || '') + '</td>';
            html += '<td>' + (user.status || '') + '</td>';
            html += '</tr>';
        }
        tbody.innerHTML = html;

    } catch (err) {
        console.error('Error loading users', err);
    }
}

loadUsers();
</script>

</body>
</html>
