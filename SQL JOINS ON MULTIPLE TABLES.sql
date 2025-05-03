SELECT COUNT(*) > 0 AS available
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;
