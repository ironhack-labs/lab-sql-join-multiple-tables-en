-- Select the Sakila database to ensure all queries run within the correct schema.
USE sakila;

-- Task 1: Write a query to display for each store its store ID, city, and country.
-- This query joins the store, address, city, and country tables to display the required information.
SELECT 
    s.store_id,
    ci.city AS city_name,
    co.country AS country_name
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- Task 2: Write a query to display how much business, in dollars, each store brought in.
-- This query calculates the total revenue for each store by joining payment, rental, inventory, and store tables.
SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

-- Task 3: What is the average running time of films by category?
-- This query calculates the average running time of films grouped by category.
SELECT 
    c.name AS category_name,
    AVG(f.length) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

-- Task 4: Which film categories are longest?
-- This query identifies the longest film categories by their average running time.
SELECT 
    c.name AS category_name,
    AVG(f.length) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 1;

-- Task 5: Display the most frequently rented movies in descending order.
-- This query lists movies and their rental counts, sorted by the number of rentals in descending order.
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

-- Task 6: List the top five genres in gross revenue in descending order.
-- This query calculates the total revenue for each genre by summing payment amounts and orders by gross revenue.
SELECT 
    c.name AS genre,
    SUM(p.amount) AS gross_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- Task 7: Is "Academy Dinosaur" available for rent from Store 1?
-- This query checks the availability of the specified film at Store 1 by excluding currently rented copies.
SELECT 
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1
AND i.inventory_id NOT IN (
    SELECT r.inventory_id
    FROM rental r
    WHERE r.return_date IS NULL
)
GROUP BY f.title, i.store_id;
