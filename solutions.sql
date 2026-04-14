-- Query  1 - Write a query to display for each store its store ID, city, and country.

SELECT s.store_id AS "STORE ID" , c.city AS "CITY" , co.country AS "COUNTRY"
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON a.city_id = c.city_id
JOIN country AS co ON c.country_id = co.country_id
ORDER BY s.store_id ASC;

-- Query 2 - Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id AS "STORE ID" , c.city AS "CITY" , SUM(p.amount) AS "BUSINESS IN DOLLARS"
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON a.city_id = c.city_id
JOIN customer AS cu ON s.store_id = cu.store_id
JOIN payment AS p ON cu.customer_id = p.customer_id
GROUP BY s.store_id,c.city_id
ORDER BY s.store_id ASC;

-- Query 3 - What is the average running time of films by category?
	
SELECT c.name AS "CATEGORY" , avg(f.length) AS "AVG LENGTH"
FROM category AS c 
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY c.name ASC;

-- Query 4 - Which film categories are longest?

SELECT c.name AS "CATEGORY" , avg(f.length) AS "AVG LENGTH"
FROM category AS c 
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY "AVG LENGTH" DESC;

-- Query 5 - Display the most frequently rented movies in descending order.

SELECT f.film_id AS "FILM ID" ,  f.title AS "FILM" , COUNT(r.rental_id) AS "TOTAL RENTAL"
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY  f.film_id , f.title
ORDER BY "TOTAL RENTAL" DESC;

-- Query 6 - List the top five genres in gross revenue in descending order.

SELECT c.name AS "CATEGORY" , SUM(p.amount) AS "TOTAL REVENUE"
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN inventory AS i ON fc.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY "TOTAL REVENUE" DESC LIMIT 5;

--Query 7 - Is "Academy Dinosaur" available for rent from Store 1?

SELECT 
    s.store_id AS "STORE ID",
    f.title AS "FILM",
    CASE 
        WHEN r.rental_id IS NULL THEN 'YES'
        ELSE 'NO'
    END AS "AVAILABLE Y/N"
FROM store AS s
JOIN inventory AS i ON s.store_id = i.store_id
JOIN film AS f ON f.film_id = i.film_id
LEFT JOIN rental AS r 
    ON i.inventory_id = r.inventory_id 
    AND r.return_date IS NULL
WHERE s.store_id = 1
  AND f.title = 'ACADEMY DINOSAUR' LIMIT 1;









