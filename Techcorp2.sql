-- 1. Top 3 customers based on orders
select 
	customers.first_name,
    customers.last_name,
    sum(orders.total_amount) as total_order_amount
    from customers
    left join orders on orders.customer_id = customers.customer_id
    group by customers.customer_id 
    order by total_order_amount desc
    limit 3
;
	
-- 2. Average order value each customer
select 
	customers.first_name,
    customers.last_name,
    avg(orders.total_amount) as avg_order_amount
    from customers
    left join orders on orders.customer_id = customers.customer_id
    group by customers.customer_id 
;

-- 3. Employees with >4 resolved ticket support
select 
	employees.first_name,
    employees.last_name,
    count(supporttickets.ticket_id)
    from employees
    left join supporttickets on employees.employee_id = supporttickets.employee_id
    where supporttickets.status = 'resolved'
    group by employees.employee_id
    having count(supporttickets.ticket_id)>4
;

-- 4. Find products which have not order yet 
select 
	products.product_name
    from products
    left join orderdetails on products.product_id = orderdetails.product_id
    where orderdetails.order_id is null
;

-- 5. Calculate total revenue
select
	sum(orderdetails.quantity*orderdetails.unit_price)
    from orderdetails
;

-- 6. Average price each category and list categories average price higher than $500
with avg_price as (
	select products.category,
    avg(products.price) as average
    from products
    group by products.category)
select *
	from avg_price
    where average > 500
;

-- 7. Customer with order higher than $1000
select *
	from customers
    where customers.customer_id in
	(select
	orders.customer_id
    from orders
    where orders.total_amount > 1000)
;