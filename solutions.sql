-- Add you solution queries below:
-- 1. Store ID, city and country for each store
SELECT
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a  ON s.address_id  = a.address_id
JOIN city ci    ON a.city_id     = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 2. Revenue brought in by each store
SELECT
    st.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
GROUP BY st.store_id
ORDER BY total_revenue DESC;

-- 3. Average running time of films by category
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f           ON fc.film_id    = f.film_id
GROUP BY c.name
ORDER BY avg_length DESC;

--4. Which film categories are longest?
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f           ON fc.film_id    = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > (SELECT AVG(length) FROM film)
ORDER BY avg_length DESC;

-- 5. Most frequently rented movies, in descending order
SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id      = i.film_id
JOIN rental r    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC, f.title ASC;

-- 6. Top five genres by gross revenue
SELECT
    c.name AS category,
    ROUND(SUM(p.amount), 2) AS gross_revenue
FROM category c
JOIN film_category fc ON c.category_id  = fc.category_id
JOIN inventory i      ON fc.film_id     = i.film_id
JOIN rental r         ON i.inventory_id = r.inventory_id
JOIN payment p        ON r.rental_id    = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT
    COUNT(i.inventory_id)                      AS copies_in_store,
    COUNT(i.inventory_id) - COUNT(r.rental_id) AS copies_available
FROM film f
JOIN inventory i   ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
                  AND r.return_date IS NULL
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1;
