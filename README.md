# 🎵 Music Library Microservices — System Documentation

The **Music Library System** is developed as a **scalable Microservices Architecture** using **Spring Boot**.  
Each service operates independently with its own database, security configuration, and REST APIs.

---

## 🚀 Project Overview

This system consists of the following microservices:

- **Admin Service** – Admin authentication & Song management
- **User Service** – User authentication & Playlist management
- **Song Service** – Central library of all songs
- **Notification Service** – Sends email notifications for new songs
- **Eureka Service** – Service registry & discovery

### Architecture Highlights
- Independent deployment
- REST-based communication
- Dedicated database per microservice
- Secured using JWT + Spring Security

---

## 🧑‍💻 User Module — Features

### 🔐 Authentication
- User Registration
- Login with email + password
- JWT-based secure access

### 🎶 Song Browsing
- View all available songs
- Search songs by:
  - Artist
  - Album
  - Music Director
- View detailed song information:
  - Song name, Singer, Release date, Album, Music director

### 📂 Playlist Management (CRUD)
- Create multiple playlists
- Add or remove songs
- Update playlist name
- Delete playlists
- View user playlists

### 🔄 Playlist Controls
- Play
- Stop
- Shuffle
- Repeat

---

## 🛠 Admin Module — Features

### 🔐 Authentication
- Secure Admin Login using JWT

### 🎵 Song Library Management (CRUD)
- Add new songs
- Update existing songs
- Delete songs
- Hide / Unhide songs for users

### ✉ Notifications
- Automatic email alerts for new song additions (via Notification Service)

---

## 🧩 Microservices Overview

| Service | Responsibility |
|--------|----------------|
| Admin Service | Admin auth & Song CRUD |
| User Service | User auth & Playlist CRUD |
| Song Service | Master song library |
| Notification Service | Email alerts |
| Eureka Service | Service registry |

---

## 🔐 Security (JWT)

### Login Flow
1. Credentials submitted
2. Authentication verified
3. JWT token generated & returned

### Secured API Flow
- Token sent in header → `Authorization: Bearer <token>`
- JWT filter validates token
- Valid → Request processed
- Invalid → 401 Unauthorized

### Security Components
- JwtRequestFilter
- JwtUtil
- SecurityConfig

---

## 🧪 Technologies Used

| Layer | Technologies |
|------|-------------|
| Backend | Spring Boot, Microservices, JPA, Hibernate, Eureka |
| Database | MySQL (per service) |
| Security | Spring Security, JWT |
| Communication | REST APIs |
| Notifications | JavaMailSender |
| Frontend | JSP, HTML, CSS, JavaScript |
| Build Tool | Maven |

---

## 📦 Key System Features
- Distributed Microservices Architecture
- Full Admin & User module coverage
- JWT Authentication & Authorization
- Central Music Library + Search Filters
- Playlist feature with play controls
- Notification microservice integration
- Scalable and maintainable design

---

## ✍ Author

**Divyansh Prashant Umare**  
📧 Email: *divyanshumare16@gmail.com*
