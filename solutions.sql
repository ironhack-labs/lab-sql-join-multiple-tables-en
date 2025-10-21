-- QUERY 1: Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, ci.city, co.country 
FROM store AS s
JOIN address AS ad ON s.address_id = ad.address_id
JOIN city AS ci ON ad.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;


-- QUERY 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) AS total_sales
FROM store AS s
JOIN inventory AS i ON s.store_id = i.store_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY s.store_id;

-- QUERY 3. What is the average running time of films by category?
SELECT category, avg(length) AS avg_running_time
FROM film_list
GROUP BY category;

select c.name as category, avg(f.length) as running_time
from film as f
join film_category as fc on f.film_id = fc.film_id
join category as c on fc.category_id = c.category_id
group by c.name

-- QUERY 4. Which film categories are longest?

select 
	c.`name` as category,
	avg(f.length) as average_running_time
from film f
left join film_category fc on fc.film_id = f.film_id
left join category c on fc.category_id = c.category_id
group by category
order by average_running_time desc
limit 1;

-- QUERY 5. Display the most frequently rented movies in descending order.
select 
	f.film_id,
	count(r.rental_id) as rented_times
from film f
left join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id
group by f.film_id
order by rented_times desc;

-- QUERY 6. List the top five genres in gross revenue in descending order.

select
	c.`name` as category,
    sum(p.amount) as gross_revenue
from payment p
left join rental r on r.rental_id = p.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join film f on i.film_id = f.film_id
left join film_category fc on fc.film_id = f.film_id
left join category c on fc.category_id = c.category_id
group by category
order by gross_revenue desc
limit 5;

-- QUERY 7. Is "Academy Dinosaur" available for rent from Store 1?
select 
	s.store_id,
    f.title
from store s
left join payment p on p.staff_id = s.manager_staff_id
left join rental r on r.rental_id = p.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join film f on f.film_id = i.film_id
where s.store_id = 1 and f.title='Academy Dinosaur' ;
