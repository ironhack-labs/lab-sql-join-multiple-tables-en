USE Sakila;
#1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

#2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, 
       SUM(p.amount) AS total_revenue
FROM store s
JOIN staff st ON s.manager_staff_id = st.staff_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

#3. What is the average running time of films by category?
SELECT c.name AS category_name,
       AVG(f.length) AS average_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

#4. Which film categories are longest?
SELECT c.name AS category_name,
       AVG(f.length) AS average_running_time
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY average_running_time DESC;

#5. Display the most frequently rented movies in descending order.
SELECT f.title AS movie_title,
       COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

#6. List the top five genres in gross revenue in descending order.
SELECT c.name AS genre,
       SUM(p.amount) AS gross_revenue
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    COUNT(*) AS available_copies
FROM 
    inventory inv
JOIN 
    film fil ON inv.film_id = fil.film_id
JOIN 
    store sto ON inv.store_id = sto.store_id
LEFT JOIN 
    rental ren ON inv.inventory_id = ren.inventory_id AND ren.return_date IS NULL
WHERE 
    fil.title = 'Academy Dinosaur'
    AND sto.store_id = 1
    AND ren.rental_id IS NULL;
