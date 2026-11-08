-- Add you solution queries below:

-- 1. Store ID, city and country of each store
SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a  ON s.address_id = a.address_id
JOIN city c     ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

-- 2. Business (in dollars) brought in by each store
SELECT i.store_id, SUM(p.amount) AS total_business
FROM payment p
JOIN rental r    ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY i.store_id;

-- 3. Average running time of films by category
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;

-- 4. Longest film categories (highest average running time first)
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 5;

-- 5. Most frequently rented movies, in descending order
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f      ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC, f.title ASC;

-- 6. Top five genres by gross revenue, in descending order
SELECT c.name AS genre, SUM(p.amount) AS gross_revenue
FROM payment p
JOIN rental r         ON p.rental_id = r.rental_id
JOIN inventory i      ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
-- A copy is available if it has no open rental (return_date IS NULL)
SELECT i.inventory_id,
       CASE WHEN EXISTS (SELECT 1 FROM rental r
                         WHERE r.inventory_id = i.inventory_id
                           AND r.return_date IS NULL)
            THEN 'rented out' ELSE 'available' END AS status
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1;
