-- Add you solution queries below:
USE sakila;

-- #1 Write a query to display for each store its store ID, city, and country.

SELECT
store_id,
city,
country
FROM store
LEFT JOIN address on store.address_id = address.address_id
LEFT JOIN city on address.city_id = city.city_id
LEFT JOIN country on city.country_id = country.country_id;

-- #2 Write a query to display how much business, in dollars, each store brought in.

SELECT distinct
store.store_id AS "Store",
SUM(amount) AS "Business in $"
FROM store
LEFT JOIN
customer on store.store_id = customer.store_id
LEFT JOIN
payment on customer.customer_id = payment.customer_id
GROUP BY  store.store_id;

-- #3 What is the average running time of films by category?

SELECT
category.name,
avg(length)
FROM film
LEFT JOIN
film_category on film.film_id = film_category.film_id
LEFT JOIN
category on film_category.category_id = category.category_id
GROUP BY category.name;

-- #4 Which film categories are longest?

SELECT
category.name,
avg(length)
FROM film
LEFT JOIN
film_category on film.film_id = film_category.film_id
LEFT JOIN
category on film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY avg(length) DESC;

-- #5 Display the most frequently rented movies in descending order.

SELECT 
film.title,
count(rental.rental_id) AS "Number of rentals"
FROM film
LEFT JOIN
inventory on film.film_id = inventory.film_id
LEFT JOIN
rental on inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY count(rental.rental_id) DESC;

-- #6 List the top five genres in gross revenue in descending order.

SELECT
category.name,
SUM(payment.amount) AS "Business in $"
FROM category
INNER JOIN
film_category on category.category_id = film_category.category_id
INNER JOIN
inventory on film_category.film_id = inventory.film_id
INNER JOIN
rental on inventory.inventory_id = rental.inventory_id
INNER JOIN
payment on rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

-- #7 Is "Academy Dinosaur" available for rent from Store 1?

SELECT 
    f.title, 
    i.inventory_id, 
    s.store_id
FROM 
    film AS f
JOIN 
    inventory AS i ON f.film_id = i.film_id
JOIN 
    store AS s ON i.store_id = s.store_id
WHERE 
    f.title = 'Academy Dinosaur' 
    AND s.store_id = 1 
    AND i.inventory_id IS NOT NULL;  -- Ensures there is an inventory item available