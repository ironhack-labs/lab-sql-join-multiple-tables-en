--- Add you solution queries below:


--- 1. Write a query to display for each store its store ID, city, and country.
SELECT 
    s.store_id AS "STORE ID",
    c.city AS "CITY",
    co.country AS "country"
FROM store s
RIGHT JOIN address a ON s.address_id = a.address_id
RIGHT JOIN city c ON a.city_id = c.city_id
RIGHT JOIN country co ON c.country_id = co.country_id;
--- ORDER BY s.store_id DESC;


--- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT 
	s1.store_id AS "STORE ID",
	s2.first_name AS "FIRST NAME",
	s2.last_name AS "LAST NAME",
	s2.username AS "USER NAME",
	SUM(p.amount) AS "TOTAL INCOME"
FROM store s1
RIGHT JOIN staff s2 ON s1.store_id = s2.store_id
RIGHT JOIN payment p ON p.staff_id = s2.staff_id
GROUP BY s1.store_id;

--- 3. What is the average running time of films by category?
SELECT 
    c.name AS category,
    AVG(f.length) AS avg_length
FROM category c
RIGHT JOIN film_category fc ON c.category_id = fc.category_id
RIGHT JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_length;


--- 4. Which film categories are longest?
SELECT 
    c.name AS "THE_LONGEST_CATEGORY",
    AVG(f.length) AS "AVERAGE_RUNNING_TIME_OF_FILMS"
FROM category c
RIGHT JOIN film_category fc ON c.category_id = fc.category_id
RIGHT JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY AVERAGE_RUNNING_TIME_OF_FILMS DESC
LIMIT 1;

--- 5. Display the most frequently rented movies in descending order.
SELECT 
	f.title AS "FILM TITLE",
	c.name AS "CATEGORY NAME",
    COUNT(*) AS rental_count
FROM rental r
RIGHT JOIN inventory i ON r.inventory_id = i.inventory_id
RIGHT JOIN film f ON i.film_id = f.film_id
RIGHT JOIN film_category fc ON f.film_id = fc.film_id
RIGHT JOIN category c ON fc.category_id = c.category_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC;


--- 6. List the top five genres in gross revenue in descending order.
SELECT 
    c.name AS "CATEGORY NAME",
    SUM(p.amount) AS total_revenue
FROM payment p
RIGHT JOIN rental r ON p.rental_id = r.rental_id
RIGHT JOIN inventory i ON r.inventory_id = i.inventory_id
RIGHT JOIN film f ON i.film_id = f.film_id
RIGHT JOIN film_category fc ON f.film_id = fc.film_id
RIGHT JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY total_revenue DESC
LIMIT 5;


--- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    f.title,
    i.inventory_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1
  AND r.rental_id IS NULL;

