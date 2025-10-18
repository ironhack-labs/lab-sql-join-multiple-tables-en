-- Add you solution queries below:
SELECT 
    s.store_id, 
    c.city, 
    co.country
FROM 
    store AS s
JOIN 
    address AS a ON s.address_id = a.address_id
JOIN 
    city AS c ON a.city_id = c.city_id
JOIN 
    country AS co ON c.country_id = co.country_id
ORDER BY 
    s.store_id;


SELECT s.store_id, SUM(p.amount) AS total_sales
from payment AS p
JOIN staff as st ON p.staff_id = st.staff_id
JOIN store as s ON st.store_id = s.store_id
GROUP BY 
    s.store_id
ORDER BY 
    total_sales DESC;

SELECT 
    fc.category_id,  
    AVG(f.length) AS average
FROM 
    film_category AS fc
JOIN 
    film AS f ON fc.film_id = f.film_id
GROUP BY 
    fc.category_id
ORDER BY 
    average DESC;


SELECT 
    c.name AS category_name,
    MAX(f.length) AS max_length
FROM 
    film_category AS fc
JOIN 
    film AS f ON fc.film_id = f.film_id
JOIN 
    category AS c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    max_length DESC;

SELECT
    f.title AS name,  sum( r.rental_id) AS time_rented
FROM 
    rental as r 
JOIN 
    inventory AS i ON i.inventory_id = r.inventory_id
JOIN 
    film  AS f ON f.film_id = i.film_id
GROUP BY 
    f.title 
ORDER BY 
    time_rented DESC;

SELECT c.name, sum(p.amount) as revenue
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON  i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY 
	c.name
ORDER BY
	revenue DESC
LIMIT 5l;

SELECT f.title
FROM store AS s
JOIN inventory AS i ON s.store_id = i.store_id
JOIN film AS f ON f.film_id = i.film_id
WHERE s.store_id = 1
  AND f.title = 'ACADEMY DINOSAUR';




