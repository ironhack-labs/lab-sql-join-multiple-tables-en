SELECT 
	s.store_id as store_ID,
	c.city as city,
	co.country as country
FROM store as s
JOIN address as a on s.address_id = a.address_id
JOIN city as c on a.city_id = c.city_id
JOIN country as co on c.country_id = co.country_id
ORDER by store_ID;

SELECT 
	s.store as store,
	s.total_sales as total_sales_in_dollars
FROM sales_by_store as s;
	
SELECT 
	ca.name as cat,
	avg(f.length) as average_running_time
FROM category as ca
JOIN film_category as fca on fca.category_id = ca.category_id
JOIN film as f on f.film_id = fca.film_id
GROUP by cat;

SELECT 
	ca.name as cat,
	avg(f.length) as average_running_time
FROM category as ca
JOIN film_category as fca on fca.category_id = ca.category_id
JOIN film as f on f.film_id = fca.film_id
GROUP by cat
ORDER by average_running_time DESC;

SELECT 
	f.title as film_title,
	f.rental_rate as Rental_Rate
FROM film as f
GROUP by film_title
ORDER by Rental_Rate DESC;


SELECT 
	ca.name as cat,
	sum(p.amount) as gross_revenue
FROM category as ca
JOIN film_category as fca on fca.category_id = ca.category_id
JOIN film as f on f.film_id = fca.film_id
JOIN inventory as i on i.film_id = f.film_id
JOIN rental as r on r.inventory_id = i.inventory_id
join payment as p on p.rental_id = r.rental_id
GROUP by cat
ORDER by gross_revenue DESC LIMIT 5;

SELECT
	CASE
	WHEN EXISTS (
		SELECT 1
		FROM inventory as i
		JOIN film as f on i.film_id = f.film_id
		WHERE f.title = "Academy Dinosaur"
		AND i.store_id = 1
		and i.inventory_id NOT in (
		SELECT inventory_id FROM rental WHERE return_date is NULL
		)
	) THEN "YES"
	ELSE "NO"
END AS is_available;
		
