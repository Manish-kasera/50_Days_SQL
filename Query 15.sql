-- Creating the orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

-- Inserting records for the current month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-04-01', 1, 10, 50.00),
    ('2024-04-02', 2, 8, 40.00),
    ('2024-04-03', 3, 15, 30.00),
    ('2024-04-04', 4, 12, 25.00),
    ('2024-04-05', 5, 5, 60.00),
    ('2024-04-06', 6, 20, 20.00),
    ('2024-04-07', 7, 18, 35.00),
    ('2024-04-08', 8, 14, 45.00),
    ('2024-04-09', 1, 10, 50.00),
    ('2024-04-10', 2, 8, 40.00);

-- Inserting records for the last month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-03-01', 1, 12, 50.00),
    ('2024-03-02', 2, 10, 40.00),
    ('2024-03-03', 3, 18, 30.00),
    ('2024-03-04', 4, 14, 25.00),
    ('2024-03-05', 5, 7, 60.00),
    ('2024-03-06', 6, 22, 20.00),
    ('2024-03-07', 7, 20, 35.00),
    ('2024-03-08', 8, 16, 45.00),
    ('2024-03-09', 1, 12, 50.00),
    ('2024-03-10', 2, 10, 40.00);

-- Inserting records for the previous month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-02-01', 1, 15, 50.00),
    ('2024-02-02', 2, 12, 40.00),
    ('2024-02-03', 3, 20, 30.00),
    ('2024-02-04', 4, 16, 25.00),
    ('2024-02-05', 5, 9, 60.00),
    ('2024-02-06', 6, 25, 20.00),
    ('2024-02-07', 7, 22, 35.00),
    ('2024-02-08', 8, 18, 45.00),
    ('2024-02-09', 1, 15, 50.00),
    ('2024-02-10', 2, 12, 40.00);



/*

Write an SQL query to retrieve the product details for items whose revenue 
decreased compared to the previous month. 

-- Assume current_month = 4(April) and previous 3(March)

Display the product ID, quantity sold, 
and revenue for both the current and previous months.

*/

select * from orders;

WITH current_month_revenue as
(
SELECT
       EXTRACT(MONTH FROM order_date) as month_number,
       product_id,
       SUM(quantity) AS total_quantity,
       SUM(quantity*price) AS total_revenue 
FROM orders
GROUP by month_number,product_id
HAVING month_number = 4
),

previous_month_revenue as
(
SELECT
       EXTRACT(MONTH FROM order_date) as month_number,
       product_id,
       SUM(quantity) AS total_quantity,
       SUM(quantity*price) AS total_revenue 
FROM orders
GROUP by month_number,product_id
HAVING month_number = 3
)

SELECT 
      c.product_id,
      c.month_number,
      c.total_quantity,
      c.total_revenue,
      p.month_number,
      p.total_quantity,
      p.total_revenue 
FROM current_month_revenue AS c
JOIN previous_month_revenue AS p
ON c.product_id = p.product_id
WHERE c.total_revenue < p.total_revenue;
  
   
