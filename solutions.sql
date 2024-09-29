USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, city.city, country.country
FROM store
INNER JOIN address
ON store.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
;


-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, SUM(payment.amount)
FROM payment
INNER JOIN rental
ON payment.rental_id = rental.rental_id
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN store
ON inventory.store_id = store.store_id
GROUP BY store.store_id
;


-- 3. What is the average running time of films by category?
SELECT category.name, AVG(film.length)
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY AVG(film.length) DESC
;


-- 4. Which film categories are longest?
SELECT category.name, SUM(film.length)
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY SUM(film.length) DESC
;


-- 5. Display the most frequently rented movies in descending order.
SELECT film.title, COUNT(rental.rental_id)
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY COUNT(rental.rental_id) DESC
;


-- 6. List the top five genres in gross revenue in descending order.
SELECT category.name, SUM(amount)
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN inventory
ON film_category.film_id = inventory.film_id
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY SUM(amount) DESC
LIMIT 5
;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    CASE 
        WHEN rental.inventory_id IS NULL THEN 'Available'
        ELSE 'Rented'
    END AS Availability
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
LEFT JOIN rental
ON inventory.inventory_id = rental.inventory_id AND rental.return_date IS NULL
WHERE film.title = "Academy Dinosaur" AND inventory.store_id = 1
;