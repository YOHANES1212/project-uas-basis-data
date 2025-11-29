-- 1_create_tables.sql
CREATE DATABASE IF NOT EXISTS foodhall;
USE foodhall;

-- 1. Stall
CREATE TABLE Stall (
    stall_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    owner VARCHAR(200),
    location VARCHAR(200)
);

-- 2. Customer (dibutuhkan Orders)
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200),
    phone VARCHAR(30),
    email VARCHAR(200)
);

-- 3. Category
CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- 4. MenuItem
CREATE TABLE MenuItem (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    stall_id INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(12,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (stall_id) REFERENCES Stall(stall_id)
);

-- 5. MenuItemCategory
CREATE TABLE MenuItemCategory (
    item_id INT,
    category_id INT,
    PRIMARY KEY (item_id, category_id),
    FOREIGN KEY (item_id) REFERENCES MenuItem(item_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE CASCADE
);

-- 6. StallSchedule (ditambahkan supaya constraint bisa diterapkan)
CREATE TABLE StallSchedule (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    stall_id INT NOT NULL,
    day_of_week TINYINT NOT NULL,      -- 0..6 (Sun..Sat)
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    FOREIGN KEY (stall_id) REFERENCES Stall(stall_id) ON DELETE CASCADE
);

-- 7. Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) DEFAULT 'PENDING',
    total_amount DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- 8. OrderItem
CREATE TABLE OrderItem (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY(order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY(item_id) REFERENCES MenuItem(item_id)
);

-- 9. Payment
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    paid_amount DECIMAL(12,2) NOT NULL,
    method VARCHAR(50),
    payment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) DEFAULT 'COMPLETED',
    FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);
