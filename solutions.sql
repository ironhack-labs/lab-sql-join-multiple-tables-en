-- + =====================================================
--   Lab | SQL Joins on multiple tables
-- + =====================================================
USE sakila;

-- + -----------------------------------------------------
-- 1. Write a query to display for each store its store ID, 
--    city, and country.
-- + -----------------------------------------------------
SELECT s.store_id, c.city, co.country
FROM store AS s
JOIN address AS a ON a.address_id = s.address_id
JOIN city AS c ON a.city_id = c.city_id
JOIN country AS co ON co.country_id = c.country_id;

-- + -----------------------------------------------------
-- 2. Write a query to display how much business, 
--    in dollars, each store brought in.
-- + -----------------------------------------------------
SELECT s.store_id, sum(p.amount)
FROM store AS s
JOIN customer AS c ON s.store_id = c.store_id
JOIN payment AS p ON p.customer_id = c.customer_id
GROUP BY s.store_id;

-- + -----------------------------------------------------
--  3. What is the average running time of films by category?
-- + -----------------------------------------------------
SELECT c.name, AVG(f.release_year) AS release_avg
FROM category as c
JOIN film_category AS fc ON fc.category_id = c.category_id
JOIN film AS f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY c.name;

-- + -----------------------------------------------------
-- 4. Which film categories are longest?
-- + -----------------------------------------------------
SELECT c.name, AVG(f.length) AS length_avg
FROM category as c
JOIN film_category AS fc ON fc.category_id = c.category_id
JOIN film AS f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY length_avg DESC;

-- + -----------------------------------------------------
-- 5. Display the most frequently rented movies in descending order.
-- + -----------------------------------------------------
SELECT c.name, SUM(f.rental_duration) AS duration_sum
FROM category as c
JOIN film_category AS fc ON fc.category_id = c.category_id
JOIN film AS f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY duration_sum DESC;

-- + -----------------------------------------------------
-- 6. List the top five genres in gross revenue in descending order.
-- + -----------------------------------------------------
SELECT c.name, SUM(p.amount) AS gross_revenue
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film_category AS fc ON fc.film_id = i.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- + -----------------------------------------------------
-- 7. Is "Academy Dinosaur" available for rent from Store 1?
-- + -----------------------------------------------------
SELECT i.store_id, f.title
FROM film_text AS f
JOIN inventory AS i ON i.film_id = f.film_id
WHERE f.title = "Academy Dinosaur" AND i.store_id = 1; 




