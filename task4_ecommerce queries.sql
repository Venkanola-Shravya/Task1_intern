-- 1) Database Creation
CREATE DATABASE ecommerce; -- Creates the main database for the e-commerce system.

USE ecommerce;

-- Customers Table Creation
CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  address TEXT
);

-- Orders Table Creation
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  total_amount DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(id)
);


CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  stock INT NOT NULL
);

CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  item_price DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);


INSERT INTO customers (name, email, address) VALUES
('Alice Sharma', 'alice@example.com', 'New Delhi, India'),
('Bob Singh', 'bob@example.com', 'Mumbai, India'),
('Charlie Khan', 'charlie@example.com', 'Bangalore, India');


INSERT INTO products (name, price, stock) VALUES
('Laptop', 65000.00, 10),
('Smartphone', 30000.00, 20),
('Headphones', 2500.00, 50),
('Smartwatch', 8000.00, 15);


INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-06-01', 95000.00),
(2, '2025-06-02', 32500.00),
(3, '2025-06-03', 8000.00);

INSERT INTO order_items (order_id, product_id, quantity, item_price) VALUES
(1, 1, 1, 65000.00),
(1, 2, 1, 30000.00),
(2, 3, 2, 2500.00),
(3, 4, 1, 8000.00);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

SELECT * FROM customers
WHERE address LIKE '%Mumbai%';

SELECT * FROM orders
ORDER BY total_amount DESC;

SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

SELECT AVG(total_amount) AS average_order_value
FROM orders;

SELECT c.name, o.id AS order_id, o.order_date, o.total_amount
FROM customers c
JOIN orders o ON c.id = o.customer_id;

SELECT c.name, o.id AS order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id;

SELECT * FROM customers
WHERE id IN (
  SELECT customer_id
  FROM orders
  GROUP BY customer_id
  HAVING SUM(total_amount) > (
    SELECT AVG(total_amount) FROM orders
  )
);

CREATE VIEW customer_summary AS
SELECT customer_id, COUNT(*) AS total_orders, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

SELECT * FROM customer_summary;

CREATE INDEX idx_customer_id ON orders(customer_id);

-- Find customers with missing address
SELECT * FROM customers
WHERE address IS NULL;

