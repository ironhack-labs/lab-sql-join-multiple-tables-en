-- 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT sta.store_id AS STORE_ID, sum(p.amount) AS TOTAL_SALES
FROM payment AS p
JOIN staff AS sta ON p.staff_id = sta.staff_id
group by sta.store_id
order by sta.store_id;

-- 3. What is the average running time of films by category?
SELECT c.name, AVG(f.length) AS avg_running_time
FROM film as f
JOIN film_category AS fc ON fc.film_id = f.film_id
JOIN category AS c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

-- 4. Which film categories are longest? (return also the total count of movies per category and the averege running time per category)
SELECT c.name, sum(f.length) AS total_running_time, count(c.category_id) AS total_movies, AVG(f.length) AS avg_running_time
FROM film as f
JOIN film_category AS fc ON fc.film_id = f.film_id
JOIN category AS c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY total_running_time DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT f.title, count(f.title) AS total_rental_times
FROM rental as r
JOIN inventory AS i ON i.inventory_id = r.inventory_id
JOIN film AS f ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY total_rental_times DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT c.name, sum(f.rental_rate) AS gross_revenue
FROM rental as r
JOIN inventory AS i ON i.inventory_id = r.inventory_id
JOIN film AS f ON f.film_id = i.film_id
JOIN film_category AS fc ON fc.film_id = f.film_id
JOIN category AS c ON c.category_id = fc.category_id
GROUP BY c.category_id
ORDER BY gross_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT  f.title AS MOVIE_TITLE, 
	CASE
		WHEN count(*) - count(r.rental_id) = count(Distinct(i.inventory_id)) THEN "Not available in store 1"	-- count(*) will count all the rows -> count(columnname) will count without NULL values
		ELSE "available in store 1"
	END AS MESSAGE
FROM inventory AS i
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN film AS f ON f.film_id = i.film_id 
WHERE i.store_id == 1 AND f.title like "Academy Dinosaur";

