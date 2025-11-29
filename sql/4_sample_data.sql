-- 4_sample_data.sql
USE foodhall;

INSERT INTO Stall(name, owner, location) VALUES
('Ayam Bakar Madu', 'Pak A', 'Food Hall A'),
('Bakso Pak Joko', 'Pak Joko', 'Food Hall A'),
('Sushi Bento', 'Ibu S', 'Food Hall B');

INSERT INTO MenuItem(stall_id, name, price) VALUES
(1, 'Ayam Bakar', 25000.00),
(1, 'Nasi Uduk', 8000.00),
(2, 'Bakso Urat', 15000.00),
(3, 'Salmon Roll', 30000.00);

INSERT INTO Customer(name, email) VALUES
('Budi Santoso', 'budi@mail.com'),
('Ani Lestari', 'ani@mail.com');

INSERT INTO Orders(customer_id) VALUES (1), (2);

INSERT INTO OrderItem(order_id, item_id, quantity, unit_price, subtotal)
SELECT 1, item_id, 2, price, price * 2 FROM MenuItem WHERE item_id = 1;

-- contoh finalize
CALL finalize_order(1, 50000.00, 'CASH');
