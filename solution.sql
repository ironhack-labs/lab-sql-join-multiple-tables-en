USE `sakila`

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, CONCAT('$', FORMAT(SUM(payment.amount), 2)) AS total_amount
FROM store
JOIN staff ON store.store_id = staff.store_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store.store_id;

-- 3. What is the average running time of films by category?

SELECT category.name, AVG(film.length) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name; 

-- 4. Which film categories are longest?

SELECT category.name, AVG(film.length) AS average_running_time
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
HAVING AVG(film.length) > (SELECT AVG(film.length) FROM film);

-- 5. Display the most frequently rented movies in descending order.

SELECT film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY rental_count DESC;

-- 6. List the top five genres in gross revenue in descending order.

SELECT category.name AS genre, CONCAT('$', FORMAT(SUM(payment.amount), 2)) AS gross_revenue
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT film.title, store.store_id, inventory.inventory_id
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN store ON inventory.store_id = store.store_id
WHERE film.title = 'Academy Dinosaur'
  AND store.store_id = 1
  AND inventory.inventory_id NOT IN (
    SELECT rental.inventory_id
    FROM rental
    WHERE rental.return_date IS NULL
  );

-- Extra: Return as True/False if the movie exists
SELECT IF(
  EXISTS (
    SELECT film.title, store.store_id, inventory.inventory_id
    FROM film
    JOIN inventory ON film.film_id = inventory.film_id
    JOIN store ON inventory.store_id = store.store_id
    WHERE film.title = 'Academy Dinosaur'
      AND store.store_id = 1
      AND inventory.inventory_id NOT IN (
        SELECT rental.inventory_id
        FROM rental
        WHERE rental.return_date IS NULL
      )
  ), 'True', 'False') AS is_available;