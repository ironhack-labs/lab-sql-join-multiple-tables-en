-- ══════════════════════════════════════════════════════════════
-- 1. Each store's ID, city, and country
-- ══════════════════════════════════════════════════════════════
SELECT
    s.store_id,
    ci.city,
    co.country
FROM store s
JOIN address a  ON s.address_id  = a.address_id
JOIN city    ci ON a.city_id     = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- ══════════════════════════════════════════════════════════════
-- 2. Total business in dollars per store
-- ══════════════════════════════════════════════════════════════
SELECT
    s.store_id,
    SUM(p.amount)  AS "TOTAL REVENUE"
FROM store s
JOIN staff    st ON s.store_id    = st.store_id
JOIN payment  p  ON st.staff_id   = p.staff_id
GROUP BY s.store_id
ORDER BY "TOTAL REVENUE" DESC;

-- ══════════════════════════════════════════════════════════════
-- 3. Average running time of films by category
-- ══════════════════════════════════════════════════════════════
SELECT
    c.name                        AS "CATEGORY",
    ROUND(AVG(f.length), 2)       AS "AVG RUNNING TIME (min)"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film          f  ON fc.film_id    = f.film_id
GROUP BY c.name
ORDER BY "AVG RUNNING TIME (min)" DESC;

-- ══════════════════════════════════════════════════════════════
-- 4. Which film categories are longest?
-- ══════════════════════════════════════════════════════════════
SELECT
    c.name                        AS "CATEGORY",
    ROUND(AVG(f.length), 2)       AS "AVG RUNNING TIME (min)"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film          f  ON fc.film_id    = f.film_id
GROUP BY c.name
ORDER BY "AVG RUNNING TIME (min)" DESC
LIMIT 5;

-- ══════════════════════════════════════════════════════════════
-- 5. Most frequently rented movies in descending order
-- ══════════════════════════════════════════════════════════════
SELECT
    f.title                       AS "TITLE",
    COUNT(r.rental_id)            AS "TIMES RENTED"
FROM film f
JOIN inventory i ON f.film_id    = i.film_id
JOIN rental    r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY "TIMES RENTED" DESC;

-- ══════════════════════════════════════════════════════════════
-- 6. Top 5 genres in gross revenue in descending order
-- ══════════════════════════════════════════════════════════════
SELECT
    c.name                        AS "GENRE",
    SUM(p.amount)                 AS "GROSS REVENUE"
FROM category c
JOIN film_category fc ON c.category_id  = fc.category_id
JOIN film          f  ON fc.film_id     = f.film_id
JOIN inventory     i  ON f.film_id      = i.film_id
JOIN rental        r  ON i.inventory_id = r.inventory_id
JOIN payment       p  ON r.rental_id    = p.rental_id
GROUP BY c.name
ORDER BY "GROSS REVENUE" DESC
LIMIT 5;


-- ══════════════════════════════════════════════════════════════
-- 7. Is "Academy Dinosaur" available for rent from Store 1?
-- ══════════════════════════════════════════════════════════════
SELECT
    f.title                       AS "FILM",
    s.store_id                    AS "STORE",
    COUNT(i.inventory_id)         AS "TOTAL COPIES",
    SUM(CASE
            WHEN r.return_date IS NOT NULL
              OR r.rental_id    IS NULL     THEN 1
            ELSE 0
        END)                      AS "COPIES AVAILABLE"
FROM film f
JOIN inventory i  ON f.film_id      = i.film_id
JOIN store     s  ON i.store_id     = s.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL         -- currently rented out
WHERE f.title    = 'Academy Dinosaur'
  AND s.store_id = 1
GROUP BY f.title, s.store_id;

 
