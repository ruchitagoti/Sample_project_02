USE Pizzahut;

-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT pizza_types.category, ROUND((SUM(orders_details.quantity*pizzas.price) /(SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS TOTAL_REVENUE
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id))*100,2)AS Revenue_in_percentage
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id= pizzas.pizza_type_id
join orders_details
ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY  pizza_types.category
ORDER BY Revenue_in_percentage DESC ;

-- Analyze the cumulative revenue generated over time.
SELECT order_date,Revenue,sum(Revenue) OVER(ORDER BY order_date) AS Cumulative_Revenue
FROM 
(SELECT orders.order_date,SUM(orders_details.quantity*pizzas.price) AS Revenue
FROM orders_details JOIN pizzas
ON orders_details.pizza_id= pizzas.pizza_id
join orders
on orders.order_id =orders_details.order_id
GROUP BY orders.order_date) AS Sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT category,name,revenue,
RANK() OVER(PARTITION BY category ORDER BY revenue DESC ) AS rn
FROM
(SELECT pizza_types.category,pizza_types.name,sum((orders_details.quantity)*pizzas.price) as revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on pizzas.pizza_id =orders_details.pizza_id
GROUP BY pizza_types.category,pizza_types.name) AS a;