SELECT c.name AS category, MAX(f.length) AS max_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY max_length DESC;
