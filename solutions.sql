-- 1. Write a query to display for each store its store ID, city, and country.
SELECT 
    s.store_id AS 'STORE ID', 
    c.city AS 'CITY', 
    co.country AS 'COUNTRY'
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT 
    s.store_id AS 'STORE ID', 
    SUM(pay.amount) AS 'TOTAL REVENUE'
FROM store s
JOIN staff st ON s.store_id = st.store_id 
JOIN payment pay ON st.staff_id = pay.staff_id
GROUP BY 1;

-- 3. What is the average running time of films by category?
SELECT
	cat.name AS 'CATEGORY',
	ROUND(AVG(f.length), 2) AS 'AVERAGE RUNNING TIME'
FROM category cat
JOIN film_category fc ON cat.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY 1 ORDER BY 2 DESC;

-- 4. Which film categories are longest?
SELECT
	cat.name AS 'CATEGORY',
	SUM(f.length) AS 'TOTAL MOVIES TIME'
FROM category cat
JOIN film_category fc ON cat.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY 1 ORDER BY 2 DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT 
    f.title AS 'FILM TITLE', 
    COUNT(r.rental_id) AS 'RENTAL COUNT'
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY 2 DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT 
    c.name AS 'CATEGORY', 
    SUM(p.amount) AS 'TOTAL REVENUE'
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    f.title AS 'Movie',
    COUNT(i.inventory_id) AS 'Available for rent'
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE f.title = 'ACADEMY DINOSAUR' 
AND i.store_id = 1
AND r.rental_id IS NULL;
