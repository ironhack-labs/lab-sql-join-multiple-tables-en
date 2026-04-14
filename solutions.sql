--Question 1

SELECT 
    s.store_id,
    c.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

--Question 2

SELECT 
    s.store_id,
    SUM(p.amount) AS total_sales
FROM store s
JOIN inventory i ON s.store_id = i.store_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY total_sales DESC;

--Question 3

SELECT 
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_running_time DESC;

--Question 4

SELECT 
    c.name,
    AVG(f.length) AS average_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_length DESC
LIMIT 5;

--Question 5

SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

--Question 6

SELECT 
    c.name AS genre,
    SUM(p.amount) AS Gross_Revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY Gross_Revenue DESC
LIMIT 5;

--Question 7

SELECT 
    f.title,
    s.store_id,
    CASE 
        WHEN COUNT(*) > 0 THEN 'Film Available'
        ELSE 'Film Not Available'
    END AS Availability
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id 
    AND r.return_date IS NULL
WHERE f.title = "ACADEMY DINOSAUR"
  AND s.store_id = 1
GROUP BY f.title, s.store_id;
