create database pizzahut;

create table orders (
Order_Id INT NOT NULL,
Order_Date DATE NOT NULL,
Order_Time time not null,
primary key(Order_id)
);

SELECT *FROM pizzahut.orders;

create table order_details (
order_details_id INT NOT NULL,
order_id INT NOT NULL,
pizza_id text not null,
quantity INT NOT NULL,
primary key(order_details_id)
);

select * from pizzas ;
select * from pizza_types ;
select * from order_details ;
select * from orders ;

-- Q1 -- Retrieve the total number of orders placed
select count(order_id) as total_orders from orders;

-- Q2 Calculate the total revenue generated from pizza sales
select sum(order_details.quantity*pizzas.price) as 'Total Revenue'
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id ;

-- Q3 Identify the highest-priced pizza
Select pizza_types.name, price
from pizza_types 
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by price desc limit 1;


-- Q4 Identify the most common pizza size ordered
select pizzas.size, count(order_details.order_details_id) as order_count
from pizzas
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by order_count desc;

-- Q5 List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types 
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name 
order by quantity desc limit 5;

-- Q6 Join the necessary tables to find the total quantity of each pizza category ordered
select pizza_types.category,
sum(order_details.quantity) as total_quantity
from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category
order by total_quantity; 

-- Q7 Determine the distribution of orders by hour of the day
select hour(Order_Time) as hour, count(order_id) as order_count
from orders
group by hour(Order_Time);

-- Q8 Join relevant tables to find the category-wise distribution of pizzas.
SELECT pizza_types.category, count(pizza_types.category) as pizza_category
from pizza_types
group by pizza_types.category
order by pizza_category;

-- Q9 Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity),0) as avg_quantity from
(select orders.Order_Date, sum(order_details.quantity) as quantity
from orders
join order_details on order_details.order_id = orders.order_id
group by orders.order_date)as order_quantity;

-- Q10 Determine the top 3 most ordered pizza types based on revenue.
Select pizza_types.name, sum(order_details.quantity*pizzas.price) as revenue
from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by revenue desc limit 3;


