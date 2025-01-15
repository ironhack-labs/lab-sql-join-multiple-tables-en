-- Add you solution queries below:
USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city ci
ON a.city_id = ci.city_id
JOIN country co
ON ci.country_id = co.country_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) business
FROM store s
JOIN customer c
ON s.store_id = c.store_id
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY s.store_id;

-- 3. What is the average running time of films by category?
SELECT 	c.name, AVG(length) avg_len
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name;


-- 4. Which film categories are longest?
SELECT 	c.name, AVG(length) avg_len
FROM film f
JOIN film_category fc
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_len DESC
LIMIT 5;


-- 5. Display the most frequently rented movies in descending order.
SELECT title, rental_date
FROM rental r
JOIN inventory i
ON r.inventory_id = i.inventory_id
JOIN film f
ON i.film_id = f.film_id
ORDER BY rental_date DESC
LIMIT 5;


-- 6. List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(p.amount) revenue
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN payment p
ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT r.return_date
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE f.title = "Academy Dinosaur"
ORDER BY rental_id DESC
LIMIT 1;

