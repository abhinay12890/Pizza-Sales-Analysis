use pizzahut;
/* Basic */
/* Total number of orders placed */
SELECT count(order_id) as Total_Orders FROM pizzahut.orders;

/* Total Revenue Generated*/
 SELECT ROUND(SUM(p.price*o.quantity),2) as Total_Revenue from pizzas as p
 inner join order_details as o on p.pizza_id=o.pizza_id;
 
 /* highest-priced pizza */
 SELECT pt.name,p.price FROM pizzahut.pizza_types as pt
 inner join pizzas as p on pt.pizza_type_id=p.pizza_type_id
 order by p.price desc limit 1;
 
 /* most common pizza size*/
 select p.size,count(p.size) as count from pizzas as p
 inner join order_details as od on p.pizza_id=od.pizza_id
 group by p.size order by count desc limit 1;
 
 /* top 5 most ordered pizza types along with their quantities*/
SELECT pt.name AS pizza_type,COUNT(od.pizza_id) AS quantity
FROM order_details AS od
INNER JOIN pizzas AS p ON p.pizza_id = od.pizza_id
INNER JOIN pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name ORDER BY quantity DESC LIMIT 5;

/* Intermediate */ 
/* total quantity of each category pizza ordered */
SELECT pt.category,sum(od.quantity) as Quantity FROM pizzahut.order_details as od
inner join pizzahut.pizzas as p on  p.pizza_id= od.pizza_id 
inner join pizzahut.pizza_types as pt on p.pizza_type_id=pt.pizza_type_id
group by pt.category;

/* distribution of order by hour of day */
SELECT HOUR(order_time) as Hr, COUNT(order_id) as order_count
from orders group by hr;

/* distribution of category wise pizzas*/
select category, count(name) from pizza_types
group by category;

/* grouping by date */ 
SELECT o.order_date, avg(od.quantity) as Average_Orders FROM pizzahut.order_details as od
inner join pizzahut.orders as o on o.order_id=od.order_id
group by o.order_date;

/* Top 3 most ordered pizza types based on revenue */
select pizza_types.name, sum(order_details.quantity*pizzas.price) as Revenue
from pizza_types join pizzas on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name order by Revenue desc limit 3

/* Advanced */
/* Percentage contribution of each type*/
SELECT 
    Sub_Query.category,
    Sub_Query.Revenue,
    round((Sub_Query.Revenue * 100.0 / TotalRevenue.total),2) AS Percentage
FROM (
    SELECT 
        pt.category,
        round(SUM(od.quantity * p.price),2) AS Revenue
    FROM 
        pizzahut.order_details AS od
    INNER JOIN 
        pizzahut.pizzas AS p ON od.pizza_id = p.pizza_id
    INNER JOIN 
        pizzahut.pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY 
        pt.category
) AS Sub_Query
CROSS JOIN (
    SELECT 
        SUM(od.quantity * p.price) AS total
    FROM 
        pizzahut.order_details AS od
    INNER JOIN 
        pizzahut.pizzas AS p ON od.pizza_id = p.pizza_id
) AS TotalRevenue;

 /* Top 3 most ordered pizza types based on revenue of each pizza category*/
select name,revenue from
(select category,name,revenue, rank() over(partition by category order by revenue desc) as rn
from (select pizza_types.category, pizza_types.name,
sum((order_details.quantity) * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category,pizza_types.name) as a) as b
where rn<=3;
