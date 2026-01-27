/*1. Write a query to display for each store its store ID, city, and country. */

SELECT store_id, c.city, cc.country
from store s
join address a on a.address_id = s.address_id
join city c on c.city_id = a.city_id
join country cc on cc.country_id = c.country_id;

/* Write a query to display how much business, in dollars, each store brought in.*/

SELECT s.store_id, sum(p.amount) as sales
FROM store s
LEFT JOIN staff st on st.store_id = s.store_id
LEFT JOIN payment p on st.staff_id = p.staff_id
GROUP BY 1;

/* What is the average running time of films by category?*/

SELECT c.name, round(avg(f.length),2) as avg_film_length
FROM category c
	LEFT JOIN film_category fc on fc.category_id = c.category_id
	JOIN film f on f.film_id = fc.film_id
GROUP BY 1
ORDER BY 2;

/* Which film categories are longest?*/

SELECT c.name, round(max(f.length),2) as max_film_length
FROM category c
	LEFT JOIN film_category fc on fc.category_id = c.category_id
	JOIN film f on f.film_id = fc.film_id
GROUP BY 1
ORDER BY 2 DESC;

/* Display the most frequently rented movies in descending order. */

SELECT f.title,count(rental_id) as most_rented
FROM film f
	LEFT JOIN inventory i on i.film_id = f.film_id	-- left join to also capture films without inventory
	LEFT JOIN rental r on r.inventory_id = i.inventory_id -- left join to also capture films without a rental
GROUP BY 1
ORDER BY 2 DESC;

/*List the top five genres in gross revenue in descending order*/

SELECT c.name ,sum(p.amount) as grs
FROM film f
	JOIN inventory i on i.film_id = f.film_id
	JOIN rental r on r.inventory_id = i.inventory_id -- INNER join, since no rental = no revenue, so idc
	JOIN film_category fc on fc.film_id = f.film_id
	JOIN category c on c.category_id = fc.category_id
	JOIN payment p on r.rental_id = p.rental_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

/* Is "Academy Dinosaur" available for rent from Store 1?*/

WITH temp as (

SELECT f.title,i.inventory_id, i.store_id, r.rental_id, case when date() > r.return_date then 'Yes' else 'No' end as available
FROM film f
	JOIN inventory i on i.film_id = f.film_id
	LEFT JOIN rental r on r.inventory_id = i.inventory_id 
WHERE f.title = "ACADEMY DINOSAUR"
AND i.store_id = 1)

select distinct title, case when available = "Yes" then "Yes" else "No" end as Movie_Is_Available 
from temp

