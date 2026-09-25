/*Add you solution queries below:*/
/* data base = Sakila database+/

/* 1.Write a query to display for each store its store ID, city, and country.*/

SELECT 
	store.store_id AS "Store ID",
	city.city AS "City",
	country.country AS "Country"
FROM store
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id

/*2. Write a query to display how much business, in dollars, each store brought in.*/

SELECT 
	store.store_id AS "Store ID",
	sales_by_store.total_sales AS "Total Sales"
FROM store
INNER JOIN sales_by_store ON store.store_id = sales_by_store.store_id;

/*3. What is the average running time of films by category?*/

SELECT 
category,
AVG(length)  AS  "Average Running Time"
FROM film_list
GROUP BY category;

/* 4. Which film categories are longest?*/
SELECT 
category,
AVG(length)  AS  "Average Running Time"
FROM film_list
GROUP BY category
ORDER BY "Average Running Time" DESC
LIMIT 1;

/* 5. Display the most frequently rented movies in descending order.*/

SELECT 
    film.title AS 'Film Title',
    COUNT(rental.rental_id) AS 'Rental Count'
FROM film
INNER JOIN inventory  ON film.film_id = inventory.film_id
INNER JOIN rental  ON inventory.inventory_id = rental.inventory_id
GROUP BY  film.title
ORDER BY COUNT(rental.rental_id) DESC;

/*6. List the top five genres in gross revenue in descending order.*/
SELECT * 
FROM sales_by_film_category
ORDER BY total_sales DESC
LIMIT 5;

/* 7. Is "Academy Dinosaur" available for rent from Store 1?*/

SELECT 
    f.title, 
    COUNT(i.inventory_id) AS 'Total Copies at Store 1'
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;








