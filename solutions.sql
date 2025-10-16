-- Add you solution queries below:

SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a ON a.address_id = s.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;


SELECT s.store_id, SUM(p.amount) AS "Total"
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;


SELECT name AS "Category", AVG(f.length) AS "AVG_Length"
FROM category ca
JOIN film_category fc ON ca.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY ca.name;


SELECT name AS "Category", AVG(f.length) AS "AVG_Length"
FROM category ca
JOIN film_category fc ON ca.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY ca.name
ORDER BY AVG_Length DESC;


SELECT f.title, COUNT(r.rental_id) AS "No_of_Rentals"
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY No_of_Rentals DESC;


SELECT name AS "Category", SUM(p.amount) AS "Total"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
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