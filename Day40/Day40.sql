CREATE DATABASE packaging_domain;
USE packaging_domain;
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(20), -- Can be 'Box', 'Bottle', or 'Wrapper'
    cost_per_unit DECIMAL(10,2)
);
CREATE TABLE production (
    production_id INT PRIMARY KEY,
    product_id INT,
    production_date DATE,
    quantity_produced INT,
    defective_quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id) -- Ensures product exists
);
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity_sold INT,
    selling_price_per_unit DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id) -- Ensures product exists
);
-- Insert into products first
INSERT INTO products VALUES
(1, 'Small Box', 'Box', 10.00),
(2, 'Medium Box', 'Box', 15.00),
(3, 'Large Box', 'Box', 20.00),
(4, 'Plastic Bottle', 'Bottle', 8.00),
(5, 'Glass Bottle', 'Bottle', 12.00),
(6, 'Food Wrapper', 'Wrapper', 2.00),
(7, 'Gift Wrapper', 'Wrapper', 3.00);
select*from products;
-- Insert into production
INSERT INTO production VALUES
(1, 1, '2026-01-01', 1000, 50),
(2, 2, '2026-01-01', 800, 20),
(3, 3, '2026-01-02', 600, 30),
(4, 4, '2026-01-02', 1200, 60),
(5, 5, '2026-01-03', 700, 10),
(6, 6, '2026-01-03', 2000, 100),
(7, 7, '2026-01-04', 1500, 75),
(8, 1, '2026-02-01', 1100, 40),
(9, 2, '2026-02-02', 900, 25),
(10, 3, '2026-02-03', 650, 35),
(11, 4, '2026-02-03', 1300, 70),
(12, 5, '2026-02-04', 750, 20),
(13, 6, '2026-02-05', 2100, 120),
(14, 7, '2026-02-06', 1600, 80);
select*from  production;
-- Insert into sales
INSERT INTO sales VALUES
(1, 1, '2026-01-05', 900, 15.00),
(2, 2, '2026-01-06', 700, 22.00),
(3, 3, '2026-01-07', 500, 30.00),
(4, 4, '2026-01-08', 1000, 12.00),
(5, 5, '2026-01-09', 650, 18.00),
(6, 6, '2026-01-10', 1800, 5.00),
(7, 7, '2026-01-11', 1400, 7.00),
(8, 1, '2026-02-05', 1000, 15.00),
(9, 2, '2026-02-06', 850, 22.00),
(10, 3, '2026-02-07', 600, 30.00),
(11, 4, '2026-02-08', 1100, 12.00),
(12, 5, '2026-02-09', 700, 18.00),
(13, 6, '2026-02-10', 2000, 5.00),
(14, 7, '2026-02-11', 1500, 7.00);
select*from sales;
SELECT 
    p.product_name,
    SUM(pr.quantity_produced) AS total_produced,
    SUM(pr.defective_quantity) AS total_defective,
    CAST(SUM(pr.defective_quantity) AS DECIMAL(10,2)) / SUM(pr.quantity_produced) AS defect_rate
FROM products p
JOIN production pr ON p.product_id = pr.product_id
GROUP BY p.product_id, p.product_name;
SELECT 
    p.product_name,
    SUM(s.quantity_sold * s.selling_price_per_unit) AS total_revenue
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC
LIMIT 1;
SELECT 
    DATE_FORMAT(production_date, '%Y-%m') AS production_month,
    SUM(quantity_produced) AS total_production
FROM production
GROUP BY DATE_FORMAT(production_date, '%Y-%m')
ORDER BY production_month;
SELECT 
    p.category,
    SUM(s.quantity_sold * s.selling_price_per_unit) AS total_revenue,
    SUM(s.quantity_sold * p.cost_per_unit) AS total_cost,
    SUM(s.quantity_sold * (s.selling_price_per_unit - p.cost_per_unit)) AS total_profit
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category;
SELECT 
    pr.production_date,
    p.product_name,
    (CAST(pr.defective_quantity AS DECIMAL(10,2)) / pr.quantity_produced) AS defect_rate
FROM production pr
JOIN products p ON pr.product_id = p.product_id
WHERE (CAST(pr.defective_quantity AS DECIMAL(10,2)) / pr.quantity_produced) > 0.05;
WITH DailyRevenue AS (
    SELECT 
        sale_date,
        SUM(quantity_sold * selling_price_per_unit) AS daily_revenue
    FROM sales
    GROUP BY sale_date
)
SELECT 
    sale_date,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY sale_date) AS running_total_revenue
FROM DailyRevenue;
SELECT 
    p.category,
    SUM(s.quantity_sold * (s.selling_price_per_unit - p.cost_per_unit)) / 
    SUM(s.quantity_sold * s.selling_price_per_unit) AS profit_margin
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY profit_margin DESC
LIMIT 1;
WITH ProductProduction AS (
    SELECT product_id, SUM(quantity_produced) AS total_produced
    FROM production
    GROUP BY product_id
),
ProductSales AS (
    SELECT product_id, SUM(quantity_sold) AS total_sold
    FROM sales
    GROUP BY product_id
)
SELECT 
    p.product_name,
    bp.total_produced,
    COALESCE(bs.total_sold, 0) AS total_sold,
    (bp.total_produced - COALESCE(bs.total_sold, 0)) AS unsold_inventory
FROM products p
JOIN ProductProduction bp ON p.product_id = bp.product_id
LEFT JOIN ProductSales bs ON p.product_id = bs.product_id
WHERE bp.total_produced > COALESCE(bs.total_sold, 0);