--Store ID,city and country
SELECT st.store_id AS "STORE ID", ct.city AS "CITY",cn.country AS "COUNTRY" 
FROM store AS st
JOIN address AS ad ON st.address_id  = ad.address_id
JOIN city AS ct ON ad.city_id  = ct.city_id 
JOIN country AS cn ON ct.country_id = cn.country_id;
--How much business, in dollars, each store brought in? 
SELECT st.store_id AS "STORE ID", SUM(p.amount) as "Sales by Store"
FROM store AS st
JOIN staff AS sf ON st.store_id = sf.store_id
JOIN rental AS r ON sf.staff_id = r.staff_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY "STORE ID";
--What is the average running time of films by category?
SELECT cg.name AS "CATEGORY", avg(f.length) AS "AVG RUNNING TIME"
FROM category AS cg 
JOIN film_category AS fc ON cg.category_id  = fc.category_id
JOIN film as f ON fc.film_id= f.film_id
GROUP BY cg.name;
--Which film categories are longest?
SELECT cg.name AS "CATEGORY", avg(f.length) AS "AVG RUNNING TIME"
FROM category AS cg 
JOIN film_category AS fc ON cg.category_id  = fc.category_id
JOIN film as f ON fc.film_id= f.film_id
GROUP BY cg.name
ORDER BY avg(f.length) DESC
LIMIT 5;
--Display the most frequently rented movies in descending order.
SELECT f.title AS "TITLE", COUNT(*)
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY COUNT(*) DESC
LIMIT 5;
--List the top five genres in gross revenue in descending order.
SELECT c.name AS "GENRE",SUM(p.amount) AS "TOTAL_REVENUE"
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;
---- Is the movie available?
SELECT
 CASE
 WHEN EXISTS (
 SELECT 1
 FROM inventory AS i
 JOIN film AS f ON i.film_id = f.film_id
 WHERE f.title = 'Academy Dinosaur'
 AND i.store_id = 1
 AND i.inventory_id NOT IN (
 SELECT inventory_id FROM rental WHERE return_date IS NULL
 )
 ) THEN 'Yes'
 ELSE 'No'
 END AS is_available;