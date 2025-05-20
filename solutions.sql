SELECT s.store_id, c.city, co.country
FROM store as s
JOIN address as a ON s.address_id = a.address_id
JOIN city as c ON a.city_id = c.city_id
JOIN country as co ON c.country_id = co.country_id;

SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM store AS s
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

SELECT cat.name AS category, AVG(f.length) AS average_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS cat ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY average_running_time DESC;

SELECT cat.name AS category, AVG(f.length) AS average_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS cat ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY average_running_time DESC;

SELECT f.title AS film_title, COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

SELECT c.name AS genre, SUM(p.amount) AS gross_revenue
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

SELECT f.title, s.store_id, COUNT(i.inventory_id) AS available_copies
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN store AS s ON i.store_id = s.store_id
LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE f.title = 'ACADEMY DINOSAUR' AND s.store_id = 1
GROUP BY f.title, s.store_id
HAVING COUNT(r.rental_id) IS NULL OR COUNT(r.rental_id) < COUNT(i.inventory_id); 

SELECT
    CASE WHEN COUNT(i.inventory_id) > 0 THEN 'Yes' ELSE 'No' END AS is_available
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1 AND NOT EXISTS (
        SELECT 1
        FROM rental AS r
        WHERE r.inventory_id = i.inventory_id AND r.return_date IS NULL
    );
