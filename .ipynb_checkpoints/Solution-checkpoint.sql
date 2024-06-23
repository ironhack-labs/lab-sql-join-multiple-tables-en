USE `sakila`

/// Q1 ///

SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

/// Q2 ///

SELECT 
    store.store_id, 
    CONCAT('$', ROUND(SUM(payment.amount), 2)) AS total_amount
FROM 
    store
JOIN 
    staff ON store.store_id = staff.store_id
JOIN 
    payment ON staff.staff_id = payment.staff_id
GROUP BY 
    store.store_id
ORDER BY 
    store.store_id;

/// Q3 ///

SELECT 
    category.name, 
    AVG(film.length) AS average_running_time
FROM 
    category
JOIN 
    film_category ON category.category_id = film_category.category_id
JOIN 
    film ON film_category.film_id = film.film_id
GROUP BY 
    category.name
ORDER BY 
    category.name;

/// Q4 ///

SELECT 
    category.name, 
    AVG(film.length) AS average_running_time
FROM 
    category
JOIN 
    film_category ON category.category_id = film_category.category_id
JOIN 
    film ON film_category.film_id = film.film_id
GROUP BY 
    category.name
HAVING 
    AVG(film.length) > (SELECT AVG(film.length) FROM film)
ORDER BY 
    category.name;

/// Q5 ///

SELECT 
    film.title, 
    COUNT(rental.rental_id) AS rental_count
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY 
    film.title
ORDER BY 
    rental_count DESC;

/// Q6 ///

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

/// Q7 ///

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