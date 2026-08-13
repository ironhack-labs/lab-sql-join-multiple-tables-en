-- Add you solution queries below:

-- ==========================================================
-- 1. Display for each store its store ID, city, and country.
-- ==========================================================
SELECT
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci    ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


-- ==========================================================
-- 2. How much business, in dollars, did each store bring in?
--
-- "Business brought in" = total payments collected by the staff
-- working at each store.
-- ==========================================================
SELECT
    st.store_id,
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
GROUP BY st.store_id
ORDER BY total_revenue DESC;


-- ==========================================================
-- 3. What is the average running time of films by category?
-- ==========================================================
SELECT
    c.name AS category,
    AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c        ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;


-- ==========================================================
-- 4. Which film categories are longest? (same metric as above,
--    explicitly sorted so the longest-running categories are first)
-- ==========================================================
SELECT
    c.name AS category,
    AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c        ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;


-- ==========================================================
-- 5. Display the most frequently rented movies in descending order.
-- ==========================================================
SELECT
    f.title,
    COUNT(r.rental_id) AS times_rented
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f       ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY times_rented DESC;


-- ==========================================================
-- 6. List the top five genres in gross revenue in descending order.
-- ==========================================================
SELECT
    c.name AS genre,
    SUM(p.amount) AS gross_revenue
FROM payment p
JOIN rental r      ON p.rental_id = r.rental_id
JOIN inventory i   ON r.inventory_id = i.inventory_id
JOIN film f        ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c    ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;


-- ==========================================================
-- 7. Is "Academy Dinosaur" available for rent from Store 1?
--
-- A copy is "available" if it exists in Store 1's inventory and is
-- not currently checked out (i.e. it has no open rental -- a rental
-- row with return_date IS NULL).
-- ==========================================================
SELECT
    i.inventory_id
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1
  AND i.inventory_id NOT IN (
      SELECT inventory_id
      FROM rental
      WHERE return_date IS NULL
  );

-- If this query returns at least one row, "Academy Dinosaur" is
-- available for rent from Store 1. If it returns zero rows, every
-- copy at that store is currently checked out (or the store has no
-- copies of the film at all).
