SELECT s.store_id,
		ci.city,
		co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city As ci on a.city_id = ci.city_id
JOIN country As co ON ci.country_id = co.country_id;

SELECT s.store_id,
		SUM(p.amount) As total_revenue
FROM payment AS p
Join staff AS st ON p.staff_id = st.staff_id
Join store As s ON st.store_id = s.store_id
GROUP BY s.store_id;

SELECT c.name AS category,
       AVG(f.length) AS avg_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time;

SELECT c.name AS category,
       AVG(f.length) AS avg_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

SELECT f.title,
	COUNT(r.rental_id) AS Number_rentals
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY Number_rentals DESC;

SELECT c.name AS category,
	SUM(p.amount) AS gross_revenue
From payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN film_category AS fc ON i.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
JOIN inventory As i ON r.inventory_id = i.inventory_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

SELECT * FROM rental
WHERE return_date IS NULL;

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


