-- Add you solution queries below:
--Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

--Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, sbs.total_sales
from store s
JOIN sales_by_store sbs on s.store_id = sbs.store_id;

--What is the average running time of films by category?
SELECT c.name as Category, AVG(f.length) AS AVG_Running_Time
from category c
JOIN film f ON f.film_id = fc.film_id
JOIN film_category fc ON c.category_id = fc.category_id
GROUP by c.name
ORDER BY AVG_Running_Time DESC;

--Which film categories are longest?
SELECT c.name as Category, AVG(f.length) AS AVG_Running_Time
from category c
JOIN film f ON f.film_id = fc.film_id
JOIN film_category fc ON c.category_id = fc.category_id
GROUP by c.name
ORDER BY AVG_Running_Time DESC LIMIT 1;
--Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC;
--List the top five genres in gross revenue in descending order.
SELECT c.name AS category, SUM(p.amount) AS gross_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;
--Is "Academy Dinosaur" available for rent from Store 1?
SELECT COUNT(*) AS Availables
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1 AND i.inventory_id 
NOT IN (
      SELECT inventory_id 
      FROM rental 
      WHERE return_date IS NULL
  );