USE Pizzahut;
-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category,SUM(orders_details.quantity) as QUANTITY
FROM pizza_types join pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY QUANTITY DESC ;

-- Determine the distribution of orders by hour of the day.
SELECT HOUR(order_time),COUNT(order_id) as ORDER_s FROM orders
GROUP BY HOUR(order_time)
ORDER BY ORDER_s DESC ;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT category,COUNT(name) as PIZZA_NAME
FROM pizza_types
GROUP BY category
ORDER BY PIZZA_NAME DESC ; 

-- Group the orders by date and 
-- calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(Quantity)) AS AVERAGE_PIZZA_ORDERD
FROM 
(SELECT orders.order_date,SUM(orders_details.quantity) as Quantity
FROM orders JOIN orders_details
on orders.order_id = orders_details.order_id
GROUP BY orders.order_date) AS Order_quantity;


-- Determine the top 3 most ordered pizza types based on revenue.
SELECT pizza_types.name, SUM(orders_details.quantity*pizzas.price) AS Revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id= pizzas.pizza_type_id
join orders_details
ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY  pizza_types.name
ORDER BY Revenue DESC LIMIT 3;
