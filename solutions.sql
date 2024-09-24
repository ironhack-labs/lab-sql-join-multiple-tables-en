USE sakila;


SELECT s.store_id, 
       ci.city, 
       co.country 
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


SELECT s.store_id,
       SUM(p.amount) AS total_revenue
FROM store s
JOIN inventory i ON s.store_id = i.store_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id;


SELECT c.name AS category, 
       AVG(f.rental_duration) AS average_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;


SELECT c.name AS category,
       AVG(f.rental_duration) AS average_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC;


SELECT f.title, 
       COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;


SELECT c.name AS category, 
       SUM(p.amount) AS total_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;


SELECT CASE 
           WHEN COUNT(i.inventory_id) > 0 THEN 'Yes' 
           ELSE 'No' 
       END AS available
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;