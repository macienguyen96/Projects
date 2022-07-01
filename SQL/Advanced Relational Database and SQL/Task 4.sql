--
-- Welcome to Task 4 !!
--
-- Advanced RDB and SQL
--
-- Stored Procedure

USE world_peace;

DROP PROCEDURE IF EXISTS customer_roster_stp;

DELIMITER $$

CREATE PROCEDURE customer_roster_stp()

BEGIN

	-- TODO --
	-- write an SQL to select all the customer
	-- from table customer
    -- sort it by customer_name
	SELECT *
    FROM customer
    ORDER BY customer_name;
END $$

DELIMITER ;

-- check to see if it works
CALL customer_roster_stp();

-- --------------

DROP PROCEDURE IF EXISTS get_qoh_stp;

DELIMITER $$

CREATE PROCEDURE get_qoh_stp(
	IN request_item_id CHAR(10),
    OUT qoh_to_return INT)
    
BEGIN

	-- TODO --
	-- write an SQL to select the qoh (quantity on hand)
    -- from table merchandise_item
	-- for merchandise_item_id matching request_item_id
    -- note that your statement will not run yet
    SELECT qoh INTO qoh_to_return
    FROM merchandise_item
    WHERE merchandise_item_id = request_item_id;
    
END$$

DELIMITER ;

SET @qty = 0;
CALL get_qoh_stp("ITALYPASTA", @qty);
SELECT @qty;