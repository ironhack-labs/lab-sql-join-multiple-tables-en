-- 1.Write a query to display for each store its store ID, city, and country.
SELECT s.store_id AS "STORE ID", ci.city AS "CITY", co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

-- 2.Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id AS "STORE ID", SUM(p.amount) AS "REVENUE"
FROM store AS s
JOIN staff AS sf ON s.store_id = sf.store_id
JOIN payment AS p ON sf.staff_id = p.staff_id
GROUP BY s.store_id;

-- 3.What is the average running time of films by category?
SELECT c.name AS "CATEGORY", AVG(f.length) AS "AVERAGE RUNNING TIME"
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY category;

-- 4.Which film categories are longest?
SELECT c.name AS "CATEGORY", AVG(f.length) AS "AVERAGE RUNNING TIME"
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY category
ORDER BY AVG(f.length) DESC
LIMIT 5;

-- 5.Display the most frequently rented movies in descending order.
SELECT f.title AS "MOVIES", COUNT(r.rental_id) AS "TOTAL RENTS"
FROM film AS f
JOIN inventory as i ON f.film_id = i.film_id
JOIN rental as r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC
LIMIT 10;

-- 6.List the top five genres in gross revenue in descending order.
SELECT c.name AS "MOVIE GENRES", SUM(p.amount) AS "GROSS REVENUE"
FROM category as c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN inventory AS i ON fc.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 7.Is "Academy Dinosaur" available for rent from Store 1?
SELECT
CASE
WHEN EXISTS (
SELECT 1
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id
WHERE f.title = "Academy Dinosaur"
AND i.store_id = 1
AND i.inventory_id NOT IN (
SELECT inventory_id FROM rental WHERE return_date IS NULL
)
) THEN "Yes"
ELSE "No"
END AS is_available;