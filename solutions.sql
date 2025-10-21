-- Challenge 1:
-- Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country 
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

-- Challenge 2:
-- Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) AS gross_revenue
FROM store AS s
JOIN inventory AS i ON s.store_id = i.store_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY gross_revenue DESC;

-- Challenge 3: 
-- What is the average running time of films by category?
SELECT c.name, AVG(f.length) AS avg_length 
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category as c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;

-- Challenge 4:
-- Which film categories are longest?
SELECT c.name, SUM(f.length) AS sum_length 
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category as c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY sum_length DESC
LIMIT 5;

-- Challenge 5: 
-- Display the most frequently rented movies in descending order.
SELECT f.title, SUM(r.inventory_id) AS freq_rent
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY freq_rent DESC
LIMIT 5;

-- Challenge 6: 
-- List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(p.amount) AS gross_revenue
FROM category AS c
JOIN film_category AS f ON c.category_id = f.category_id
JOIN inventory	AS i ON f.film_id = i.film_id 
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- Challenge 7:
-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, i.store_id, COUNT(i.inventory_id) AS avail_copie
FROM film_list AS f
JOIN inventory AS i ON f.FID = i.film_id
LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE f.title = "Academy Dinosaur" AND i.store_id = 1 AND r.return_date IS NOT NULL
GROUP BY f.title, i.store_id;
