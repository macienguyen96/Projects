--
-- Welcome to Task 5 !!
--
-- Advanced RDB and SQL
--
-- Triggers

USE world_peace;

DROP TRIGGER IF EXISTS decrease_inventory_tgr;

-- decrease qoh (quantity on hand) after inserting a new line item
-- into the table customer_order_line_item

DELIMITER $$

CREATE TRIGGER decrease_inventory_tgr

	AFTER INSERT ON customer_order_line_item
    
    FOR EACH ROW
    
    BEGIN
    
		UPDATE merchandise_item
        SET qoh = qoh - NEW.quantity
        WHERE merchandise_item_id = NEW.merchandise_item_id;
        
	END $$

DELIMITER ;


-- check qoh (quantity on hand) before inserting a new line item
-- into the table customer_order_line_item

DROP TRIGGER IF EXISTS inventory_check_tgr;

DELIMITER $$

CREATE TRIGGER inventory_check_tgr

	BEFORE INSERT ON customer_order_line_item
    FOR EACH ROW

BEGIN
           
	-- using stored function
    
-- 	IF (get_qoh_ftn(NEW.merchandise_item_id) < NEW.quantity) THEN
--		SIGNAL SQLSTATE "45000"
-- 		SET MESSAGE_TEXT = "Insufficient inventory";
-- 	END IF;
        
	-- using stored procedure
    
    DECLARE inventory INT;
    
    CALL get_qoh_stp(NEW.merchandise_item_id, inventory);
    
	IF (inventory < NEW.quantity) THEN
		SIGNAL SQLSTATE "45000"
		SET MESSAGE_TEXT = "Insufficient inventory";
	END IF;
    
	-- doing it from stratch
        
-- 	DECLARE inventory INT;
-- 	
--     SELECT qoh INTO inventory
-- 	FROM merchandise_item
-- 	WHERE merchandise_item_id = NEW.merchandise_item_id;

-- 	IF (inventory < NEW.quantity) THEN
-- 		SIGNAL SQLSTATE "45000"
-- 		SET MESSAGE_TEXT = "Insufficient inventory";
-- 	END IF;
        
END $$
        
DELIMITER ;

-- check to see if it works!

UPDATE merchandise_item
SET qoh = 10
WHERE merchandise_item_id = "ITALYPASTA";

DELETE FROM customer_order_line_item
WHERE customer_order_id = "D000000003" AND
merchandise_item_id = "ITALYPASTA";

INSERT INTO customer_order_line_item
SET 
customer_order_id = "D000000003",
merchandise_item_id = "ITALYPASTA",
quantity = 5;