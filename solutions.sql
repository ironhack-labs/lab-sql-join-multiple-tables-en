-- 1. Write a query to display for each store its store ID, city, and country.

SELECT 
a.store_id,
b."city",
c."country"
FROM 
store as a
LEFT JOIN address as d on a.address_id = d.address_id
LEFT JOIN city as b on d.city_id = b.city_id
LEFT JOIN country as c on b.country_id = c.country_id;



-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT c.store_id, sum(amount) FROM payment as a
JOIN rental as b on a.rental_id = b.rental_id
JOIN inventory as c on b.inventory_id=c.inventory_id
GROUP BY c.store_id;


-- 3. What is the average running time of films by category?

SELECT 
c.name AS "CATEGORY",
avg(a."length") as AVG_RUN_TIME
FROM film as a
JOIN film_category as b on a.film_id=b.film_id
JOIN category as c on b.category_id=c.category_id
GROUP BY c.name;



-- 4. Which film categories are longest?
SELECT 
c.name AS "CATEGORY",
avg(a."length") as AVG_RUN_TIME
FROM film as a
JOIN film_category as b on a.film_id=b.film_id
JOIN category as c on b.category_id=c.category_id
GROUP BY c.name
ORDER BY AVG_RUN_TIME DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT 
--title AS MOVIE
c.title as MOVIE,
count(*) AS N_TIMES_RENTED
FROM
rental as A
JOIN inventory as B on A.inventory_id=B.inventory_id
JOIN film as c on b.film_id = c.film_id
GROUP BY b.film_id
ORDER BY N_TIMES_RENTED DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT 
e.name as CATEGORY, 
sum(amount) as "GROSS REVENUE"
FROM payment as a
JOIN rental as b on a.rental_id = b.rental_id
JOIN inventory as c on b.inventory_id=c.inventory_id
JOIN film_category as d on c.film_id=d.film_id
JOIN category as e on d.category_id=e.category_id
GROUP BY e.name
ORDER BY "GROSS REVENUE" DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT
a.title as MOVIE,
--a.film_id,
b.store_id,
count(*) AS "AVAILABLE COPIES"
FROM film as A
JOIN inventory as B on A.film_id = B.film_id
WHERE a.title = "ACADEMY DINOSAUR" AND b.store_id=1
GROUP BY a.title, b.store_id;

--PRAGMA table_info(inventory)

