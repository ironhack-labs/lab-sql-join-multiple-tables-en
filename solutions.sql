
-- Write a query to display for each store its store ID, city, and country.
SELECT  store.store_id,
city.city,
country.country
FROM city
JOIN country ON country.country_id = city.country_id
JOIN address ON address.city_id = city.city_id
JOIN store ON store.address_id=address.address_id

-- Write a query to display how much business, in dollars, each store brought in. ????
SELECT store.store_id,
sum(payment.amount)
FROM inventory
JOIN store ON store.store_id=inventory.store_id
JOIN rental ON rental.inventory_id=inventory.inventory_id
JOIN payment ON payment.rental_id=rental.rental_id
GROUP BY store.store_id 

-- What is the average running time (length) of films by category?
SELECT category.name, round(avg(film.length) , 2) as average_length_minutes
FROM film
JOIN film_category on film_category.film_id = film.film_id
JOIN category on category.category_id = film_category.category_id
GROUP BY film_category.category_id

-- Which film categories have the longest running time?
SELECT category.name, round(avg(film.length) , 2) as average_length_minutes
FROM film
JOIN film_category on film_category.film_id = film.film_id
JOIN category on category.category_id = film_category.category_id
GROUP BY film_category.category_id
ORDER BY average_length_minutes DESC
LIMIT 1

-- Display the most frequently rented movies in descending order.
SELECT film.title, count(rental.rental_id) as freq_rental
FROM rental
JOIN inventory on inventory.inventory_id = rental.inventory_id
JOIN film on film.film_id = inventory.film_id
GROUP BY film.film_id
ORDER BY freq_rental DESC

-- List the top five genres in gross revenue in descending order.
SELECT category.name, sum(payment.amount) as revenue
FROM payment
JOIN rental on rental.rental_id = payment.rental_id
JOIN inventory on inventory.inventory_id = rental.inventory_id
JOIN film_category on film_category.film_id = inventory.film_id
JOIN category on category.category_id = film_category.category_id
GROUP BY category.category_id
ORDER BY revenue  DESC
LIMIT 5

-- Is "Academy Dinosaur" available for rent from Store 1?
 SELECT 
	 film.title,
	 store.store_id,
	 inventory.inventory_id,
	 CASE
				WHEN rental.return_date NOT NULL THEN 1
				ELSE 0
	END AS IS_AVAILABLE
 FROM inventory
 JOIN store on store.store_id = inventory.store_id
 JOIN film on film.film_id = inventory.film_id
 JOIN rental on rental.inventory_id = inventory.inventory_id
WHERE store.store_id = 1 AND film.title = "ACADEMY DINOSAUR"
GROUP BY inventory.inventory_id
