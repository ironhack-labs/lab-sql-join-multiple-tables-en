-- Add you solution queries below:
/*Write a query to display for each store its store ID, city, and country. */
SELECT 
    s.store_id AS "STORE ID", 
    ci.city AS "CITY", 
    co.country AS "COUNTRY"
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

/*Write a query to display how much business, in dollars, each store brought in. st - staff, py - payment*/
SELECT 
	s.store_id AS "STORE ID",
	st.staff_id AS "STAF ID",
	SUM(py.amount) AS "TOTAL PAYMENT"
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment py ON st.staff_id = py.staff_id
GROUP BY s.store_id
ORDER BY "TOTAL PAYMENT" DESC;

/* What is the average running time of films by category? */
SELECT 
    c.name AS "CATEGORY", 
    AVG(f.length) AS "AVERAGE RUNNING TIME"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;



/* Which film categories are longest? */
SELECT 
    c.name AS "CATEGORY", 
    AVG(f.length) AS "AVERAGE RUNNING TIME"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY "AVERAGE RUNNING TIME" DESC;

/* Display the most frequently rented movies in descending order. */
SELECT 
	f.title AS "FILM TITLE",
	COUNT(r.rental_id) AS "TOTAL"
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id,f.title
ORDER BY "TOTAL" DESC;

/* List the top five genres in gross revenue in descending order. */
SELECT 
    c.name AS "GENRE", 
    SUM(p.amount) AS "GROSS REVENUE"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY "GROSS REVENUE" DESC
LIMIT 5;
	
/* Is "Academy Dinosaur" available for rent from Store 1?*/
SELECT title, store_id, inventory_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = "Academy Dinosaur"
AND i.store_id = 1;

