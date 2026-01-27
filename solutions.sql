-- Add you solution queries below:

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country
FROM store as s
JOIN address as ad ON s.address_id = ad.address_id
JOIN city AS ci ON ad.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT stf.store_id, sum(p.amount) AS total
FROM staff AS stf
JOIN payment AS p ON stf.staff_id = p.staff_id
GROUP BY stf.store_id;

-- 3. What is the average running time of films by category?
SELECT c.name as category, ROUND(AVG(f.rental_duration), 2) AS "avg duration"
FROM category as c
JOIN film_category as fc ON c.category_id = fc.category_id
JOIN film as f ON fc.film_id = f.film_id
GROUP BY c.name;

-- 4.Which film categories are longest?
SELECT c.name as category, SUM(f.length) AS "SUM length"
FROM category as c
JOIN film_category as fc ON c.category_id = fc.category_id
JOIN film as f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY "SUM length" DESC;

-- 5.Display the most frequently rented movies in descending order.
SELECT f.title, count(r.rental_id) as frequency
FROM film AS f
JOIN inventory AS i ON i.film_id = f.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY frequency DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT c.name as category, sum(p.amount) as revenue
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN inventory AS i ON fc.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment as p ON r.rental_id = p.rental_id
GROUP BY category
ORDER BY revenue DESC
LIMIT 5;

-- 7.Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title,
	CASE
		WHEN i.store_id == 1 THEN "YES"
		ELSE "NO"
	END AS avaiability
FROM film as f
JOIN inventory AS i ON i.film_id = f.film_id
GROUP BY f.title
HAVING f.title == "ACADEMY DINOSAUR"
	
		




