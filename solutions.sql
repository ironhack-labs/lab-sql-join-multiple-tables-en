use sakila;

-- 1 
SELECT 
    store.store_id,
    city.city AS city_name,
    country.country AS country_name
FROM 
    store
JOIN 
    address ON store.address_id = address.address_id
JOIN 
    city ON address.city_id = city.city_id
JOIN 
    country ON city.country_id = country.country_id;
    
    
-- 2 Write a query to display how much business, in dollars, each store brought in.
SELECT
    store.store_id,
    SUM(payment.amount) AS total_revenue
FROM
    store
JOIN
    staff ON store.store_id = staff.store_id
JOIN
    payment ON staff.staff_id = payment.staff_id
GROUP BY
    store.store_id;
    
-- 3 What is the average running time of films by category?
Select 
	film_category.category_id,
    avg(length) as average__time
FROM
    film_category 
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    film_category.category_id
order by average__time desc;
    
-- 4 Which film categories are longest?
Select 
	film_category.category_id,
    avg(length) as average__time
FROM
    film_category 
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    film_category.category_id
order by average__time desc
Limit 1;

-- 5 Display the most frequently rented movies in descending order.
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

-- 6 List the top five genres in gross revenue in descending order.
SELECT 
    category.name AS genre,
    SUM(payment.amount) AS total_revenue
FROM 
    category
JOIN 
    film_category ON category.category_id = film_category.category_id
JOIN 
    inventory ON film_category.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
JOIN 
    payment ON rental.rental_id = payment.rental_id
GROUP BY 
    category.name
ORDER BY 
    total_revenue DESC
LIMIT 
    5;


-- 7 Is "Academy Dinosaur" available for rent from Store 1?

SELECT 
    COUNT(inventory.inventory_id) AS available_copies
FROM 
    film
JOIN 
    inventory ON film.film_id = inventory.film_id
WHERE 
    film.title = 'Academy Dinosaur' AND
    inventory.store_id = 1 AND
    inventory.inventory_id NOT IN (
        SELECT rental.inventory_id
        FROM rental
        WHERE rental.return_date IS NULL
    );



  
    
    




