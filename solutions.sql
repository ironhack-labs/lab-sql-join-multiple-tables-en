-- Query 1
-- Write a query to display for each store its store ID, city, and country.
SELECT s.store_id AS Store, ci.city AS City, c.country AS Country
FROM store AS s
JOIN address AS a ON a.address_id = s.address_id
JOIN city AS ci ON ci.city_id = a.city_id
JOIN country AS c ON ci.country_id = c.country_id;

-- Query 2
-- Write a query to display how much business, in dollars, each store brought in.
SELECT store_id, total_sales
FROM sales_by_store;

-- Query 3
-- What is the average running time of films by category?
SELECT c.name AS Category, AVG(f.length) AS AVG_Run_Time
FROM film AS f
JOIN category AS c ON c.category_id = fc.category_id
JOIN film_category AS fc ON f.film_id = fc.film_id
GROUP BY c.name;

-- Query 4
-- Which film categories are longest?
SELECT c.name AS Category, max(f.length) AS AVG_Run_Time
FROM film AS f
JOIN category AS c ON c.category_id = fc.category_id
JOIN film_category AS fc ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY max(f.length) DESC;

-- Query 5
-- Display the most frequently rented movies in descending order.
SELECT f.title AS Movie, COUNT(i.inventory_id) AS times_rented
FROM film AS f
JOIN inventory AS i ON i.film_id = f.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY COUNT(i.inventory_id) DESC
LIMIT 10;

-- Query 6
-- List the top five genres in gross revenue in descending order.
SELECT category AS Genre, total_sales AS Gross_Revenue
FROM sales_by_film_category
ORDER BY total_sales DESC
LIMIT 5;

-- Query 7
-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    CASE 
        WHEN COUNT(*) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS availability_status
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1 AND r.rental_id IS NULL;

