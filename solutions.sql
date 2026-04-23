-- Add you solution queries below:
-- 1 - Write a query to display for each store its store ID, city, and country.

SELECT store_id, city, country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 2 - Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, '$' || SUM(payment.amount)
FROM store 
JOIN staff
ON store.store_id = staff.store_id
JOIN payment
ON staff.staff_id = payment.staff_id

GROUP BY store.store_id;

-- 3 - What is the average running time of films by category?

SELECT category.name, AVG(length) AS "Average Length"
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id

GROUP BY category.name;



-- 4 Which film categories are longest?


SELECT category.name, AVG(length) AS "Average Length"
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id

GROUP BY category.name

ORDER BY AVG(length) DESC;

-- 5 - Display the most frequently rented movies in descending order.

SELECT film.title, COUNT(rental.rental_id) AS "Rentals"
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id

GROUP BY film.film_id, film.title

ORDER BY "Rentals" DESC;


-- 6 - List the top five genres in gross revenue in descending order.

SELECT category.name, SUM(payment.amount) 
FROM category
JOIN film_category
ON category.category_id = film_category.category_id
JOIN film
ON film_category.film_id = film.film_id
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
JOIN payment 
ON rental.rental_id = payment.rental_id

GROUP BY category.name

ORDER BY SUM(payment.amount) DESC

LIMIT 5;


-- 7 - Is "Academy Dinosaur" available for rent from Store 1?

SELECT film.title, inventory.store_id,rental.return_date 
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id
WHERE film.title = 'ACADEMY DINOSAUR'
AND inventory.store_id = 1;
