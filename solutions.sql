-- Add you solution queries below:
use sakila;

-- Write a query to display for each store its store ID, city, and country.
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id;

-- ANOT
-- Write a query to display how much business, in dollars, each store brought in. (revenue)

SELECT 
    st.staff_id, 
    st.store_id, 
    SUM(p.amount) AS total_revenue
FROM 
    staff st
JOIN 
    payment p ON st.staff_id = p.staff_id
JOIN 
    store s ON st.store_id = s.store_id
GROUP BY 
    st.staff_id, st.store_id
ORDER BY 
    total_revenue DESC;

-- What is the average running time of films by category?

SELECT 
    c.name AS category,
    AVG(f.length) AS average_running_time
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    average_running_time DESC;

-- Which film categories are longest?
SELECT 
    c.name AS category,
    MAX(f.length) AS longest_running_time
FROM 
    category c
JOIN 
    film_category fc ON c.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    c.name
ORDER BY 
    longest_running_time DESC
LIMIT 1;


-- Display the most frequently rented movies in descending order.
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
GROUP BY 
    f.title
ORDER BY 
    rental_count DESC;


-- List the top five genres in gross revenue in descending order.
SELECT 
    c.name AS category,
    SUM(p.amount) AS gross_revenue
FROM 
    payment p
JOIN 
    rental r ON p.rental_id = r.rental_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film_category fc ON i.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    gross_revenue DESC
LIMIT 5;


-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    f.title, 
    s.store_id, 
    i.inventory_id
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    store s ON i.store_id = s.store_id
WHERE 
    f.title = 'Academy Dinosaur' AND s.store_id = 1;

