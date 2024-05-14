USE sakila;

/* Query 1*/
SELECT store.store_id, city.city, country.country
FROM store INNER JOIN address
	ON store.address_id = address.address_id
    INNER JOIN city
    on address.city_id = city.city_id
    INNER JOIN country
    on city.country_id = country.country_id;
    

/* Query 2*/
SELECT store.store_id, SUM(payment.amount)
FROM store INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY store.store_id
ORDER BY SUM(payment.amount);


/* Query 3*/
SELECT category.name, AVG(film.length) AS average 
FROM sakila.film INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY average DESC;


/* Query 4*/
SELECT category.name, AVG(film.length) AS average_lenght
FROM sakila.film INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY average_lenght DESC
LIMIT 1;


/* Query 5*/
SELECT film.title, COUNT(rental_id) AS Count_rented
FROM film INNER JOIN inventory
ON film.film_id = inventory.film_id
INNER JOIN  rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY Count_rented DESC;


/* Query 6*/
SELECT category.name, SUM(film.rental_rate) AS Revenue
FROM rental INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY Revenue DESC
LIMIT 5;


/* Query 7*/
SELECT f.title AS film_title, s.store_id, i.inventory_id,
    CASE
        WHEN r.rental_id IS NULL THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM
    film f
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    store s ON i.store_id = s.store_id
LEFT JOIN
    rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE
    f.title = 'Academy Dinosaur'
    AND s.store_id = 1;






