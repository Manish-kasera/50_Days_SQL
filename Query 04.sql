
DROP TABLE IF EXISTS orders;
create table orders(
  	category varchar(20),
	product varchar(20),
	user_id int , 
  	spend int,
  	transaction_date DATE
);

Insert into orders values
('appliance','refrigerator',165,246.00,'2021/12/26'),
('appliance','washingmachine',123,219.80,'2022/03/02'),
('electronics','vacuum',178,152.00,'2022/04/05'),
('electronics','wirelessheadset',156,	249.90,'2022/07/08'),
('electronics','TV',145,189.00,'2022/07/15'),
('Television','TV',165,129.00,'2022/07/15'),
('Television','TV',163,129.00,'2022/07/15'),
('Television','TV',141,129.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','Ben10',145,189.00,'2022/07/15'),
('toys','yoyo',165,129.00,'2022/07/15'),
('toys','yoyo',163,129.00,'2022/07/15'),
('toys','yoyo',141,129.00,'2022/07/15'),
('toys','yoyo',145,189.00,'2022/07/15'),
('electronics','vacuum',145,189.00,'2022/07/15');



/*
Find the top 2 products in the top 2 categories based on spend amount?
*/
WITH ranked_category as(
SELECT 
  category,
  total_category_spend
FROM
(  
SELECT 
  category,
  sum(spend) as total_category_spend,
  dense_rank() OVER (ORDER BY sum(spend) DESC) as drn 
FROM Orders
group by category
) as subquery
where drn <= 2
)

SELECT * 
FROM
	(	SELECT 
			o.category,
			o.product,
			SUM(o.spend) as total_spend_by_product,
			DENSE_RANK() OVER(PARTITION BY o.category ORDER BY SUM(o.spend) DESC ) as pdrn
		FROM orders as o
		JOIN ranked_category as rc
		ON rc.category = o.category	
		GROUP BY o.category, o.product
) as subquery
WHERE pdrn <=2;
