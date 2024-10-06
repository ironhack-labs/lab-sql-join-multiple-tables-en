-- Add you solution queries below:

USE sakila;

-- 1. Display for each store its store ID, city, and country.
SELECT 
    s.store_id, 
    c.city, 
    co.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city c ON a.city_id = c.city_id
JOIN 
    country co ON c.country_id = co.country_id;

-- 2. Display how much business, in dollars, each store brought in.
SELECT 
    s.store_id, 
    SUM(p.amount) AS total_revenue
FROM 
    store s
JOIN 
    inventory i ON s.store_id = i.store_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    s.store_id;

-- 3. What is the average running time of films by category?
SELECT 
    c.name AS category, 
    AVG(f.length) AS average_running_time
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name;

-- 4. Which film categories are longest?
SELECT 
    c.name AS category, 
    MAX(f.length) AS longest_running_time
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    longest_running_time DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT 
    f.title, 
    COUNT(r.rental_id) AS rental_count
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.title
ORDER BY 
    rental_count DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT 
    c.name AS category, 
    SUM(p.amount) AS total_revenue
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    c.name
ORDER BY 
    total_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    CASE 
        WHEN COUNT(i.inventory_id) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
WHERE 
    f.title = 'Academy Dinosaur' AND i.store_id = 1;