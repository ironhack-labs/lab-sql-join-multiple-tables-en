-- CHELLENGE 1 

SELECT 
   SID AS "STORE ID",
   "city" AS "CITY ID",
   "country" AS "COUNTRY ID"
FROM customer_list;

-- CHELLEGE 2 

SELECT 
   s.store_id,
   SUM(p.amount) AS total_revenue

FROM payment AS p
JOIN staff AS s ON p.staff_id = s.staff_id
GROUP by s.store_id
ORDER by total_revenue DESC;

--CHALLEGE 3 

SELECT
   c.name AS category,
   AVG(f.length) AS avg_running_time
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP by c.name
ORDER BY avg_running_time DESC;

-- CHELLENGE 4

SELECT
   c.name AS category,
   MAX(f.length) AS longest_film
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP by c.name
ORDER BY longest_film DESC;

-- CHELLEGE 5

SELECT
   f.title,
   COUNT(*) AS rental_count
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
GROUP by f.title
ORDER BY rental_count DESC LIMIT 1;



