--1. Write a query to display for each store its store ID, city, and country
SELECT --select specific columns in each table (from the aliases below) thne renaming selectd columns in each table to ""
  s.store_id AS "STORE ID",
  ci.city AS "CITY",
  co.country AS "COUNTRY"
FROM store AS s --start with the store table and connect it to 3 other tabes using their "foreigh key" links (a lookup pointing to the other table it comes from). AS will create aliases for each table
JOIN address AS a ON s.address_id = a.address_id 
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

--2. Write a query to display how much business, in dollars, each store brought in.
SELECT 
  s.store_id AS "STORE ID",
  SUM(p.amount) AS "TOTAL SALES"
FROM store AS s
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

--3. What is the average running time of films by category?
SELECT 
  c.name AS "CATEGORY",
  AVG(f.length) AS "AVERAGE RUNNING TIME"
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name;

--4. Which film categories are longest?-should we find the average or use their raw numbers to determine? 
SELECT 
  c.name AS "CATEGORY",
  AVG(f.length) AS "AVERAGE LENGTH"
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC;

--5. Display the most frequently rented movies in descending order.
SELECT 
  f.title AS "MOVIE",
  COUNT(r.rental_id) AS "RENTAL COUNT"
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;


--6. List the top five genres in gross revenue in descending order.
SELECT 
  c.name AS "GENRE",
  SUM(p.amount) AS "GROSS REVENUE"
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;


--7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT 
  CASE 
    WHEN COUNT(r.rental_id) > 0 THEN 'Yes'
    ELSE 'No'
  END AS "IS AVAILABLE"
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id
LEFT JOIN rental AS r 
  ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;


