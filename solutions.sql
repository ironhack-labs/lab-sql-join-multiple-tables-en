-- Add you solution queries below:

-- 1. Write a query to display for each store its store ID, city, and country.
-- SELECT store_id FROM store;  -- OK, there are really just two stores :D

SELECT s.store_id, c.city, c2.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country c2 ON c.country_id = c2.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) AS total_amount
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
JOIN store s ON c.store_id = s.store_id
GROUP BY s.store_id
ORDER BY total_amount DESC;


SELECT s.store_id, SUM(p.amount) AS total_amount
FROM store s
JOIN customer c ON c.store_id = s.store_id
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY s.store_id
ORDER BY total_amount DESC;


-- 3. What is the average running time of films by category?
SELECT c.name,ROUND(AVG(f.`length`),3) AS average_length
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY average_length DESC;



-- 4. Which film categories are longest? 
-- the question is ambiguous
-- here the answer for the film categories that contain the longest films
SELECT c.name,ROUND(MAX(f.`length`),3) AS max_length
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY max_length DESC;
-- interestingly, all categories contain films with long runtimes, with the maximum of several categories at 185min and the remainder not far behind

-- an alternative answer to the question was already provided in my prompt for 3, which orders the average lengths per category
SELECT c.name,ROUND(AVG(f.`length`),3) AS average_length
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY average_length DESC;
-- here we see that categories Sports and Games have the longest average runtimes



-- 5. Display the most frequently rented movies in descending order.
SELECT f.title,COUNT(rental_id) AS num_rentals
FROM film f 
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY num_rentals DESC;



-- 6. List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(p.amount) AS gross_revenue
FROM category c 
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON i.film_id =f.film_id
JOIN rental r ON r.inventory_id =i.inventory_id
JOIN payment p ON r.rental_id  = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;



-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT f.title,
 CASE
  WHEN EXISTS (
   SELECT 1
   FROM inventory AS i
   JOIN film AS f ON i.film_id = f.film_id
   WHERE f.title = 'Academy Dinosaur'
    AND i.store_id = 1
    AND i.inventory_id NOT IN (
     SELECT inventory_id FROM rental WHERE return_date IS NULL
    )
  ) THEN 'Yes'
 ELSE 'No'
END AS is_available
FROM film f
WHERE f.title = 'ACADEMY DINOSAUR';