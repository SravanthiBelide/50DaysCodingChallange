create Database medicaldb;
create table medical_insurance;
CREATE TABLE medical_insurance (
    policy_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    bmi DECIMAL(5,2),
    children INT,
    smoker VARCHAR(3), 
    region VARCHAR(20), 
    insurance_cost DECIMAL(10,2)
);

INSERT INTO medical_insurance VALUES
(1, 19, 'Female', 27.90, 0, 'Yes', 'southwest', 16884.92),
(2, 18, 'Male', 33.77, 1, 'No', 'southeast', 1725.55),
(3, 28, 'Male', 33.00, 3, 'No', 'southeast', 4449.46),
(4, 33, 'Male', 22.70, 0, 'No', 'northwest', 21984.47),
(5, 32, 'Female', 28.88, 0, 'No', 'southeast', 3866.86),
(6, 31, 'Female', 25.74, 0, 'Yes', 'southeast', 3756.62),
(7, 46, 'Female', 33.44, 1, 'No', 'southeast', 8240.59),
(8, 37, 'Male', 27.74, 2, 'No', 'northwest', 7281.51),
(9, 37, 'Female', 29.83, 2, 'No', 'northeast', 6406.41),
(10, 60, 'Female', 25.84, 0, 'Yes', 'northwest', 28923.14);
select*from medical_insurance;

SELECT COUNT(*) AS total_records FROM medical_insurance;


SELECT * FROM medical_insurance 
WHERE smoker = 'Yes' AND age > 40;

SELECT gender, COUNT(*) AS count 
FROM medical_insurance 
GROUP BY gender;

SELECT smoker, AVG(insurance_cost) AS avg_cost 
FROM medical_insurance 
GROUP BY smoker;

SELECT region, AVG(insurance_cost) AS avg_cost 
FROM medical_insurance 
GROUP BY region 
ORDER BY avg_cost DESC 
LIMIT 1;

SELECT * FROM medical_insurance 
ORDER BY insurance_cost DESC 
LIMIT 5;

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 30 THEN 'Young'
        WHEN age BETWEEN 31 AND 50 THEN 'Middle-aged'
        ELSE 'Senior'
    END AS age_group,
    AVG(insurance_cost) AS avg_cost
FROM medical_insurance
GROUP BY age_group;

SELECT smoker, 
       (bmi > 30) AS high_bmi, 
       AVG(insurance_cost) AS avg_cost
FROM medical_insurance
GROUP BY smoker, high_bmi;


SELECT children, AVG(insurance_cost) FROM medical_insurance GROUP BY children;

SELECT gender, AVG(insurance_cost) FROM medical_insurance GROUP BY gender;

SELECT region, AVG(insurance_cost) FROM medical_insurance GROUP BY region;

SELECT region,
    AVG(CASE WHEN smoker = 'Yes' THEN insurance_cost END) AS smoker_avg,
    AVG(CASE WHEN smoker = 'No' THEN insurance_cost END) AS non_smoker_avg,
    (AVG(CASE WHEN smoker = 'Yes' THEN insurance_cost END) - 
     AVG(CASE WHEN smoker = 'No' THEN insurance_cost END)) AS cost_difference
FROM medical_insurance
GROUP BY region;



