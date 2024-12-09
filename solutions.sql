-- Add you solution queries below:
use sakila;

-- Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, c.city, co.country
FROM store as s
JOIN address as a ON s.address_id = a.address_id
JOIN city as c ON c.city_id = a.city_id
JOIN country as co ON c.country_id = co.country_id;


-- Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, 
       SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN store s ON i.store_id = s.store_id
GROUP BY s.store_id;

-- What is the average running time of films by category?

SELECT c.name AS category, 
       AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

-- Which film categories are longest?

SELECT c.name AS category, 
       AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC
LIMIT 5;

-- Display the most frequently rented movies in descending order.

SELECT f.title, 
       COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10; -- Limit to top 10 most rented movies

-- Is "Academy Dinosaur" available for rent from Store 1?

SELECT f.title, i.store_id, i.inventory_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;

