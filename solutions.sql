-- Q1

Select
	s.store_id,
	ci.city,
	co.country
from store as s
join address as a 
	on a.address_id = s.address_id
join city as ci
	on ci.city_id = a.city_id
join country as co
	on co.country_id =ci.country_id;

-- Q2

select
	str.store_id,
	sum(p.amount) as store_revenue
from store as str
join staff as stf
	on str.store_id = stf.store_id
join payment as p
	on p.staff_id = stf.staff_id
group by str.store_id;

-- Q3

select
	ctg.name,
	avg(f.`length`) as average_runtime
from film as f

join film_category as fctg
	on f.film_id = fctg.film_id
join category as ctg
	on fctg.category_id = ctg.category_id
	
group by ctg.name
order by average_runtime desc;

-- Q4

-- "Sports" and "Games" films are on average the longest.

-- Q5

select
	f.title,
	count(rnt.rental_id) as times_rented
from film as f
join inventory as inv
	on f.film_id = inv.film_id
join rental as rnt
	on inv.inventory_id = rnt.inventory_id
group by f.title 
order by times_rented DESC;

--Q6

select
	ctg.name,
	sum(p.amount) as revenue
from payment as p
join rental as rnt
	on p.rental_id = rnt.rental_id
join inventory as inv
	on rnt.inventory_id = inv.inventory_id
join film_category as fctg
	on inv.film_id = fctg.film_id
join category as ctg
	on fctg.category_id = ctg.category_id
	
group by ctg.name
order by revenue DESC
limit 5;

--Q7

Select 
	f.title,
	inv.inventory_id
from film as f
join inventory as inv
	on f.film_id = inv.film_id
left join rental as rnt
	on inv.inventory_id = rnt.inventory_id
	and rnt.return_date is NULL
	
-- if "return date is null" is not found an entry is still returned with rental id being null, using where instead would filter these results out.
	
where f.title = 'ACADEMY DINOSAUR'
	and inv.store_id = 1
	and rnt.rental_id is NULL;
	
-- rental id is null if a rental id was not found that met the condtion of "rnt.return_date is NULL" (film is out for rent)
-- so all films returned by query are available.






	
	
