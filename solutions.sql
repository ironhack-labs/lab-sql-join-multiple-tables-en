-- Add you solution queries below:

1. Write a query to display for each store its store ID, city, and country.

SELECT 
    s.store_id AS "Store ID",
    c.city AS "City",
    co.country AS "Country"
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

2. Write a query to display how much business, in dollars, each store brought in.

SELECT 
    s.store_id AS "Store ID",
    SUM(p.amount) AS "Total_Business"
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

3. What is the average running time of films by category?

SELECT 
    c.name AS category,
    AVG(f.length) AS "Average Runtime"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

4. Which film categories are longest?

SELECT 
    c.name AS category,
    AVG(f.length) AS "Average Runtime"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY "Average Runtime" DESC;

5. Display the most frequently rented movies in descending order.

SELECT 
    f.title AS "Movie Title",
    COUNT(r.rental_id) AS "Rental Count"
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY "Rental Count" DESC;

6. List the top five genres in gross revenue in descending order.

SELECT 
    c.name AS "Genre",
    SUM(p.amount) AS "Gross Revenue"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY "Gross Revenue" DESC
LIMIT 5;

7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT 
    f.title AS "Movie Title",
    i.store_id AS "Store Id"
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR'
AND i.store_id = 1;
