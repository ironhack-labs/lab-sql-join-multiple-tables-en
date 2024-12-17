-- Add you solution queries below:
/* Write a query to display for each store its store ID, city, and country. */
SELECT 
    st.store_id AS STORE_ID,
    ci.city AS CITY,
    co.country AS COUNTRY
FROM sakila.store AS st
JOIN sakila.address AS ad ON st.address_id = ad.address_id  
JOIN sakila.city AS ci ON ad.city_id = ci.city_id          
JOIN sakila.country AS co ON ci.country_id = co.country_id;

/* Write a query to display how much business, in dollars, each store brought in. */
SELECT 
    s.store_id,
    SUM(p.amount) AS total_sales
FROM sakila.store s
JOIN sakila.inventory i ON s.store_id = i.store_id
JOIN sakila.rental r ON i.inventory_id = r.inventory_id
JOIN sakila.payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY total_sales;

/* What is the average running time of films by category? */
SELECT 
    c.category_id AS CATEGORY_ID,
    c.name AS CATEGORY_NAME,
    AVG(f.length) AS AVERAGE_RUNNING_TIME
FROM sakila.film f
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY AVERAGE_RUNNING_TIME DESC;
    
/* Which film categories are longest? */
SELECT 
    c.name AS CATEGORY_NAME,
    MAX(f.length) AS MAX_LENGTH
FROM sakila.film f
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY MAX_LENGTH DESC;

/* Display the most frequently rented movies in descending order. */
SELECT 
    f.title AS MOVIE_TITLE,
    COUNT(r.rental_id) AS RENTAL_COUNT
FROM sakila.rental r
JOIN sakila.inventory i ON r.inventory_id = i.inventory_id  
JOIN sakila.film f ON i.film_id = f.film_id               
GROUP BY f.title                                           
ORDER BY RENTAL_COUNT DESC;

/* List the top five genres in gross revenue in descending order. */
SELECT 
    c.name AS CATEGORY_NAME,
    SUM(p.amount) AS GROSS_REVENUE
FROM sakila.payment p
JOIN sakila.rental r ON p.rental_id = r.rental_id            
JOIN sakila.inventory i ON r.inventory_id = i.inventory_id   
JOIN sakila.film f ON i.film_id = f.film_id                 
JOIN sakila.film_category fc ON f.film_id = fc.film_id       
JOIN sakila.category c ON fc.category_id = c.category_id     
GROUP BY c.name                                            
ORDER BY GROSS_REVENUE DESC                                 
LIMIT 5;                                                    

/* Is "Academy Dinosaur" available for rent from Store 1? */
SELECT 
    i.inventory_id,
    f.title AS FILM_TITLE,
    i.store_id,
    CASE 
        WHEN r.rental_id IS NULL THEN 'Available'
        ELSE 'Rented'
    END AS AVAILABILITY
FROM sakila.inventory i
JOIN sakila.film f ON i.film_id = f.film_id              
LEFT JOIN sakila.rental r ON i.inventory_id = r.inventory_id 
                      AND r.return_date IS NULL         
WHERE f.title = 'Academy Dinosaur' 
  AND i.store_id = 1                                
ORDER BY i.inventory_id;