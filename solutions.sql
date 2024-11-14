-- 1. Write a query to display for each store its store ID, city, and country.
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

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT 
    p.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    payment p
GROUP BY 
    p.store_id;

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
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
GROUP BY 
    f.title
ORDER BY 
    rental_count DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT 
    c.name AS genre,
    SUM(p.amount) AS gross_revenue
FROM 
    payment p
JOIN 
    rental r ON p.rental_id = r.rental_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    gross_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    f.title,
    CASE 
        WHEN i.inventory_id IS NOT NULL THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id AND i.store_id = 1
WHERE 
    f.title = 'Academy Dinosaur';
