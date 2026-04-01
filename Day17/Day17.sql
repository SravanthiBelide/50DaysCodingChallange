create Database CUSDB;
use CUSDB;
CREATE TABLE customers ( 
    customer_id INT PRIMARY KEY, 
    customer_name VARCHAR(100), 
    city VARCHAR(50) 
); 
INSERT INTO customers VALUES 
(1, 'Amit', 'Bangalore'), 
(2, 'Sneha', 'Mumbai'), 
(3, 'Rahul', 'Delhi'), 
(4, 'Priya', 'Chennai'); 
select*from customers;

CREATE TABLE orders ( 
    order_id INT PRIMARY KEY, 
    customer_id INT, 
    order_date DATE, 
    amount DECIMAL(10,2));
INSERT INTO orders VALUES 
(101, 1, '2024-01-10', 500), 
(102, 1, '2024-02-15', 700), 
(103, 2, '2024-03-01', 300), 
(104, 5, '2024-03-05', 900);

select*from orders;

CREATE TABLE payments ( 
    payment_id INT PRIMARY KEY, 
    order_id INT, 
    payment_status VARCHAR(20));
INSERT INTO payments VALUES 
(1, 101, 'Completed'), 
(2, 102, 'Pending'), 
(3, 103, 'Completed');
select*from payments;

SELECT c.customer_name, o.order_id, o.amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.customer_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT o.order_id, o.customer_id
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT c.customer_name, o.order_id, p.payment_status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN payments p ON o.order_id = p.order_id;

SELECT c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT o.order_id
FROM orders o
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_id IS NULL;

SELECT c.customer_name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed'
AND c.customer_id NOT IN (
    SELECT o2.customer_id 
    FROM orders o2 
    JOIN payments p2 ON o2.order_id = p2.order_id 
    WHERE p2.payment_status != 'Completed'
);


SELECT c.customer_name, MAX(o.amount) AS highest_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

SELECT c.customer_name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 2;