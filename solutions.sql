SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

SELECT 
    c.name AS category,
    AVG(f.length) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

SELECT 
    c.name AS category,
    AVG(f.length) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC;

SELECT 
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC;


SELECT 
    f.title,
    s.store_id,
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM inventory i
            LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
            WHERE i.film_id = f.film_id
              AND i.store_id = s.store_id
              AND r.rental_id IS NULL
        ) THEN 'Yes'
        ELSE 'No'
    END AS available
FROM film f
JOIN store s ON s.store_id = 1
WHERE f.title = 'Academy Dinosaur';