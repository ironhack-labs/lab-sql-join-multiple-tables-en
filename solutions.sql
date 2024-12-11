-- Add you solution queries below:
use sakila;

-- Write a query to display for each store its store ID, city and country.
select s.store_id, c.city, country
from store as s join address as a on s.address_id = a.address_id
join city as c on a.city_id=c.city_id
join country as co on c.country_id=co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) AS total_business_in_dollars
FROM store s JOIN staff st ON s.store_id = st.store_id
JOIN rental r ON st.staff_id = r.staff_id JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id;

-- What is the average running time of films by category?
SELECT c.name AS category, AVG(f.length) AS average_running_time
FROM film f JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

-- Which film categories are longest?
SELECT c.name AS category, AVG(f.length) AS average_running_time
FROM film f JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id GROUP BY c.name
ORDER BY average_running_time DESC;

-- Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id GROUP BY f.film_id
ORDER BY rental_count DESC;

-- List the top five genres in gross revenue in descending order.
SELECT c.name AS genre, SUM(p.amount) AS total_revenue
FROM category c JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name ORDER BY total_revenue DESC LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT i.inventory_id
FROM inventory i JOIN film f ON i.film_id = f.film_id
JOIN store s ON i.store_id = s.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1;
