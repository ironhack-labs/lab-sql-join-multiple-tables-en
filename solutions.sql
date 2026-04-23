-- Add you solution queries below:
--Write a query to display for each store its store ID, city, and country
SELECT 
	store.address_id AS "Store ID",
	city.city AS "city",
	country.country AS "country"
FROM store
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country ON city.country_id = country.country_id
GROUP BY store.store_id, city.city, country.country;

--Write a query to display how much business, in dollars, each store brought in.
SELECT
	store.store_id as "Store ID",
	SUM(payment.amount) AS "Business in $"
FROM store
JOIN customer USING (store_id)
JOIN payment USING (customer_id)
GROUP BY store_id;

--What is the average running time of films by category?
SELECT 
	DISTINCT category.name AS "Category",
	AVG(film.length) as "Length"
FROM category
JOIN film_category USING (category_id)
JOIN film USING (film_id);

--Which film categories are longest?
SELECT 
	category.name AS "Category",
	film.length as "Length"
FROM category
JOIN film_category USING (category_id)
JOIN film USING (film_id)
WHERE length > 120
GROUP BY name
ORDER BY length DESC
LIMIT 10;

--Display the most frequently rented movies in descending order.
SELECT 
	film.title as "Movie",
	COUNT(rental_id) as "x times rented"
FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
GROUP BY film_id
ORDER BY COUNT(rental_id) DESC
LIMIT 50;

--List the top five genres in gross revenue in descending order.
SELECT 
	category.name AS "Genre",
	SUM(payment.amount) AS "Gross Revenue"
FROM category
JOIN film_category USING (category_id)
JOIN film USING (film_id)
JOIN inventory USING (film_id)
JOIN rental using (inventory_id)
JOIN payment USING (customer_id)
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

--Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
	inventory.store_id AS "Store",
	film.title AS "title",
	COUNT(inventory.inventory_id) AS "Inventory"
FROM film
JOIN inventory USING (film_id)
WHERE film.title = 'Academy Dinosaur'
GROUP BY inventory.store_id, film.title;




