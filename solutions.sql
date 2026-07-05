SELECT s.store_id, ci.city, co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;
SELECT s.store_id, SUM(p.amount) AS revenue
FROM store AS s
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id;
SELECT c.name AS category, AVG(f.length) AS avg_length
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;
SELECT c.name AS category, AVG(f.length) AS avg_length
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC;
SELECT c.name AS category, SUM(p.amount) AS revenue
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5;
SELECT f.title, i.inventory_id, i.store_id,
       CASE 
           WHEN r.return_date IS NULL AND r.rental_id IS NOT NULL THEN 'Rented out'
           ELSE 'Available'
       END AS status
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
LEFT JOIN rental AS r 
    ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1;
