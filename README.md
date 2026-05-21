# ATI-Badulla-Portal
![Language](https://img.shields.io/badge/Language-Java-blue)
![Frontend](https://img.shields.io/badge/Frontend-HTML%2FCSS%2FJS-orange)
![Backend](https://img.shields.io/badge/Backend-Servlets%20%2F%20JSP-red)
![Database](https://img.shields.io/badge/Database-MySQL-blue)
![Academic Project](https://img.shields.io/badge/Project-ATI%20Badulla%20Portal-informational)
---

## Project Overview

The ATI Badulla Web Portal is a dynamic web application built using Java Web (Servlets/JSP). It serves as a dual-purpose platform featuring a public-facing website for visitors and a secure administrative backend for content management. The portal is designed to streamline information delivery for students and faculty at ATI Badulla.

---

## Technical Stack

| Layer | Technology |
|---|---|
| IDE | NetBeans |
| Backend | Java Servlets & JSP |
| Database | MySQL via JDBC |
| Frontend | HTML5, CSS3, JavaScript, Bootstrap 5 |

---

## Key Features

### 1. Public Website (Visitor Area)
- **Dynamic Carousel** — Homepage slider displaying the 10 most recently uploaded images
- **News Ticker** — Scrolling newsline for urgent notices and updates
- **Visitor Counter** — Real-time counter tracking the number of site visits
- **Information Hub** — Dedicated pages for Courses, Exam Results, and Event Galleries

### 2. Admin Panel (Authorized Access)
- **Secure Login** — Protected authentication system using `HttpSession`
- **Content Management (CMS)**
  - Notices — CRUD operations for text-based updates
  - Gallery — Upload event images and manage carousel status flags
  - Results & Courses — Manage student grade files and course details

### 3. Database Schema

| Table | Description |
|---|---|
| `users` | Admin credentials with SHA-256 encrypted passwords |
| `notices` | Title, content, date, and newsline priority |
| `gallery` | Image file paths and carousel status flags |
| `courses` | Details of diploma and certificate programs |
| `results` | Student index numbers and corresponding marks |
| `visitor_counter` | Tracks total site visit count |

---

## Installation & Setup

### Prerequisites

Make sure the following are installed before you begin:

- Java Development Kit (JDK 11 or higher)
- Apache Tomcat 10.x (configured inside NetBeans)
- MySQL Server 8.x
- NetBeans IDE
- Git

---

### Step 1 — Clone the Repository

Open a terminal (Linux/Mac) or Git Bash (Windows) and run:

```bash
git clone https://github.com/your-username/ATI-Badulla-Portal.git
cd ATI-Badulla-Portal
```

---

### Step 2 — Set Up the Database

This is the most important step. Follow it carefully.

#### 2a — Log in to MySQL

**Linux / Mac:**
```bash
mysql -u root -p
```

**Windows (Command Prompt):**
```cmd
mysql -u root -p
```

Enter your MySQL root password when prompted. You will see the `mysql>` prompt.

#### 2b — Create the database

```sql
CREATE DATABASE ati_badulla_db;
EXIT;
```

#### 2c — Import the SQL file

The `ati_badulla_db.sql` file is included in the root of this repository. It will create all the tables and insert the default admin user automatically.

**Linux / Mac:**
```bash
mysql -u root -p ati_badulla_db < ati_badulla_db.sql
```

**Windows (Command Prompt):**
```cmd
mysql -u root -p ati_badulla_db < C:\path\to\ATI-Badulla-Portal\ati_badulla_db.sql
```

> Replace `C:\path\to\` with the actual folder path where you cloned the repo.

#### 2d — Verify the import worked

Log back into MySQL and check:

```bash
mysql -u root -p
```

```sql
USE ati_badulla_db;
SHOW TABLES;
SELECT username FROM users;
```

You should see 6 tables listed and one user called `admin`. If you see that, the database is ready.

#### 2e — Default admin credentials

| Field | Value |
|---|---|
| Username | `admin` |
| Password | `admin123` |

> Change these after your first login for security.

---

### Step 3 — Configure the Database Connection

Open this file in NetBeans:

```
src/java/db/DBConnection.java
```

Update line 6 with your MySQL password:

```java
private static final String PASSWORD = "your_mysql_password_here";
```

If your MySQL has no password (common on fresh installs), use:

```java
private static final String PASSWORD = "";
```

---

### Step 4 — Add Required JAR Libraries

Right-click the project in NetBeans → **Properties** → **Libraries** → **Compile** → **Add JAR/Folder**

Add these three JAR files:

| JAR file | Purpose |
|---|---|
| `mysql-connector-j-9.x.x.jar` | MySQL JDBC driver |
| `jakarta.servlet.jsp.jstl-api-3.0.0.jar` | JSTL tag library API |
| `jakarta.servlet.jsp.jstl-3.0.1.jar` | JSTL implementation |

> Download links for JSTL jars:
> - https://repo1.maven.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/3.0.0/jakarta.servlet.jsp.jstl-api-3.0.0.jar
> - https://repo1.maven.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/3.0.1/jakarta.servlet.jsp.jstl-3.0.1.jar

---

### Step 5 — Configure Tomcat in NetBeans

1. Go to **Tools → Servers** in NetBeans
2. If Apache Tomcat is not listed, click **Add Server**
3. Select **Apache Tomcat** and browse to your Tomcat installation folder
4. Click **Finish**

---

### Step 6 — Build and Run

In NetBeans:

1. **Clean and Build** — press `Shift + F11`
2. **Run** — press `F6`

The browser will open automatically. If it does not, open manually:

| Page | URL |
|---|---|
| Homepage | `http://localhost:8080/WebApplication1/home` |
| Admin Login | `http://localhost:8080/WebApplication1/admin/login.jsp` |

---

## Troubleshooting

| Error | Fix |
|---|---|
| `Table doesn't exist` | You skipped Step 2 — import the SQL file first |
| `MySQL driver not found` | Add `mysql-connector-j.jar` to project libraries (Step 4) |
| `Cannot resolve JSTL uri` | Add both JSTL jars to project libraries (Step 4) |
| `HTTP 404 on /home` | Make sure `HomeServlet.java` is compiled — Clean and Build |
| `Access denied for user root` | Wrong password in `DBConnection.java` — fix Step 3 |

---

## UI/UX Design

The interface follows a structured modular architecture emphasizing high-contrast readability and ease of navigation. The frontend uses a palette inspired by industrial aesthetics — teal and orange accents — to ensure the portal feels modern yet functional.

> The administrative backend is strictly session-protected to prevent unauthorized access to student records and content controls.

---

## Project Structure

```
ATI-Badulla-Portal/
├── ati_badulla_db.sql          ← Import this first
├── README.md
└── WebApplication1/            ← Open this folder in NetBeans
    ├── src/java/
    │   ├── db/DBConnection.java
    │   ├── listeners/VisitorCounterListener.java
    │   ├── models/
    │   └── servlets/
    └── web/
        ├── index.jsp
        ├── admin/
        └── WEB-INF/web.xml
```
