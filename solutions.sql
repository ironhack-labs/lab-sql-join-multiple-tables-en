-- 1. Write a query to display for each store its store ID, city, and country.

select s.store_id, c.city, ct.country
from store as s
join address as ad on s.address_id = ad.address_id
join city as c on c.city_id = ad.city_id
join country as ct on ct.country_id = c.country_id;

-- 2: Write a query to display how much business, in dollars, each store brought in.

SELECT DISTINCT(store_id) from store;
SELECT * from store;
SELECT * from staff;
SELECT * from payment;

select s.store_id, sum(p.amount) as amount_$
from store as s
join staff as st on s.manager_staff_id = st.staff_id
join payment as p on p.staff_id = st.staff_id
group by 1;

-- Shortest solutions

select store_id, total_sales from sales_by_store;


-- 3. What is the average running time of films by category?

select * from film;
select * from category;
select * from film_category;

Select c.name, round(avg(f.length),2) as avg_time
from film as f
join film_category as fc on fc.film_id = f.film_id
join category as c on c.category_id = fc.category_id
group by c.name;

-- 4. Which film categories are longest?
Select c.name, round(max(f.length),2) as longest_time
from film as f
join film_category as fc on fc.film_id = f.film_id
join category as c on c.category_id = fc.category_id
group by c.name
order by longest_time desc;

-- 5. Display the most frequently rented movies in descending order.
select * from inventory;
select * from rental;

select f.title, r.rental_date
from film as f
join inventory as i on i.film_id = f.film_id
join rental as r on r.inventory_id = i.inventory_id
order by r.rental_date desc
LIMIT 20;

-- 6. List the top five genres in gross revenue in descending order.

select c.name, sum(p.amount) as gross_rev
from category c
join film_category fc on fc.category_id = c.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on p.rental_id = r.rental_id
group by c.name
order by gross_rev desc 
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

/* 
select 
case 
when exits (
	select 1
	from inventory i
	join film f in i.film_id = f.film_id
	where f.title = 'Academy Dinosaur'
		and i.store_id = 1
		and i.inventory_id not in ( select inventory_id from rental where return_date is null)
)
then 'Yes'
else 'No'
end as movie_is_available;

*/

SELECT
CASE
WHEN EXISTS (
    SELECT 1
    FROM inventory i
    JOIN film f ON f.film_id = i.film_id
    WHERE f.title = 'Academy Dinosaur' or upper(f.title) = 'ACADEMY DINOSAUR'
      AND i.store_id = 1
      AND NOT EXISTS (
          SELECT 1
          FROM rental r
          WHERE r.inventory_id = i.inventory_id
            AND r.return_date IS NULL
      )
)
THEN 'Yes'
ELSE 'No'
END AS Movie_Is_Available;



