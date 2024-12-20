-- Active: 1734663846045@@127.0.0.1@3306@sakila

-- Write a query to display for each store its store ID, city, and country.
SELECT 
    s.store_id AS `Store ID`,
    c.city AS `City`,
    co.country AS `Country`
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city c ON a.city_id = c.city_id
JOIN 
    country co ON c.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT 
    s.store_id AS `Store ID`,
    SUM(p.amount) AS `Total Revenue`
FROM 
    payment p
JOIN 
    rental r ON p.rental_id = r.rental_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    store s ON i.store_id = s.store_id
GROUP BY 
    s.store_id
ORDER BY 
    `Total Revenue` DESC;


-- What is the average running time of films by category?
SELECT 
    c.name AS `Category`,
    AVG(f.length) AS `Average Running Time`
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    `Average Running Time` DESC;


-- Which film categories are longest?
SELECT 
    c.name AS `Category`,
    MAX(f.length) AS `Longest Running Time`
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    `Longest Running Time` DESC;


-- Display the most frequently rented movies in descending order.
SELECT 
    f.title AS `Movie Title`,
    COUNT(r.rental_id) AS `Times Rented`
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
GROUP BY 
    f.title
ORDER BY 
    `Times Rented` DESC;


-- List the top five genres in gross revenue in descending order.
SELECT 
    c.name AS `Genre`,
    SUM(p.amount) AS `Total Revenue`
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
    `Total Revenue` DESC
LIMIT 5;


-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    i.inventory_id,
    f.title AS `Film Title`,
    i.store_id AS `Store ID`,
    IF(r.rental_id IS NULL, 'Available', 'Rented') AS `Availability`
FROM 
    inventory i
JOIN 
    film f ON i.film_id = f.film_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE 
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1;

