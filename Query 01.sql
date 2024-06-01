

create database Top50;
Use Top50;

-- Create the employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert records for three departments
INSERT INTO employees (name, department, salary) VALUES 
('John Doe', 'Engineering', 63000),
('Jane Smith', 'Engineering', 55000),
('Michael Johnson', 'Engineering', 64000),
('Emily Davis', 'Marketing', 58000),
('Chris Brown', 'Marketing', 56000),
('Emma Wilson', 'Marketing', 59000),
('Alex Lee', 'Sales', 58000),
('Sarah Adams', 'Sales', 58000),
('Ryan Clark', 'Sales', 61000);


/*
Write the SQL query to find the second highest salary
*/

-- Approach 1 (Using Limit and offset )

SELECT * FROM employees
ORDER BY salary DESC
LIMIT 1 offset 1 ;



-- Approach 2 (Using subquery)

SELECT * 
FROM employees e1
where 2 = (SELECT count(e2.salary) from employees e2  where e2.salary >= e1.salary); 




-- Approach 3 (Using ranking function)
SELECT *
FROM
(SELECT 
    *,
   RANK() OVER(ORDER BY salary DESC) as ranking
FROM employees) as test
where ranking = 2;   
   
