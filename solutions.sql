-- Add you solution queries below:

--1. Display for each store its store ID, city, and country ---
SELECT s.store_id AS 'STORE ID', c.city AS 'city', coun.country AS 'country'
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON a.city_id = c.city_id
JOIN country AS coun ON c.country_id = coun.country_id;

--2. Display how much business, in dollars, each store brought in ---
SELECT s.store_id AS 'STORE ID', SUM(p.amount) AS 'business in dollars'
FROM store AS s
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

--3. Average running time of films by category ---
SELECT c.name AS 'category', AVG(f.length) AS 'avergae running time' 
FROM film as f 
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name;

--4. Which film categories are longest
SELECT c.name AS 'category', AVG(f.length) AS 'avergae running time' 
FROM film as f 
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC;

--5. Display the most frequently rented movies in descending order ---
SELECT f.title AS 'movie', COUNT(i.inventory_id) AS 'times rented'
FROM film as f
JOIN inventory as i ON f.film_id = i.film_id
JOIN rental as r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY COUNT(i.inventory_id) DESC;

--6. Top 5 genres in gross revenue in DESC order --
SELECT c.name AS 'genre', SUM(p.amount) AS 'gross revenue'
FROM film as f
JOIN film_category AS fc on f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
JOIN inventory as i ON f.film_id = i.film_id
JOIN rental as r ON i.inventory_id = r.inventory_id
JOIN payment as p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 7. Is Academy Dinosaur available from Store 1? -- 
SELECT *
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN store AS s ON i.store_id = s.store_id
WHERE f.film_id = 1 AND s.store_id = 1;
























