# ATI-Badulla-Portal

## Project Overview
The ATI Badulla Web Portal is a dynamic web application built using Java Web (Servlets/JSP). It serves as a dual-purpose platform featuring a public-facing website for visitors and a secure administrative backend for content management. The portal is designed to streamline information delivery for students and faculty at ATI Badulla.  

## Technical Stack

    IDE: NetBeans   

    Backend: Java Servlets & JSP   

    Database: MySQL via JDBC   

    Frontend: HTML5, CSS3, JavaScript, and Bootstrap (for responsive components like the carousel)

## Key Features
1. Public Website (Visitor Area)
	- Dynamic Carousel: A homepage slider displaying the 10 most recently uploaded images.
	- News Ticker: A scrolling "Newsline" for urgent notices and updates.
	- Real-time Visitor Counter: Tracks and displays the number of site visits.
 	- Information Hub: Dedicated pages for Courses, Exam Results, and Event Photo Galleries.

2. Admin Panel (Authorized Access)
	- Secure Login: Protected authentication system using `HttpSession`.
	- Content Management (CMS):
		- Notices: CRUD operations for text-based updates.
		- Gallery: Upload event images and manage carousel status flags.
		- Results & Courses: Manage student grade files and course details.

3. Database Schema
The system utilizes a MySQL database named `ati_badulla_db`.
```bash 
Table			Description
Users			Admin credentials with encrypted passwords.
Notices			Title, content, date, and newsline priority.
Gallery			Image file paths and "Carousel Status" flags.
Courses			Details of diploma and certificate programs.
Results			Student index numbers and corresponding marks.
```

4. Installation & Setup
	- Prerequisites
		- Java Development Kit (JDK)
		- Apache Tomcat Server (configured in NetBeans)
		- MySQL Server
		- MySQL Connector/J (JDBC Driver)
	- Setup Steps
		1. Clone the Repository:
			```bash git clone https://github.com/your-username/ati-badulla-portal.git ```
		2. Database Configuration:
			- Import the provided `.sql` script to recreate the `ati_badulla_db`.
			- Update your database credentials in the Java connection utility class.
		3. NetBeans Integration:
			- Open the project folder in NetBeans.
			- Clean and Build the project to resolve dependencies.

		4. Deployment:
			- Run the project on your local Tomcat server. The visitor counter will initialize upon loading `index.jsp`.

5. UI/UX Design
The interface follows a structured modular architecture, emphasizing high-contrast readability and ease of navigation. The frontend utilizes a palette inspired by industrial aesthetics—utilizing teal and orange accents—to ensure the portal feels modern yet functional.
	Note: The administrative backend is strictly session-protected to prevent unauthorized access to student records and content controls.
