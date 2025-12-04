-----  ----  Store ID, City, and Country

SELECT
    s.store_id AS "STORE ID",
    c.city AS "CITY",
    co.country AS "COUNTRY"
FROM store s
JOIN address a
    ON s.address_id = a.address_id
JOIN city c
    ON a.city_id = c.city_id
JOIN country co
    ON c.country_id = co.country_id;

	
	-------    -----  Total Revenue per Store
	SELECT
    s.store_id AS "STORE ID",
    SUM(p.amount) AS "TOTAL REVENUE"
FROM store s
JOIN inventory i
    ON s.store_id = i.store_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY
    s.store_id
ORDER BY
    "TOTAL REVENUE" DESC;

	
	
------- ---- Average Running time

SELECT
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
GROUP BY
    c.name
ORDER BY
    average_running_time DESC;


--------- ------	Categories with the Highest Average Film Length

SELECT
    c.name AS category,
    AVG(f.length) AS average_length
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
GROUP BY
    c.name
ORDER BY
    average_length DESC;
	
--------- ------   Most Frequently Rented Movies
SELECT 
    f.title AS film_title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    rental_count DESC;

----------- --------------  Top 5 Genres by Gross Revenue

SELECT
    c.name AS genre,
    SUM(p.amount) AS gross_revenue
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY
    c.category_id, c.name
ORDER BY
    gross_revenue DESC
LIMIT 5;
  
  
 -------- --- -------- Checking if "Academy Dinosaur" Is Available at Store 1
SELECT 
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS copies_available
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1
GROUP BY 
    f.title, i.store_id;

	
-----  Academy Dinosaur is not available
	

	