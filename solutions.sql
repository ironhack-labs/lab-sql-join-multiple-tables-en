-- Add you solution queries below:
-- 1.
SELECT 
    s.store_id AS "Store ID",
    c.city AS "City",
    co.country AS "Country"
FROM 
    store s
INNER JOIN 
    address a ON s.address_id = a.address_id
INNER JOIN 
    city c ON a.city_id = c.city_id
INNER JOIN 
    country co ON c.country_id = co.country_id;
    
-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT 
    s.store_id AS "Store ID",
    SUM(p.amount) AS "Total Sales ($)"
FROM 
    store s
INNER JOIN 
    staff st ON s.store_id = st.store_id
INNER JOIN 
    payment p ON st.staff_id = p.staff_id
GROUP BY 
    s.store_id
ORDER BY 
    "Total Sales ($)" DESC;
    
-- 3. What is the average running time of films by category?
SELECT
    category.name AS "Category",
    AVG(film.length) AS "Average Running Time"
FROM
    category
INNER JOIN
    film_category ON category.category_id = film_category.category_id
INNER JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    category.name
ORDER BY
    AVG(film.length) DESC;
    
-- 4. Which film categories are longest?
SELECT
	category.name AS "Category",
    AVG(film.length) AS "Average Run Time"
FROM
	category
INNER JOIN
	film_category ON category.category_id = film_category.category_id
INNER JOIN
	film ON film_category.film_id = film.film_id
GROUP BY
	category.name
ORDER BY
	AVG(film.length) DESC limit 5;
    
-- 5. Display the most frequently rented movies in descending order.
SELECT
	film.title AS "Movie title",
    COUNT(rental.rental_id) AS "Rentals"
FROM
	rental
INNER JOIN
	inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN
	film ON inventory.film_id = film.film_id
GROUP BY
	film.title
ORDER BY
	COUNT(rental.rental_id) DESC;
    
-- 6. List the top five genres in gross revenue in descending order.
SELECT 
    category.name AS "Category",
    SUM(payment.amount) AS "Total Revenue ($)"
FROM 
    payment
INNER JOIN 
    rental ON payment.rental_id = rental.rental_id
INNER JOIN 
    inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN 
    film ON inventory.film_id = film.film_id
INNER JOIN 
    film_category ON film.film_id = film_category.film_id
INNER JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name
ORDER BY 
    SUM(payment.amount) DESC limit 5;
    
-- 6. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
    f.title AS "Film Title",
    i.store_id AS "Store ID",
    IF(r.rental_id IS NULL, 'Available', 'Rented') AS "Availability"
FROM 
    film f
INNER JOIN 
    inventory i ON f.film_id = i.film_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE 
    f.title = 'Academy Dinosaur' 
    AND i.store_id = 1;



	
