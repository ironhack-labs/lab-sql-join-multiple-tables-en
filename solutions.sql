use sakila;

-- 1
select
	s.store_id,
    ci.city,
    co.country
from store s
left join address a on s.address_id = a.address_id
left join city ci on ci.city_id = a.city_id
left join country co on ci.country_id = co.country_id;

-- 2
select
	s.store_id,
    sum(p.amount) as total_business
from store s
left join payment p on p.staff_id = s.manager_staff_id
group by s.store_id
order by s.store_id;

-- 3
select 
	c.`name` as category,
	avg(f.length) as average_running_time
from film f
left join film_category fc on fc.film_id = f.film_id
left join category c on fc.category_id = c.category_id
group by category
order by category;

-- 4
select 
	c.`name` as category,
	avg(f.length) as average_running_time
from film f
left join film_category fc on fc.film_id = f.film_id
left join category c on fc.category_id = c.category_id
group by category
order by average_running_time desc
limit 1;

-- 5
select 
	f.film_id,
	count(r.rental_id) as rented_times
from film f
left join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id
group by f.film_id
order by rented_times desc;

-- 6
select * from payment; -- rental_id, amount, staff_id
select * from rental;  -- rental_id, inventory_id
select * from inventory; -- inventory_id, film_id
select * from film; -- film_id
select * from category; -- category_id, name
select * from film_category;  -- film_id, category_id

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

-- 7
select 
	s.store_id,
    f.title
from store s
left join payment p on p.staff_id = s.manager_staff_id
left join rental r on r.rental_id = p.rental_id
left join inventory i on i.inventory_id = r.inventory_id
left join film f on f.film_id = i.film_id
where s.store_id = 1 and f.title='Academy Dinosaur' ;



