USE sakila;

/*Write a query to display for each store its store ID, city, and country.*/
SELECT store_id, city.city AS city, country.country AS country
FROM (store INNER JOIN address 
ON store.address_id = address.address_id)
INNER JOIN city 
ON address.city_id = city.city_id
INNER JOIN country 
ON city.country_id = country.country_id;

/*Write a query to display how much business, in dollars, each store brought in.*/


SELECT store.store_id, SUM(payment.amount) AS $MONEY
FROM store INNER JOIN staff
ON store.manager_staff_id = staff.staff_id
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY store_id;

/*What is the average running time of films by category?*/

SELECT AVG(film.length) AS 'running time', category.name
FROM film INNER JOIN film_category
ON film.film_id = film_category.category_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name;

/*Which film categories are longest?*/

SELECT AVG(film.length) AS average, category.name
FROM film INNER JOIN film_category
ON film.film_id = film_category.category_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY AVG(film.length) DESC LIMIT 1;

/*Display the most frequently rented movies in descending order.*/

SELECT film.film_id, film.title, COUNT(rental.rental_id) AS rental_count
FROM film INNER JOIN inventory
ON film.film_id = inventory.film_id
INNER JOIN rental 
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, film.title
ORDER BY rental_count DESC;

/*Display the most frequently rented movies in descending order.*/   /*payment amount*/

SELECT category.name, SUM(film.rental_rate)
FROM rental INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
INNER JOIN film_category
ON film.film_id = film_category.category_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY SUM(film.rental_rate) DESC
LIMIT 5;

/*Is "Academy Dinosaur" available for rent from Store 1?*/
SELECT store.store_id
CASE WHERE film.title = "Academy Dinosaur"
