--- QUERY 1---
SELECT
    s.store_id,
    c.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

--- QUERY 2---
SELECT
    st.store_id,
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN staff s ON p.staff_id = s.staff_id
JOIN store st ON s.store_id = st.store_id
GROUP BY st.store_id;

--- QUERY 3---
SELECT
    c.name AS category,
    AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

--- QUERY 4---
SELECT
    c.name AS category,
    AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

--- QUERY 5---
SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

---QUERY 6---
SELECT
    c.name AS genre,
    SUM(p.amount) AS gross_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

--- QUERY 7---
SELECT
    COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1
  AND r.rental_id IS NULL;

