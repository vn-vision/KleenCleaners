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
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL DEFAULT 0, -- Total price for all services in the order
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,   -- Links to the main order
    service_id INT NOT NULL, -- Stores individual service for the order
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL, -- Price per service
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES laundry_list(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS receipts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    user_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS feedback (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    message TEXT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);


--mock data for the tables
-- Insert users
INSERT INTO users (fname, lname, email, password) VALUES
('John', 'Doe', 'john.doe@example.com', 'password123'),
('Alice', 'Smith', 'alice.smith@example.com', 'alicepass'),
('Bob', 'Johnson', 'bob.johnson@example.com', 'bobsecure'),
('Eve', 'Brown', 'eve.brown@example.com', 'evepassword');

-- Insert laundry services
INSERT INTO laundry_list (service_name, price) VALUES
('Wash & Fold', 5.00),
('Dry Cleaning', 12.00),
('Ironing', 3.50),
('Express Service', 15.00);

-- Insert orders
INSERT INTO orders (user_id, total_price, status) VALUES
(1, 10.00, 'Pending'),
(2, 17.50, 'Completed'),
(3, 12.00, 'Cancelled'),
(4, 15.00, 'Pending');

-- Insert receipts
INSERT INTO receipts (order_id, user_id, total_price) VALUES
(1, 1, 10.00),
(2, 2, 17.50),
(3, 2, 12.00),
(4, 3, 15.00);

-- Insert feedback
INSERT INTO feedback (user_id, message, rating) VALUES
(1, 'Great service! Clothes were cleaned perfectly.', 4),
(2, 'Ironing could be better, but overall good.', 3),
(3, 'Dry cleaning was fast, but expensive.', 3),
(4, 'Express service was truly express! Happy with it.', 5);
