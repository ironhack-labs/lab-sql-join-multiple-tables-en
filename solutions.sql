-- 1) Write a query to display for each store its store ID, city, and country.
SELECT st.store_id as "Store ID", ct.city as "City", cy.country as "Country"
FROM store AS st
LEFT JOIN address AS ad ON st.address_id = ad.address_id
LEFT JOIN city AS ct ON ad.city_id = ct.city_id
LEFT JOIN country AS cy ON ct.country_id = cy.country_id

-- 2) Write a query to display how much business, in dollars, each store brought in.
SELECT st.store_id as "Store ID", sum(py.amount) as "Business ($)" 
FROM payment AS py
LEFT JOIN staff AS sf ON sf.staff_id = py.staff_id
LEFT JOIN store AS st ON st.store_id = sf.store_id
GROUP BY "Store ID"

-- 3) What is the average running time of films by category?
SELECT avg(film.length) AS "Avg. Running Time", fcat.category_id AS "Category"
FROM film
LEFT JOIN film_category AS fcat ON fcat.film_id = film.film_id
GROUP BY fcat.category_id

-- 4) Which film categories are longest?
SELECT avg(film.length) AS "Avg. Running Time", fcat.category_id AS "Category"
FROM film
LEFT JOIN film_category AS fcat ON fcat.film_id = film.film_id
GROUP BY fcat.category_id ORDER BY "Avg. Running Time" DESC
-- Categories 15 (128.2 min), 10 (127.8 min) and 9 (121.7 min) are the longest on average.

-- 5) Display the most frequently rented movies in descending order.
SELECT count(re.rental_id) AS "# Rentals", film.film_id AS "Film ID"
FROM rental AS re
LEFT JOIN inventory AS inv ON inv.inventory_id = re.inventory_id
LEFT JOIN film ON film.film_id = inv.film_id
GROUP BY "Film ID"
ORDER BY "# Rentals" DESC LIMIT 20

-- 6) List the top five genres in gross revenue in descending order.
SELECT fcat.category_id AS "Genre", sum(py.amount) AS "Gross Revenue" 
FROM film_category AS fcat
LEFT JOIN inventory AS inv ON inv.film_id = fcat.film_id
LEFT JOIN rental AS re ON re.inventory_id = inv.inventory_id
LEFT JOIN payment AS py ON py.rental_id = re.rental_id
GROUP BY "Genre"
ORDER BY "Gross Revenue" DESC LIMIT 5

-- 7) Is "Academy Dinosaur" available for rent from Store 1?
SELECT film.title AS "Film Title" 
FROM film 
JOIN inventory AS inv ON inv.film_id = film.film_id
WHERE inv.store_id == 1