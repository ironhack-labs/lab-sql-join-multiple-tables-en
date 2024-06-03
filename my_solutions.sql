USE sakila;

--  Display for each store its store ID, city, and country --
SELECT 
s.store_id, c.city, co.country
FROM store s
JOIN 
address a ON s.address_id = a.address_id
JOIN 
city c ON a.city_id = c.city_id
JOIN 
country co ON c.country_id = co.country_id;

-- Display how much business, in dollars, each store brought in --
SELECT 
s.store_id, 
CONCAT('$', FORMAT(SUM(p.amount), 2)) AS total_revenue
FROM payment p
JOIN 
rental r ON p.rental_id = r.rental_id
JOIN 
inventory i ON r.inventory_id = i.inventory_id
JOIN 
store s ON i.store_id = s.store_id
GROUP BY s.store_id;


-- average running time of films by category --
SELECT 
c.name AS category, AVG(f.length) AS average_length
FROM film f
JOIN 
film_category fc ON f.film_id = fc.film_id
JOIN 
category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Longest film categories --
SELECT 
c.name AS category, AVG(f.length) AS average_length
FROM film f
JOIN 
film_category fc ON f.film_id = fc.film_id
JOIN 
category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_length DESC;

-- Most frequently rented movies, DESC order --
SELECT 
f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN 
inventory i ON f.film_id = i.film_id
JOIN 
rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

-- Top 5 genres in gross revenue, DESC order --
SELECT 
c.name AS category, SUM(p.amount) AS total_revenue
FROM payment p
JOIN 
rental r ON p.rental_id = r.rental_id
JOIN 
inventory i ON r.inventory_id = i.inventory_id
JOIN 
film_category fc ON i.film_id = fc.film_id
JOIN 
category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1? --
SELECT 
f.title, i.store_id, i.inventory_id
FROM film f
JOIN 
inventory i ON f.film_id = i.film_id
WHERE 
f.title = 'Academy Dinosaur' AND i.store_id = 1
AND i.inventory_id NOT IN (
SELECT r.inventory_id
FROM rental r
WHERE r.return_date IS NULL
);



