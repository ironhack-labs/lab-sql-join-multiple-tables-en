use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city, co.country
FROM store as s
JOIN address as a ON s.address_id = a.address_id
JOIN city as c on c.city_id = a.city_id
JOIN country as co ON c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT c.store_id, SUM(p.amount) as TOTAL_Dollars
FROM customer as c
JOIN payment AS p ON p.customer_id = c.customer_id
GROUP BY c.store_id, p.amount; 

-- 3. What is the average running time of films by category?
SELECT fc.category_id, AVG(f.length) as Av_Time
FROM film_category as fc
join film as f ON f.film_id = fc.film_id
GROUP BY fc.category_id, f.length;


-- 4. Which film categories are longest?
SELECT fc.category_id, max(f.length)
FROM film_category as fc
join film as f ON f.film_id = fc.film_id
GROUP BY fc.category_id, f.length
ORDER BY f.length DESC;


-- 5. Display the most frequently rented movies in descending order.
SELECT film_id, SUM(rental_duration)
FROM film
GROUP BY film_id, rental_duration
ORDER BY rental_duration DESC;



-- 6.  List the top five genres in gross revenue in descending order.
SELECT fc.category_id, SUM(p.amount)
FROM payment as p
JOIN rental as r ON r.rental_id = p.rental.id
JOIN inventory as i On i.inventory_id = r.inventory_id
JOIN film_category as fc On fc.film_id = i.film_id;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT ft.title, i.last_update
FROM filme_text as ft
JOIN inventory as i ON i.film_id = ft.film_id
WHERE ft.filme = "Academy Dinosaur" and i.store_id = 1;


