--
-- Welcome to Task 6 !!
--
-- Advanced RDB and SQL
--
-- Common Table Expressions

USE world_peace;

WITH order_line_item_cte (new_name, new_order_id, new_description, order_qty, new_unit_price, line_subtotal ) AS
(SELECT
customer.customer_name,
customer_order_line_item.customer_order_id,
merchandise_item.description,
customer_order_line_item.quantity,
merchandise_item.unit_price / 100 AS "unit_price_decimal",
customer_order_line_item.quantity * merchandise_item.unit_price / 100 AS "line_total"
FROM customer_order_line_item, customer_order, customer, merchandise_item
WHERE customer_order_line_item.merchandise_item_id = merchandise_item.merchandise_item_id AND
customer_order.customer_id = customer.customer_id AND
customer_order_line_item.customer_order_id = customer_order.customer_order_id
ORDER BY
customer_name,
customer_order_line_item.customer_order_id,
merchandise_item.description
-- TODO -----> Paste the customer order SQL here
)

SELECT * from order_line_item_cte;

-- TODO --

-- write a common table expression
-- call it customer_cte
-- select two columns customer_id and customer_name
-- from the table customer
-- sort by customer_name
-- run it buy select *
WITH customer_cte (customer_id, customer_name) AS
(SELECT customer_id, customer_name
FROM customer
ORDER BY customer_name
)

SELECT * FROM customer_cte
