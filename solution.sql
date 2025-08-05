--1. Write a query to display for each store its store ID, city, and country.
SELECT SID as STORE_ID,"city", "country" from customer_list

--2. Write a query to display how much business, in dollars, each store brought in.
SELECT
  store.store_id,
  city.city,
  country.country
FROM store
	JOIN address ON store.address_id = address.address_id
	JOIN city ON address.city_id = city.city_id
	JOIN country ON city.country_id = country.country_id;
--3. What is the average running time of films by category?
SELECT c.name, avg(f.length) AS avg_runtime
FROM category AS c
	JOIN film_category AS fc ON c.category_id = fc.category_id
	JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name;
--4. Which film categories are longest?
SELECT c.name, avg(f.length) AS avg_runtime
FROM category AS c
	JOIN film_category AS fc ON c.category_id = fc.category_id
	JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_runtime DESC;

--5. Display the most frequently rented movies in descending order.
SELECT f.title,COUNT(rent.rental_id) AS total_count
FROM film AS f
	JOIN inventory AS inv ON f.film_id = inv.film_id
	JOIN rental AS rent ON inv.inventory_id = rent.inventory_id
GROUP BY f.title
ORDER BY total_count DESC;

--6. List the top five genres in gross revenue in descending order.
SELECT
  c.name AS genre,
  SUM(p.amount) AS total_revenue
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;

--7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT
  f.title AS film_title,
  COUNT(i.inventory_id) AS available_copies
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
 AND i.store_id = 1
GROUP BY f.title;