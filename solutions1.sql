/*
1. Write a query to display for each store its store ID, city, and country.
2. Write a query to display how much business, in dollars, each store brought in.
3. What is the average running time of films by category?
4. Which film categories are longest?
5. Display the most frequently rented movies in descending order.
6. List the top five genres in gross revenue in descending order.
7. Is "Academy Dinosaur" available for rent from Store 1?
*/

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT
	s.store_id,
	ci.city,
	co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT
	s.store_id,
	SUM(p.amount) AS total_revenue
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id;

-- 3. What is the average running time of films by category?

SELECT 
	cat.name AS category,
	AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name;

-- 4. Which film categories are longest?

SELECT 
	cat.name AS category,
	AVG (f.length) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
GROUP BY cat.name
ORDER BY avg_length DESC;

-- 5. Display the most frequently rented movies in descending order.

SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

-- 6. List the top five genres in gross revenue in descending order.

SELECT
    cat.name AS category,
    SUM(p.amount) AS revenue
FROM category cat
JOIN film_category fc ON cat.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY cat.name
ORDER BY revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1
GROUP BY f.title, i.store_id;

/*
SELECT
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i 
    ON f.film_id = i.film_id
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL
WHERE UPPER(f.title) = 'ACADEMY DINOSAUR'
  AND i.store_id = 1
  AND r.rental_id IS NULL
GROUP BY f.title, i.store_id;
*/


