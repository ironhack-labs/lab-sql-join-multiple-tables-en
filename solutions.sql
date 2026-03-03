-- Add you solution queries below:
SELECT 
    s.store_id AS "STORE ID",
    ci.city AS "CITY",
    co.country AS "COUNTRY"
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

SELECT 
    s.store_id AS "STORE ID",
    SUM(p.amount) AS "TOTAL BUSINESS ($)"
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

SELECT 
    c.name AS "CATEGORY",
    AVG(f.length) AS "AVERAGE RUNNING TIME"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY "AVERAGE RUNNING TIME" DESC;

SELECT 
    c.name AS "CATEGORY",
    AVG(f.length) AS "AVERAGE RUNNING TIME"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC;

SELECT 
    f.title AS "TITLE",
    COUNT(r.rental_id) AS "TIMES RENTED"
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY "TIMES RENTED" DESC;

SELECT 
    c.name AS "CATEGORY",
    SUM(p.amount) AS "GROSS REVENUE"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY "GROSS REVENUE" DESC
LIMIT 5;

SELECT 
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS "COPIES AVAILABLE"
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id 
    AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1
  AND r.rental_id IS NULL;
