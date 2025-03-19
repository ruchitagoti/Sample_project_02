CREATE DATABASE pizzahut;

USE Pizzahut;

CREATE TABLE orders(
order_id INT NOT NULL,
order_time TIME NOT NULL,
order_date DATE NOT NULL,
PRIMARY KEY (order_id)
);

CREATE TABLE orders_details(
order_details_id INT NOT NULL,
order_id INT NOT NULL,
pizza_id TEXT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (order_details_id));

SELECT * FROM pizzahut.orders;
SELECT * FROM pizzahut.orders_details;
SELECT * FROM pizzahut.pizza_types;
SELECT * FROM pizzahut.pizzas;


-- Retrieve the total number of orders placed.
SELECT count(order_id)  AS TOTAL_ORDERS FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(orders_details.quantity * pizzas.price),
            2) AS TOTAL_REVENUE
FROM
    orders_details
        JOIN
    pizzas ON pizzas.pizza_id = orders_details.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price AS HIGHEST_PRICE_OF_PIZZA
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(orders_details.quantity) AS common_pizza_size_ordered
FROM
    orders_details
        JOIN
    pizzas ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY common_pizza_size_ordered DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name, SUM(orders_details.quantity) AS QUANTITY
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY QUANTITY DESC
LIMIT 5;





