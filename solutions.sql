--1 Write a query to display for each store its store ID, city, and country.
 SELECT 
	S.store_id AS "STORE ID",
    CI.city AS "CITY",
    CO.country AS "COUNTRY"
	FROM store S
JOIN address A ON S.address_id = A.address_id
JOIN city CI ON A.city_id = CI.city_id 
JOIN country CO ON CI.country_id = CO.country_id;


--2 Write a query to display how much business, in dollars, each store brought in.
SELECT 
	store AS "STORE",
	total_sales  AS "total_sales_in_USD" 
FROM sales_by_store
	
	
--3 What is the average running time of films by category?
SELECT 
category as Category,
ROUND(AVG("length"),0)  AS "Average_film_length"
FROM film_list
GROUP BY category;


-- 4 Which film categories are longest?
SELECT 
category as Category,
ROUND(AVG("length"),0) AS "Longest_category"
FROM film_list
GROUP BY category;
ORDER by "Longest_category" DESC;


-- 5 Display the most frequently rented movies in descending order.
SELECT 
F.title as TITLE,
COUNT(rental_id) AS rental_frecuency
FROM rental R
JOIN inventory I ON R.inventory_id = I.inventory_id
JOIN film F ON I.film_id = F.film_id
GROUP BY F.film_id
ORDER BY rental_frecuency DESC;


-- 6 List the top five genres in gross revenue in descending order.
SELECT 
c.name AS category, 
SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;


-- 7 Is "Academy Dinosaur" available for rent from Store 1?
SELECT
  CASE
    WHEN EXISTS (
      SELECT 1
      FROM inventory AS i
      JOIN film AS f ON i.film_id = f.film_id
      WHERE f.title = 'Academy Dinosaur'
        AND i.store_id = 1
        AND i.inventory_id NOT IN (
          SELECT inventory_id
          FROM rental
          WHERE return_date IS NULL
        )
    ) THEN 'Yes'
    ELSE 'No'
  END AS is_available;


