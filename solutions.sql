-- ============================================================
-- Lab | SQL Joins on multiple tables — Sakila Database
-- ============================================================

-- 1. Display for each store its store ID, city, and country
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


-- 2. How much business, in dollars, each store brought in
SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;


-- 3. Average running time of films by category
SELECT 
    c.name AS category,
    AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;


-- 4. Which film categories are the longest (by total or average length)
-- Using average length, reusing the logic from query 3, ordered to show the longest first
SELECT 
    c.name AS category,
    AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 5;


-- 5. Most frequently rented movies, in descending order
SELECT 
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY times_rented DESC;


-- 6. Top five genres in gross revenue, in descending order
SELECT 
    c.name AS category,
    SUM(p.amount) AS gross_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
-- Checks inventory copies at Store 1 and whether each copy is currently out (not yet returned)
SELECT 
    f.title,
    i.inventory_id,
    i.store_id,
    CASE 
        WHEN r.return_date IS NULL AND r.rental_id IS NOT NULL THEN 'Rented out'
        ELSE 'Available'
    END AS availability_status
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE UPPER(f.title) = UPPER('Academy Dinosaur')
  AND i.store_id = 1;