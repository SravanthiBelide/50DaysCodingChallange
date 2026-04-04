create Database agriculturaldb;
CREATE TABLE farmers (
    farmer_id INT PRIMARY KEY,        
    first_name VARCHAR(50),            
    last_name VARCHAR(50),             
    email VARCHAR(100),                
    hire_date DATE                     
);
select*from farmers;

CREATE TABLE plots (
    plot_id INT PRIMARY KEY,           
    plot_name VARCHAR(100),            
    farmer_id INT,                     
    crop_type VARCHAR(50),           
    soil_type VARCHAR(50),             
    FOREIGN KEY (farmer_id) REFERENCES farmers(farmer_id)
);
select*from plots;

CREATE TABLE yields (
    yield_id INT PRIMARY KEY,          
    plot_id INT,                       
    harvest_date DATE,                 
    yield_kg DECIMAL(10, 2),           
    weather_condition VARCHAR(50),     
    FOREIGN KEY (plot_id) REFERENCES plots(plot_id)
);
select*from yields;

CREATE TABLE irrigation_logs (
    log_id INT PRIMARY KEY,            
    plot_id INT,                      
    irrigation_date DATE,              
    water_amount_liters DECIMAL(10, 2), 
    FOREIGN KEY (plot_id) REFERENCES plots(plot_id)
);

select*from irrigation_logs;

INSERT INTO farmers (farmer_id, first_name, last_name, email, hire_date) VALUES
(1, 'John', 'Doe', 'john.doe@agri.com', '2022-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@agri.com', '2022-03-10'),
(3, 'Robert', 'Brown', 'robert.b@agri.com', '2023-05-20');


INSERT INTO plots (plot_id, plot_name, farmer_id, crop_type, soil_type) VALUES
(101, 'West Field', 1, 'Wheat', 'Loam'),
(102, 'North Pasture', 1, 'Corn', 'Clay'),
(103, 'East Ridge', 2, 'Soybeans', 'Sand'),
(104, 'South Valley', 3, 'Wheat', 'Loam');

INSERT INTO yields (yield_id, plot_id, harvest_date, yield_kg, weather_condition) VALUES
(1, 101, '2023-06-15', 1200.50, 'Sunny'),
(2, 102, '2023-07-20', 1500.00, 'Mild'),
(3, 103, '2023-08-05', 900.75, 'Rainy'),
(4, 104, '2023-06-18', 1100.00, 'Sunny'),
(5, 101, '2024-06-14', 1250.00, 'Mild');

INSERT INTO irrigation_logs (log_id, plot_id, irrigation_date, water_amount_liters) VALUES
(501, 101, '2023-05-01', 5000.00),
(502, 102, '2023-05-15', 7000.00),
(503, 103, '2023-06-01', 3000.00),
(504, 104, '2023-05-05', 4500.00),
(505, 101, '2023-05-20', 4800.00);

SELECT p.plot_name, p.crop_type, AVG(y.yield_kg) AS average_yield_kg
FROM plots p
JOIN yields y ON p.plot_id = y.plot_id
GROUP BY p.plot_name, p.crop_type
ORDER BY average_yield_kg DESC
LIMIT 3;


SELECT p.plot_name, SUM(i.water_amount_liters) AS total_water_liters
FROM plots p
JOIN irrigation_logs i ON p.plot_id = i.plot_id
GROUP BY p.plot_name
ORDER BY total_water_liters DESC;



SELECT p.crop_type, y.weather_condition, AVG(y.yield_kg) AS average_yield_kg
FROM plots p
JOIN yields y ON p.plot_id = y.plot_id
GROUP BY p.crop_type, y.weather_condition;



SELECT soil_type, plot_name, yield_kg AS highest_yield_kg
FROM (
    SELECT p.soil_type, p.plot_name, y.yield_kg,
           ROW_NUMBER() OVER(PARTITION BY p.soil_type ORDER BY y.yield_kg DESC) as row_num
    FROM plots p
    JOIN yields y ON p.plot_id = y.plot_id
) AS ranked_yields
WHERE row_num = 1;

-- Task 3.1: Farmer with lowest average water consumption
SELECT f.first_name, f.last_name, AVG(i.water_amount_liters) AS average_water_liters_per_plot
FROM farmers f
JOIN plots p ON f.farmer_id = p.farmer_id
JOIN irrigation_logs i ON p.plot_id = i.plot_id
GROUP BY f.first_name, f.last_name
ORDER BY average_water_liters_per_plot ASC
LIMIT 1;



SELECT DATE_FORMAT(harvest_date, '%Y-%m') AS harvest_month, 
       COUNT(yield_id) AS number_of_harvests
FROM yields
WHERE harvest_date >= DATE_SUB(CURRENT_DATE, INTERVAL 12 MONTH)
GROUP BY DATE_FORMAT(harvest_date, '%Y-%m')
ORDER BY harvest_month DESC;



WITH CropAverages AS (
    SELECT p.crop_type, 
           AVG(y.yield_kg) as avg_yield, 
           AVG(i.water_amount_liters) as avg_water
    FROM plots p
    JOIN yields y ON p.plot_id = y.plot_id
    JOIN irrigation_logs i ON p.plot_id = i.plot_id
    GROUP BY p.crop_type
)
SELECT p.plot_name, p.crop_type, y.yield_kg, i.water_amount_liters
FROM plots p
JOIN yields y ON p.plot_id = y.plot_id
JOIN irrigation_logs i ON p.plot_id = i.plot_id
JOIN CropAverages ca ON p.crop_type = ca.crop_type
WHERE y.yield_kg < ca.avg_yield 
  AND i.water_amount_liters > ca.avg_water;
  