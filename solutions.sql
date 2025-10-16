-- 1. Write a query to display for each store its store ID, city, and country
SELECT st.store_id AS "STORE ID", ci.city AS "CITY", co.country AS "COUNTRY"
FROM country AS co JOIN city AS ci ON co.country_id= ci.country_id
JOIN address AS ad  ON ad.city_id = ci.city_id 
JOIN store AS st on ad.address_id = st.address_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT st.store_id AS "STORE ID", concat("$",SUM(pa.amount)) AS "TOTAL"
FROM payment AS pa

JOIN staff AS sta ON pa.staff_id = sta.staff_id
JOIN store AS st ON st.store_id = sta.store_id
GROUP BY st.store_id;

-- 3. What is the average running time of films by category?
SELECT ca.name AS "Category",ROUND(AVG(f.length),2) AS "Average Running time" 
FROM film AS f

JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS ca ON ca.category_id =fc.category_id
GROUP BY ca.name;

-- 4. Which film categories are longest?
SELECT ca.name AS "Category",ROUND(AVG(f.length),2) AS "Average Running time" 
FROM film AS f

JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS ca ON ca.category_id =fc.category_id

GROUP BY Category
ORDER BY "Average Running time" DESC
LIMIT 3;
-- The output states the categories Sports, Games and Foreign are the longest ones

-- 5. Display the most frequently rented movies in descending order.

SELECT f.title, COUNT(*) AS "Amount of rental times"

FROM inventory AS inv JOIN rental AS r ON inv.inventory_id = r.inventory_id
JOIN film AS f ON f.film_id= inv.film_id

GROUP BY f.film_id
ORDER BY "Amount of rental times" DESC;

-- 6. List the top five genres in gross revenue in descending order.

SELECT ca.name AS "Category", SUM(pa.amount) AS "Gross Revenue"
FROM rental AS r

JOIN payment AS pa ON r.rental_id = pa.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS ca ON fc.category_id = ca.category_id

GROUP BY ca.name
ORDER BY "Gross Revenue" DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT *
FROM film AS f JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title == "Academy Dinosaur" AND i.store_id = 1;
/* By the output, we can observe
 that Academy Dinosaur is not available at Store 1
 due to is not present in the store's inventory*/