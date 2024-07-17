Create Database SrPizza;

Use  SrPizza;

CREATE TABLE orders
(
    order_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    PRIMARY KEY (order_id)
);
 
 
CREATE TABLE order_details
(
    order_details_id INT NOT NULL,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_details_id)
);

-- Retrieve the total number of orders placed.

 Select count(order_id) as total_orders
 from orders;
 
 -- Calculate the total revenue generated from pizza sales.
 Select * from pizzas;
 Select round(sum(order_details.quantity * pizzas.price),2) as total_sales
 from order_details
 join pizzas
 on pizzas.pizza_id = order_details.pizza_id;

 -- Identify the highest-priced pizza.
 
SELECT pizza_types.name, pizzas.price
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

 -- Identify the most common pizza size ordered.
 
SELECT pizzas.size, COUNT(order_details.order_details_id) AS order_count
FROM pizzas
JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.

 SELECT pizza_types.name, SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

Select pizza_types.category, 
SUM(order_details.quantity) as quantity
 FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
 ORDER BY quantity DESC;
 
 -- Determine the distribution of orders by hour of the day.
 
  Select hour(order_time), count(order_id) as order_count
  from orders
  group by hour (order_time);
  
  -- Join relevant tables to find the category-wise distribution of pizzas.
  
Select category, count(name) 
from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT AVG(order_quantity) 
FROM (
    SELECT orders.order_date, SUM(order_details.quantity) AS order_quantity
    FROM orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date
) AS subquery;

-- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types 
join pizzas
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc
limit 3;


















