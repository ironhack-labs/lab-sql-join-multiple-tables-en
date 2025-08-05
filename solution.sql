--1 Write a query to display for each store its store ID, city, and country.
SELECT SID AS "STORE ID",
				"city" AS "CITY ID",
		"country" AS "COUNTRY ID"
		FROM customer_list;
				
--2Write a query to display how much business, in dollars, each store brought in.
SELECT "store" as  "STORE", 
                 "total_sales" AS "TOTAL SALES" 
				 FROM sales_by_store;
				 
--3 What is the average running time of films by category?
SELECT category,length, ROUND(AVG("length"), 3)  AS "Average film length"
FROM film_list
GROUP BY category;
				 
--4 Which film categories are longest?
SELECT  "category" AS "CATEGORY",
			       MAX ("length") AS longest_film_length
                 FROM film_list 
				 GROUP BY "category"
				 ORDER BY longest_film_length DESC;
				 
--5 Display the most frequently rented movies in descending order.

SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC;

--6List the top five genres in gross revenue in descending order.

SELECT c.name AS category, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;

SELECT i.inventory_id
FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
  AND i.store_id = 1
  AND i.inventory_id NOT IN (
      SELECT inventory_id
      FROM rental
      WHERE return_date IS NULL
  );

