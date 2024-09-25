-- SOLUTIONS.SQL --
-- Specify DATABASE -- 
USE sakila;

-- Write a query to display for each store its store ID, city, and country.--
SELECT
	store.store_id, city.city, country.country
    FROM sakila.store 
    INNER JOIN sakila.address 
		INNER JOIN sakila.city
			INNER JOIN sakila.country
			ON sakila.city.country_id = sakila.country.country_id
		ON sakila.address.city_id = sakila.city.city_id
    ON sakila.store.address_id = sakila.address.address_id;
	
-- Write a query to display how much business, in dollars, each store brought in.
SELECT 
	store.store_id, SUM(payment.amount)
	FROM sakila.store 
    INNER JOIN sakila.customer
		INNER JOIN sakila.payment
        ON sakila.customer.customer_id = sakila.payment.customer_id
	ON sakila.store.store_id = sakila.customer.store_id
GROUP BY store.store_id
ORDER BY SUM(payment.amount) desc;
           
    
-- What is the average running time of films by category? let's assume 'running time' means length
SELECT 
	category.name, AVG(film.length)
	FROM sakila.category
    INNER JOIN sakila.film_category
		INNER JOIN sakila.film
		ON sakila.film_category.film_id = sakila.film.film_id
    ON sakila.category.category_id = sakila.film_category.category_id
GROUP BY category.name
ORDER BY AVG(film.length) desc;

-- Which film categories are longest? let's print top 3 
SELECT 
	category.name, AVG(film.length)
	FROM sakila.category
    INNER JOIN sakila.film_category
		INNER JOIN sakila.film
		ON sakila.film_category.film_id = sakila.film.film_id
    ON sakila.category.category_id = sakila.film_category.category_id
GROUP BY category.name
ORDER BY AVG(film.length) desc
limit 3;

-- Display the most frequently rented movies in descending order.
SELECT 
	film.title, COUNT(rental.rental_id)
	FROM film 
    INNER JOIN sakila.inventory
		INNER JOIN sakila.rental
        ON sakila.inventory.inventory_id = sakila.rental.inventory_id
	ON sakila.film.film_id = sakila.inventory.film_id
GROUP BY film.title
ORDER BY COUNT(rental.rental_id) desc;

-- List the top five genres in gross revenue in descending order.
SELECT 
	category.name, SUM(payment.amount)
	FROM category 
    INNER JOIN film_category
		INNER JOIN film
			INNER JOIN inventory
				INNER JOIN rental
					INNER JOIN payment
					ON sakila.rental.rental_id = sakila.payment.rental_id
				ON sakila.inventory.inventory_id = sakila.rental.inventory_id
			ON sakila.film.film_id = sakila.inventory.film_id
		ON sakila.film_category.film_id = sakila.film.film_id
	ON sakila.category.category_id = sakila.film_category.category_id
GROUP BY category.name
ORDER BY SUM(payment.amount) desc;
                    
-- Is "Academy Dinosaur" available for rent from Store 1?

SELECT 
	film.title, store.store_id
    FROM film
    INNER JOIN inventory
    ON film.film_id = inventory.film_id
    INNER JOIN store
    ON inventory.store_id = store.store_id
WHERE film.title = "Academy Dinosaur" AND store.store_id = '1'
GROUP BY film.title;
    
    
	