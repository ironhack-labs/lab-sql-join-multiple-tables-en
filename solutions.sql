-- Add you solution queries below:
SELECT store.store_id, city.`city`, country.`country` FROM store
JOIN address ON address.address_id = store.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

SELECT s.store_id ,c.city||','||cy.country AS store, SUM(p.amount) AS total_sales FROM payment AS p
INNER JOIN rental AS r ON p.rental_id = r.rental_id
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN store AS s ON i.store_id = s.store_id
INNER JOIN address AS a ON s.address_id = a.address_id
INNER JOIN city AS c ON a.city_id = c.city_id
INNER JOIN country AS cy ON c.country_id = cy.country_id
INNER JOIN staff AS m ON s.manager_staff_id = m.staff_id
GROUP BY s.store_id , c.city||','||cy.country;

SELECT category.name, AVG(film.length)
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

SELECT category.name, SUM(film.length) AS "Longest film"
FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON category.category_id = film_category.category_id
GROUP by category.category_id
ORDER by "Longest film" DESC;

SELECT film.title AS "Film", COUNT(rental.rental_id) AS "Rental count"
FROM film
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
GROUP BY film.film_id, film.title
ORDER BY "Rental count" DESC
LIMIT 15;

--List the top five genres in gross revenue in descending order.
SELECT c.name AS category , SUM(p.amount) AS total_sales 
FROM payment AS p 
JOIN rental AS r ON p.rental_id = r.rental_id 
JOIN inventory AS i ON r.inventory_id = i.inventory_id 
JOIN film AS f ON i.film_id = f.film_id 
JOIN film_category AS fc ON f.film_id = fc.film_id 
JOIN category AS c ON fc.category_id = c.category_id 
GROUP BY c.name
ORDER by "total_sales" DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT film.title, count(inventory.inventory_id) AS "Copies", inventory.store_id AS "Store"
FROM film
JOIN inventory ON inventory.film_id = film.film_id
WHERE film.title LIKE"%Academy dinosaur%"
GROUP BY store_id
LIMIT 1;
