-- SQL examples

/* SELECT all columns*/

SELECT * 
FROM table;


/* LIMIT and ORDER BY - select the earliest 10 orders */

SELECT id, occurred_at, total_amt_usd 
FROM orders
ORDER BY occurred_at
LIMIT 10;


/* LIMIT and ORDER BY - select the top 5 orders based on total amount usd */

SELECT id, occurred_at, total_amt_usd 
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;


/* ORDER BY [columns] - select the top 5 rows from orders ordered according to newest to oldest, but with the largest total_amt_usd for each date listed first for each date.*/

SELECT *
FROM orders
ORDER BY occurred_at DESC, total_amt_usd DESC
LIMIT 5;


/* ORDER BY [columns] - select the top 10 rows from orders ordered according to oldest to newest, but with the smallest total_amt_usd for each date listed first for each date. */

SELECT *
FROM orders
ORDER BY occurred_at ASC, total_amt_usd ASC -- also valid: ORDER BY occurred_at, total_amt_usd
LIMIT 10;


/* WHERE [conditions] - Pull the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000. */

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/*ARITHMETIC OPERATORS - Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields. From orders. */

SELECT 	id 
	 	,account_id
        ,standard_amt_usd/standard_qty AS unit_price
FROM 	orders
LIMIT 	10;


/* LIKE - From accounts table get all companies whose name start with C. */

SELECT *
FROM accounts
WHERE name LIKE 'C%';


/* IN - Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom. */

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');


/* NOT IN  - Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.*/

SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');


/* NOT LIKE - From accounts get all the companies whose names do not start with 'C' */

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%';


/* AND ---- WHERE column ARITHMETIC/LOGIC_OPERATOR valueA AND column ARITHMETIC/LOGIC_OPERATOR valueB  AND ... - Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0. */

SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;


/* AND ---- Using the accounts table find all the companies whose names do not start with 'C' and end with 's'. */

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';


/* AND , BETWEEN --- Use the web_events table to find all information regarding individuals who were contacted via organic or adwords and started their account at any point in 2016 sorted from newest to oldest.*/

SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01' 
ORDER BY occurred_at DESC;


/* OR - Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000. */

SELECT id
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);


/* MANY OPERATORS - From accounts find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'. */

SELECT name
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana%');



SELECT *
FROM city_list
WHERE country = 'United States' AND city = 'Boston';

SELECT * 
FROM city_data
WHERE country = 'United States' AND city = 'Boston';

SELECT *
FROM global_data
WHERE year BETWEEN 1743 AND 2013;