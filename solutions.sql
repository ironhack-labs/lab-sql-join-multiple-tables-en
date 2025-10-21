--Write a query to display for each store its store ID, city, and country.
SELECT 
	s.store_id AS "Store ID",
	c."city" AS "city",
	co."country" AS "country"

FROM store s

JOIN address a ON a.address_id = s.address_id
JOIN city c ON c.city_id = a.city_id
JOIN country co ON co.country_id = c.country_id;



--Write a query to display how much business, in dollars, each store brought in.
SELECT 
	s.store_id AS "store",
	SUM(p.amount) AS "income USD"

FROM store s

JOIN customer c ON c.store_id = s.store_id
JOIN payment p ON p.customer_id = c.customer_id

GROUP BY s.store_id
ORDER BY s.store_id;



--What is the average running time of films by category?
SELECT
	c.name AS "Category",
	ROUND(AVG(f.length),2) AS "Avg Length"

FROM category c

JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id

GROUP BY c.name
ORDER BY c.name;



--Which film categories are longest?
SELECT
	c.name AS "Category",
	ROUND(AVG(f.length),2) AS "Avg Length"
	
FROM category c

JOIN film_category fc ON fc.category_id = c.category_id
JOIN film f ON f.film_id = fc.film_id

GROUP BY c.name
ORDER BY "Avg Length" DESC;



--Display the most frequently rented movies in descending order.
SELECT
	f.title AS "Title",
	COUNT(r.rental_id) AS "Rentals"

	FROM rental r
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id

GROUP BY f.title
ORDER BY "Rentals" DESC, f.title;



--List the top five genres in gross revenue in descending order.
SELECT
	c.name AS "Category",
	ROUND(SUM(p.amount),2) AS "Gross Revenue"

FROM payment p

JOIN rental r ON r.rental_id = p.rental_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film_category fc ON fc.film_id = i.film_id
JOIN category c ON c.category_id = fc.category_id

GROUP BY c.name
ORDER BY "Gross Revenue" DESC
LIMIT 5;

--Is "Academy Dinosaur" available for rent from Store 1?
SELECT
	COUNT(*) AS total_copies,
	SUM(CASE WHEN r.rental_id IS NOT NULL AND r.return_date IS NULL THEN 1 ELSE 0 END) AS rented_out,
	COUNT(*) - SUM(CASE WHEN r.rental_id IS NOT NULL AND r.return_date IS NULL THEN 1 ELSE 0 END) AS available_copies
	
FROM inventory i

LEFT JOIN rental r ON r.inventory_id = i.inventory_id AND r.return_date IS NULL
JOIN film f ON f.film_id = i.film_id

WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1;