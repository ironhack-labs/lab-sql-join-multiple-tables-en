-- Add you solution queries below:
----1, Write a query to display for each store its store ID, city, and country.----
select store_id,city,country
From store as ST
JOIN address as AD on AD.address_id = ST.address_id
JOIN city as CT on CT.city_id = AD.city_id
JOIN country on country.country_id = CT.country_id;

--- 2.Write a query to display how much business, in dollars, each store brought in.---
select store_id, total_sales || "$" as total_sales
From sales_by_store;

---3. What is the average running time of films by category?
SELECT cat.name AS category_name,AVG(fi.length) AS average_running_time
FROM category AS cat
JOIN film_category AS fc ON cat.category_id = fc.category_id
JOIN film AS fi ON fi.film_id = fc.film_id
GROUP BY cat.name;

---4.Which film categories are longest?

SELECT cat.name AS category_name,AVG(fi.length) AS "AVG LENGTH"
FROM category AS cat
JOIN film_category AS fc ON cat.category_id = fc.category_id
JOIN film AS fi ON fi.film_id = fc.film_id
GROUP BY cat.name
ORDER BY AVG(fi.length) DESC;

---5. Display the most frequently rented movies in descending order.
SELECT f.title AS "MOVIE",COUNT(r.rental_id) AS "RENTAL COUNT"
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY "RENTAL COUNT" DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT 
  cat.name AS "CATEGORY",
  SUM(p.amount) AS "GROSS REVENUE"
FROM category cat
JOIN film_category fc ON cat.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY cat.name
ORDER BY "GROSS REVENUE" DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
  CASE WHEN COUNT(*) > 0 THEN 'Yes' ELSE 'No' END AS "AVAILABLE"
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;











