-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM dominos_sales;
-- 817860.049999993 (output)

-- 2. Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM dominos_sales;
-- 38.307262295081635 (output)
 
-- 3. Total Pizzas sold 
SELECT SUM(quantity) AS Total_pizza_sold FROM dominos_sales;
-- 49574 (output)

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM  dominos_sales;
-- 21350 (output)

-- 5. Average Pizzas Per Order
select round(sum(quantity)/ count(distinct order_id),2) as avg_pizzas_per_order from dominos_sales;
-- 2.32 (output)


-- 6. Daily Trend for Total Orders

SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM dominos_sales
WHERE order_date IS NOT NULL
GROUP BY DAYOFWEEK(STR_TO_DATE(order_date, '%d-%m-%Y')),
         DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));
 
 -- 7. Monthly trend for orders
 SELECT 
    MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_Orders
FROM dominos_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')),
         MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));

-- 8. % of sales by pizza category

SELECT pizza_category,   round(SUM(total_price),2) as total_revenue,
round(SUM(total_price) * 100 / (SELECT SUM(total_price) from dominos_sales) ,2) AS PCT
FROM dominos_sales
GROUP BY pizza_category;

-- 9. % of sales by pizza size
SELECT pizza_size,   round(SUM(total_price),2) as total_revenue,
round(SUM(total_price) * 100 / (SELECT SUM(total_price) from dominos_sales) ,2) AS PCT
FROM dominos_sales
GROUP BY pizza_size;

-- 10. total pizza sold by pizza category
select pizza_category, sum(quantity)
from dominos_sales 
group by pizza_category
order by  sum(quantity) desc;

-- 11. top 5 pizza by  revenue(total_price)
select pizza_name, round(sum(total_price),2)
from dominos_sales
group by pizza_name
order by sum(total_price) desc
Limit 5;

-- 12. bottom 5 pizza revenue(total_price)
select pizza_name, round(sum(total_price),2)
from dominos_sales
group by pizza_name
order by sum(total_price)
Limit 5;

-- 13. top 5 pizza by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM dominos_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
limit 5;

-- 14. bottom 5 pizza by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM dominos_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold 
limit 5;

-- 15. top 5 pizza by total_orders
SELECT  pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM dominos_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
limit 5;

-- 16. bottom 5 pizza by total_orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM dominos_sales
GROUP BY pizza_name
ORDER BY Total_Orders 
limit 5;
