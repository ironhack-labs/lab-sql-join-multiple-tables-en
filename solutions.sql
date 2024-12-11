-- Add you solution queries below:
-- 1. Write a query to display for each store its store ID, city, and country.
Use sakila;

SELECT S.store_id, c.city, co.country
FROM store as s
JOIN address as a ON s.address_id = a.address_id
JOIN city as c ON c.city_id = a.city_id
JOIN country as co ON c.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.

SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    payment p
JOIN 
    rental r ON p.rental_id = r.rental_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    store s ON i.store_id = s.store_id
GROUP BY 
    s.store_id
ORDER BY 
    total_revenue DESC;
    
  -- What is the average running time of films by category?
  SELECT c.name as category_name,
  AVG(f.length) AS avg_running_time
  FROM film f
  JOIN film_category fc
  ON fc.film_id = f.film_id
  JOIN category c
  ON c.category_id = fc.category_id
  GROUP BY c.name
  ORDER BY avg_running_time DESC;
  
  
  
  -- Which film categories are longest?
  SELECT c.name AS category_name,
  AVG(f.length) AS average_lenght
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  GROUP BY c.name
  ORDER BY average_lenght DESC;
  
-- Display the most frequently rented movies in descending order.
  SELECT f.title, COUNT(rental_id) AS num_rental
  FROM film as f
  JOIN inventory as i on f.film_id = i.film_id
  JOIN rental as r on r.inventory_id = i.inventory_id
  GROUP BY f.title
  ORDER BY num_rental DESC;
  
-- 6. List the top five genres in gross revenue in descending order.
SELECT c.name as genres, SUM(p.amount) as gross_revenue
FROM category as c 
JOIN film_category as fc on c.category_id = fc.category_id 
JOIN inventory as i on fc.film_id = i.film_id
JOIN rental as r on r.inventory_id = i.inventory_id
JOIN payment as p on p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT CASE
  WHEN COUNT(i.inventory_id) - COUNT(r.rental_id) > 0 THEN 'Available'
  ELSE 'Not Available'
END AS Availability_Flag
FROM inventory AS i
LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
Left JOIN film as f ON i.film_id = f.film_id 
WHERE i.store_id = 1
AND f.title = 'Academy Dinosaur';


  
  
  
  
  
  
  
  
  