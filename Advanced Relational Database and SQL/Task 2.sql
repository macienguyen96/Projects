--
-- Welcome to Task 2 !!
--
-- Advanced RDB and SQL
--
-- Server Functions

USE world_peace;

-- aggregate functions
SELECT COUNT(*)
FROM customer;

SELECT MAX(qoh)
FROM merchandise_item;

SELECT MIN(unit_price)/100
FROM merchandise_item;

SELECT AVG(unit_price)/100 AS average_price
FROM merchandise_item; 

-- TODO --

-- Write an SQL statement to:
-- find the sum of the column quantity
-- the function is SUM( )
-- in the table customer_order_line_item
SELECT SUM(quantity)
FROM customer_order_line_item;

-- Non-aggregate functions
SELECT FORMAT(unit_price/100, 2, "en_IN") as unit_price_decimal
FROM merchandise_item;

SELECT CONCAT(CHAR_LENGTH(description), " chars")
FROM merchandise_item;

-- TODO --

-- Write an SQL statement to:

-- find the average all the unit_price in the table merchandise_item
-- (don't forget to divide it by 100)
-- format it to 2 decimal places and use country code "en_IN" for Indian English
-- add the Rupee symbol ₹ in front of it, copy and paste it if you'd like

SELECT CONCAT("₹", FORMAT(AVG(unit_price)/100, 2, "en_IN"))
FROM merchandise_item;
