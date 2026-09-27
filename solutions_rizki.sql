SELECT
    s.store_id AS "STORE ID",
    ci.city    AS "CITY",
    co.country AS "COUNTRY"
FROM store s
JOIN address a  ON s.address_id = a.address_id
JOIN city ci    ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

SELECT
    st.store_id   AS "STORE ID",
    SUM(p.amount) AS "REVENUE"
FROM payment p
JOIN staff s  ON p.staff_id = s.staff_id
JOIN store st ON s.store_id = st.store_id
GROUP BY st.store_id;

SELECT
    c.name        AS "CATEGORY",
    AVG(f.length) AS "AVG RUNNING TIME"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c        ON fc.category_id = c.category_id
GROUP BY c.name;

SELECT
    c.name        AS "CATEGORY",
    AVG(f.length) AS "AVG RUNNING TIME"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c        ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY "AVG RUNNING TIME" DESC;

SELECT
    f.title            AS "TITLE",
    COUNT(r.rental_id) AS "TIMES RENTED"
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f      ON i.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY "TIMES RENTED" DESC;

SELECT
    c.name        AS "GENRE",
    SUM(p.amount) AS "REVENUE"
FROM payment p
JOIN rental r        ON p.rental_id = r.rental_id
JOIN inventory i      ON r.inventory_id = i.inventory_id
JOIN film_category fc ON i.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY "REVENUE" DESC
LIMIT 5;

SELECT
    i.inventory_id AS "INVENTORY ID",
    i.store_id     AS "STORE ID",
    CASE WHEN r.rental_id IS NULL THEN 'Available' ELSE 'Rented out' END AS "STATUS"
FROM inventory i
JOIN film f ON i.film_id = f.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE UPPER(f.title) = UPPER('Academy Dinosaur') AND i.store_id = 1;