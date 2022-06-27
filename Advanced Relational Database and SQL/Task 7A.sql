--
-- Welcome to Task 7 !!
--
-- Advanced RDB and SQL
--
-- CTE Recursive Part A

USE world_peace;

WITH merchandise_cte (merchanise_item_id, description, unit_price_decimal, alpha_sort, bundle_id)

-- defining the common table expression

AS ( 

	-- top level items
    
	SELECT 
		merchandise_item_id,
		description,
		unit_price / 100 as unit_price_decimal,
		description AS alpha_sort,
		bundle_id -- CAST(NULL AS CHAR(10))
	FROM merchandise_item

	UNION ALL

	-- these are the children of the bundles

	SELECT 
		D.merchandise_item_id AS merchandise_item_id,
		CONCAT(" |__ ", D.description) AS description,
		NULL AS unit_price_decimal,
		CONCAT(C.description, " ", D.description) AS alpha_sort,
		D.bundle_id
	FROM merchandise_item as C, merchandise_item as D
	WHERE C.merchandise_item_id = D.bundle_id
)

-- using the common table expression

SELECT * FROM merchandise_cte
ORDER BY alpha_sort