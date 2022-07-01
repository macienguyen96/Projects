--
-- Welcome to Task 7 !!
--
-- Advanced RDB and SQL
--
-- CTE Recursive Part B

USE world_peace;

WITH RECURSIVE merchandise_cte (merchandise_item_id, depth, description, unit_price_decimal, alpha_sort, bundle_id)

-- defining the common table expression

AS ( 

	-- top level items

	SELECT 
		merchandise_item_id,						-- merchandise_item_id
		1,											-- depth
		CAST(description AS CHAR(500)),				-- description
		CAST(unit_price / 100 AS DECIMAL(8, 2)),	-- unit_price_decimal
		CAST(description AS CHAR(700)), 			-- alpha_sort
		bundle_id									-- bundle_id
	FROM merchandise_item

	UNION ALL

	-- these are the contents of the bundles

	SELECT 
		D.merchandise_item_id,												-- merchandise_item_id
		depth + 1,															-- depth
		CAST(CONCAT(REPEAT(" |__ ", depth), D.description) AS CHAR(500)),	-- description
		CAST(NULL AS DECIMAL(8, 2)),										-- unit_price_decimal
		CAST(CONCAT(C.alpha_sort, " ", D.description) AS CHAR(700)),    	-- alpha_sort
		D.bundle_id															-- bundle_id
	FROM merchandise_cte AS C, merchandise_item AS D
	WHERE C.merchandise_item_id = D.bundle_id
)

-- using the common table expression

SELECT * FROM merchandise_cte
ORDER BY alpha_sort 