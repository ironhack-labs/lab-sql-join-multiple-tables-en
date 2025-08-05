-- Add your solution queries below:
-- Q1
SELECT
  store.store_id,
  city.city,
  country.country
FROM store
	JOIN address ON store.address_id = address.address_id
	JOIN city ON address.city_id = city.city_id
	JOIN country ON city.country_id = country.country_id;
	
-- Q2
SELECT 
	store_id,total_sales FROM sales_by_store ORDER BY total_sales DESC;
	
--Q3
SELECT c.name, avg(f.length) AS avg_runtime
FROM category AS c
	JOIN film_category AS fc ON c.category_id = fc.category_id
	JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name;

-- Q4
SELECT c.name, avg(f.length) AS avg_runtime
FROM category AS c
	JOIN film_category AS fc ON c.category_id = fc.category_id
	JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_runtime DESC;

-- Q5
SELECT f.title,COUNT(rent.rental_id) AS total_count
FROM film AS f
	JOIN inventory AS inv ON f.film_id = inv.film_id
	JOIN rental AS rent ON inv.inventory_id = rent.inventory_id
GROUP BY f.title
ORDER BY total_count DESC;

-- Q6
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

-- Q7
SELECT
  f.title AS film_title,
  COUNT(i.inventory_id) AS available_copies
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur'
 AND i.store_id = 1
GROUP BY f.title;






