-- Add you solution queries below:
USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, c.city, co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON c.city_id = a.city_id
JOIN country AS co ON co.country_id = c.country_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN store AS s ON i.store_id = s.store_id
GROUP BY s.store_id;


-- 3. What is the average running time of films by category?

SELECT c.name, ROUND(AVG(f.length), 2) AS average_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON c.category_id = fc.category_id
GROUP BY c.name;


-- 4. Which film categories are longest?

SELECT c.name, MAX(f.length) AS longest_running_time
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY longest_running_time DESC;

-- 5. Display the most frequently rented movies in descending order.

SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

-- 6. List the top five genres in gross revenue in descending order.

SELECT c.name AS category_name, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT COUNT(*) > 0 AS is_available
FROM inventory i
JOIN film f ON i.film_id = f.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1 AND r.inventory_id IS NULL;