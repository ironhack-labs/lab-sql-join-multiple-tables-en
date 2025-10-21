--Query 1: Write a query to display for each store its store ID, city, and country.
SELECT s.store_id AS 'STORE ID',
		c.city,
		co.country
FROM store AS s
JOIN address AS a ON s.address_id=a.address_id
JOIN city AS c ON a.city_id=c.city_id
JOIN country AS co ON c.country_id=co.country_id;

--Query 2: Write a query to display how much business, in dollars, each store brought in
SELECT store_id AS 'STORE ID',
		store AS ADDRESS,
		total_sales AS 'TOTAL BUSINESS ($)'
FROM sales_by_store;

--Query 3: What is the average running time of films by category?
SELECT category AS 'FILM CATEGORY',
		AVG(length) AS 'AVERAGE RUNNING TIME (min)'
FROM film_list
GROUP BY category;

--Query 4:Which film categories are longest?
SELECT category AS 'FILM CATEGORY',
		AVG(length) AS 'AVERAGE RUNNING TIME (min)'
FROM film_list
GROUP BY category
ORDER BY AVG(length) DESC
LIMIT 5;

--Query 5: Display the most frequently rented movies in descending order.
SELECT f.title AS 'FILM TITLE',
	   COUNT(r.rental_id) AS 'TIMES RENTED (from 24/05/2005 till 23/08/2005)'
FROM film AS f
JOIN inventory AS i ON f.film_id=i.film_id
JOIN rental AS r ON i.inventory_id=r.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC
LIMIT 10;

--Query 6: List the top five genres in gross revenue in descending order.
SELECT category,
	   total_sales
FROM sales_by_film_category
ORDER BY total_sales DESC
LIMIT 5;

--Query 7: Is "Academy Dinosaur" available for rent from Store 1?
--inventory: film_id and store_id; film: film_id and title
SELECT i.film_id, 
       i.store_id, 
       f.title
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur' 
  AND i.store_id = 1;



		