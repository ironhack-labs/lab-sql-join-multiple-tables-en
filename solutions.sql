--1. Write a query to display for each store its store ID, city, and country.
SELECT
	st.store_id
	, ct.city
	, cr.country
FROM store AS st
INNER JOIN address AS ad
	ON st.address_id = ad.address_id
INNER JOIN city AS ct
	ON ad.city_id = ct.city_id
INNER JOIN country AS cr
	ON ct.country_id = cr.country_id;
	
--2. Write a query to display how much business, in dollars, each store brought in.
SELECT
	s.store_id
	, SUM(p.amount) AS total_sales
FROM store AS s
INNER JOIN inventory AS i
	ON i.store_id = s.store_id
INNER JOIN rental AS r
	ON r.inventory_id = i.inventory_id
INNER JOIN payment AS p
	ON p.rental_id = r.rental_id
GROUP BY s.store_id;

--3. What is the average running time of films by category?
SELECT
	name AS category_name
	, AVG(f.length) AS avg_running_time
FROM category c
INNER JOIN film_category fc
	ON fc.category_id = c.category_id
INNER JOIN film f
	ON f.film_id = fc.film_id
GROUP BY category_name;

--4. Which film categories are longest?
SELECT
	name AS category_name
	, SUM(f.length) AS total_running_time
FROM category c
INNER JOIN film_category fc
	ON fc.category_id = c.category_id
INNER JOIN film f
	ON f.film_id = fc.film_id
GROUP BY category_name
ORDER BY total_running_time DESC;

--5.Display the most frequently rented movies in descending order.
SELECT
	f.title
	, COUNT(r.rental_id) n_rentals
FROM film f
INNER JOIN inventory i
	ON f.film_id = i.film_id
INNER JOIN rental r
	ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY n_rentals DESC;

--6. List the top five genres in gross revenue in descending order.
SELECT
	c.name AS category
	, SUM(p.amount) AS total_sales
FROM payment AS p
INNER JOIN rental AS r
	ON p.rental_id = r.rental_id
INNER JOIN inventory AS i
	ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
	ON i.film_id = f.film_id
INNER JOIN film_category AS fc
	ON f.film_id = fc.film_id
INNER JOIN category AS c
	ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_sales DESC
LIMIT 5;

--7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT
	COUNT(i.inventory_id)-COUNT(r.rental_id) AS available_inventory
FROM film f
INNER JOIN inventory i
	ON f.film_id = i.film_id
LEFT JOIN rental r
	ON i.inventory_id = r.inventory_id
WHERE i.store_id = 1
	AND f.title = "Academy Dinosaur";