-- Add you solution queries below:

-- Write a query to display for each store its store ID, city, and country.
SELECT st.store_id, c.city as City, ct.country as Country
FROM store as st
JOIN address as a ON a.address_id = st.address_id
JOIN city as c ON c.city_id = a.city_id
JOIN country as ct ON ct.country_id = c.country_id;


-- Write a query to display how much business, in dollars, each store brought in.
SELECT st.store_id, SUM(ss.total_sales) as Business
FROM store as st
JOIN sales_by_store AS ss ON ss.store_id=st.store_id
GROUP BY st.store_id;


-- What is the average running time of films by category?
SELECT c.name, AVG(f.length) as avg_running_time
FROM film as f
JOIN film_category as fc ON f.film_id = fc.film_id
JOIN category as c ON c.category_id = fc.category_id
GROUP BY c.name;


-- Which film categories are longest?
SELECT c.name
FROM film as f
JOIN film_category as fc ON f.film_id = fc.film_id
JOIN category as c ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY f.length DESC
LIMIT 5;


-- Display the most frequently rented movies in descending order.
SELECT f.title, count(r.rental_id) as freq_rental
FROM rental as r
join inventory as i on i.inventory_id=r.inventory_id
join film as f on f.film_id=i.film_id
group by f.film_id
order by freq_rental DESC
LIMIT 5;



-- List the top five genres in gross revenue in descending order. ??
SELECT sf.category
FROM sales_by_film_category as sf
ORDER BY sf.total_sales DESC
LIMIT 5;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
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

