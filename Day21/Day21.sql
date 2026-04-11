create database insurancedb;
create table claims;
CREATE TABLE claims ( 
claim_id INT, 
policy_holder VARCHAR(50), 
policy_type VARCHAR(50), 
claim_amount INT, 
claim_date DATE, 
status VARCHAR(20) 
);
INSERT INTO claims VALUES 
(1, 'Ravi', 'Health', 50000, '2024-01-10', 'Approved'), 
(2, 'Anita', 'Vehicle', 20000, '2024-01-12', 'Rejected'), 
(3, 'Ravi', 'Health', 30000, '2024-01-20', 'Approved'), 
(4, 'Suresh', 'Life', 100000, '2024-01-25', 'Approved'), 
(5, 'Anita', 'Vehicle', 15000, '2024-02-01', 'Approved'), 
(6, 'Kiran', 'Health', 40000, '2024-02-10', 'Rejected'), 
(7, 'Ravi', 'Health', 70000, '2024-02-15', 'Approved'), 
(8, 'Suresh', 'Life', 50000, '2024-02-20', 'Rejected');

select*from claims;

SELECT * FROM claims 
WHERE claim_amount > (SELECT AVG(claim_amount) FROM claims);

SELECT DISTINCT policy_holder 
FROM claims 
WHERE policy_holder IN (
    SELECT policy_holder 
    FROM claims 
    WHERE status = 'Approved'
);


SELECT * FROM claims c1
WHERE claim_amount > (
    SELECT AVG(claim_amount) 
    FROM claims c2 
    WHERE c2.policy_holder = c1.policy_holder
);


SELECT 
    claim_id, 
    policy_holder, 
    claim_amount, 
    (SELECT AVG(claim_amount) FROM claims) AS overall_average
FROM claims;

