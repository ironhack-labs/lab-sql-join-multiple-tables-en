-- Query 1: Display for each store its store ID, city, and country
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- Query 2: Display how much business, in dollars, each store brought in
SELECT s.store_id, SUM(p.amount) AS total_business
FROM store s
JOIN inventory i ON s.store_id = i.store_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id;

-- Query 3: What is the average running time of films by category?
SELECT c.name AS category_name, AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Query 4: Which film categories are longest?
SELECT c.name AS category_name, AVG(f.length) AS avg_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

-- Query 5: Display the most frequently rented movies in descending order
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC;

-- Query 6: List the top five genres in gross revenue in descending order
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

-- Query 7: Is "Academy Dinosaur" available for rent from Store 1?
SELECT CASE 
            WHEN COUNT(i.inventory_id) > 0 THEN 'Yes' 
            ELSE 'No' 
       END AS is_available
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1
AND i.inventory_id NOT IN (SELECT r.inventory_id FROM rental r WHERE r.return_date IS NULL);
