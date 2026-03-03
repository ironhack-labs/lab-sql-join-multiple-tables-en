-- Write a query to display for each store its store ID, city, and country.
SELECT store.store_id AS 'store ID', city.city, country.country
FROM store
JOIN address ON store.address_id == address.address_id
JOIN city ON address.city_id == city.city_id
JOIN country ON city.country_id = country.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, SUM(payment.amount)
FROM store
JOIN inventory ON store.store_id = inventory.inventory_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY store.store_id;
 
-- What is the average running time of films by category?
SELECT category.name, ROUND(AVG(film.length), 2) AS 'Average length'
FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
GROUP BY category.category_id;

-- Which film categories are longest?
SELECT category.name, ROUND(AVG(film.length), 2) AS 'Average length'
FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
GROUP BY category.category_id
ORDER BY AVG(film.length) DESC
LIMIT 3;

-- Display the most frequently rented movies in descending order.
SELECT film.title, COUNT(*) 
FROM inventory
JOIN film ON film.film_id = inventory.film_id
GROUP BY inventory.film_id
ORDER BY COUNT(*) DESC;

-- List the top five genres in gross revenue in descending order.
SELECT category.name, SUM(payment.amount)
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film_category ON film_category.film_id = inventory.film_id
JOIN category ON category.category_id = film_category.category_id
GROUP BY category.category_id
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
	CASE
		WHEN EXISTS(
			SELECT 1 FROM inventory 
			JOIN film ON film.film_id = inventory.film_id
			WHERE film.title = "Academy Dinosaur"
				AND inventory.store_id = 1
				AND inventory.inventory_id NOT IN (
					SELECT inventory_id FROM rental WHERE return_date IS NULL
				)
		) THEN 'Yes'
		ELSE 'No'
END AS is_available