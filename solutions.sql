-- Add you solution queries below:

/*
1. Write a query to display for each store its store ID, city, and country.
2. Write a query to display how much business, in dollars, each store brought in.
3. What is the average running time of films by category?
4. Which film categories are longest?
5. Display the most frequently rented movies in descending order.
6. List the top five genres in gross revenue in descending order.
7. Is "Academy Dinosaur" available for rent from Store 1?
*/

-- 1. Write a query to display for each store its store ID, city, and country.
SELECT 
	s.store_id AS "STORE ID",
	c.city AS "CITY",
	co.country AS "COUNTRY"
FROM
	store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT 
  s.store_id AS "STORE ID",
  SUM(p.amount) AS "TOTAL SALES"
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

-- 3. What is the average running time of films by category?
SELECT 
  cat.name AS "CATEGORY",
  AVG(f.length) AS "AVG LENGTH"
FROM category cat
JOIN film_category fc ON cat.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY cat.name;

-- 4. Which film categories are longest?
SELECT 
  cat.name AS "CATEGORY",
  AVG(f.length) AS "AVG LENGTH"
FROM category cat
JOIN film_category fc ON cat.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY cat.name
ORDER BY AVG(f.length) DESC;

-- 5. Display the most frequently rented movies in descending order.
SELECT 
  f.title AS "MOVIE",
  COUNT(r.rental_id) AS "RENTAL COUNT"
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
