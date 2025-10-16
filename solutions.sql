--1. Write a query to display for each store its store ID, city, and country.

SELECT
    s.store_id,
    c.city,
    co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id;

--2. Write a query to display how much business, in dollars, each store brought in.

SELECT
    s.store_id,
    SUM(p.amount) AS total_sales
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;

--3. What is the average running time of films by category?

SELECT
    c.name AS category,
    AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC;

--4. Which film categories are longest?

SELECT
    c.name AS category,
    AVG(f.length) AS avg_length
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC ;

--5. Display the most frequently rented movies in descending order.

SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rental_count DESC;

--6. List the top five genres in gross revenue in descending order.
SELECT
      c.name AS category,
	  sum(p.amount) AS total_revenue
FROM payment p
join rental r ON p.rental_id = r.rental_id
join  inventory i ON r.inventory_id = i.inventory_id
join film f ON i.film_id = f.film_id
join film_category fc ON f.film_id = fc.film_id
join category c ON fc.category_id = c.category_id
GROUP by c.name
order by total_revenue DESC
LIMIT 5;
	  
--7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT * FROM rental
WHERE return_date IS NULL;

SELECT
CASE
WHEN EXISTS (
SELECT 1
FROM inventory AS i
JOIN film AS f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1
AND i.inventory_id NOT IN (
SELECT inventory_id FROM rental WHERE return_date IS NULL
)
) THEN 'Yes'
ELSE 'No'
END AS is_available;	  
	  

 
   