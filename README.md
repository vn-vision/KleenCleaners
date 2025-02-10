# KleenCleaners

KleenCleaners is a Java-based web application designed to streamline laundry service operations. It provides an easy-to-use portal for three types of users:
- **Clients:** Can browse laundry services, place orders for multiple services in one go, submit feedback, view their order history, and download receipts.
- **Laundry Company (Owner):** (To be implemented in the admin portal) Will be able to manage orders, update service details, and view financial reports.
- **Administrators:** (To be implemented in the admin portal) Will have oversight and management privileges over the entire system.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Architecture & Components](#architecture-components)
- [Database Schema](#database-schema)
- [Installation & Setup](#installation-setup)


---

## Project Overview

**KleenCleaners** is a full-stack Java web project that simplifies the process of ordering laundry services. It allows clients to view available laundry services and prices, place orders for multiple services simultaneously, provide feedback on services, view past orders (order history), and download receipts in PDF format. The project is built using servlets, JSP, and a MySQL database, with Bootstrap 5 handling the UI for mobile responsiveness and modern styling.

---

## Features

### User's Portal

1. **Laundry Services & Prices**  
   - Displays a list of available laundry services along with their prices.
   - Uses a searchable, responsive table to improve user experience.

2. **Order Portal**
   - Clients can select multiple laundry services at once.
   - Dynamic quantity fields appear based on selected services.
   - Orders are recorded in two tables: `orders` (general order details) and `order_items` (specific services and quantities).

3. **Order History**
   - Displays all previous orders placed by the client.
   - Uses color-coded statuses (Pending, Completed, Cancelled) for clarity.
   - Allows clients to easily search through their order history.

4. **Feedback Channel**
   - Clients can submit feedback and rate the services from 1 to 5.
   - Displays a history of the client's previous feedback.
   - Uses card-based UI for better presentation.

5. **Receipts Display**
   - Lists receipts for previous orders.
   - Clients can download a PDF receipt for each order.
   - Dates are formatted for readability, and the layout is mobile-friendly.

### Authentication & Session Management

- **Login:**  
  Users log in using their email and password. On successful login, the user is redirected to their dashboard.
  
- **Registration:**  
  New users can create an account using a registration page.  
  The registration form validates inputs (e.g., matching passwords) and stores user data in the database.
  
- **Logout:**  
  A simple logout mechanism invalidates the session and redirects users to the login page.

---

## Architecture & Components

### Frontend (JSP & Bootstrap)
- **JSP Pages:**  
  - `login.jsp`: User authentication page.
  - `register.jsp`: User registration page.
  - `dashboard.jsp`: The main landing page post-login.
  - `order.jsp`: Order placement page (supports multiple service selection).
  - `order-history.jsp`: Displays past orders with detailed information.
  - `receipts.jsp`: Lists receipts with a download option.
  - `feedback.jsp`: Form for submitting feedback and displaying previous feedback.
  
- **CSS & JavaScript:**  
  - Bootstrap 5 is used for responsive design.
  - Custom scripts and inline styles are used to enhance interactivity (e.g., dynamically adding quantity fields in the order form).

### Backend (Servlets & Java)
- **Servlets:**  
  - `LoginServlet`: Handles user authentication.
  - `RegisterServlet`: Processes new user registrations.
  - `OrderServlet`: Processes order submissions, handling multiple services per order.
  - `OrderHistoryServlet`: Retrieves and displays order history.
  - `SubmitFeedbackServlet`: Handles feedback submission.
  - `DownloadReceiptServlet`: Generates and serves PDF receipts (using libraries such as iText for PDF generation).
  - (Admin-related servlets will be implemented for managing orders, services, and user data.)

- **Models:**  
  - `User`: Represents a user in the system.
  - `LaundryService`: Represents a laundry service with a name and price.
  - `Order`: Represents order data (to be extended as needed).

### Database (MySQL)
- **Tables:**  
  - `users`: Stores user account details.
  - `laundry_list`: Stores available laundry services and their prices.
  - `orders`: Records order-level details (user, total price, status, order date).
  - `order_items`: Records individual services within each order.
  - `receipts`: (Optional) Could store additional receipt details if needed.
  - `feedback`: Stores user feedback and ratings.

---

## Database Schema

Example of the core tables:

```sql
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS laundry_list (
    id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES laundry_list(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS feedback (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    message TEXT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```
## installation & setup
Cloning, Setup & Running

Prerequisites

	-- JDK 8+ installed.
	-- Apache Tomcat (or any Servlet container) set up.
	-- MySQL installed and running.
	-- Maven (if using Maven for dependency management) or manually include required libraries (JDBC driver, iText, etc.).

Clone the Repository:

	-- git clone <repository-url>
	-- cd KleenCleaners

Database Setup:

	-- Create a new MySQL database (e.g., kleencleaners).
	-- Run the SQL schema provided above (or use the one in folder /db).
	-- Update the DBConnection.java file with your database connection details (URL, username, password).

Build the Project:
 
  If using Maven, run:

	-- mvn clean install
	-- Alternatively, import the project into your IDE (Eclipse, IntelliJ IDEA) and build it there.

Deploy on Tomcat:

	-- Copy the generated WAR file to the Tomcat webapps directory.
	-- Alternatively, deploy directly from your IDE if integrated with Tomcat.
	-- Start the Tomcat server.

Run the Application:
	
	Open your web browser and navigate to:
		-- http://localhost:<port>/KleenCleaners
		-- Register a new user or log in with an existing account.
		-- Explore the various features (orders, feedback, receipts, etc.).

