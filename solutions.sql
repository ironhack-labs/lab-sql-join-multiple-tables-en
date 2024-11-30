-- Add you solution queries below:
#Write a query to display for each store its store ID, city, and country.
select s.store_id, ct.city, ctry.country  from sakila.store s
inner join sakila.address a
on s.address_id = a.address_id
inner join sakila.city as ct
on a.city_id = ct.city_id
inner join sakila.country as ctry
on ct.country_id = ctry.country_id;

USE sakila;

#Write a query to display how much business, in dollars, each store brought in.
with payments as (
select staff_id, sum(amount) as total_amount_usd
from sakila.payment as p
group by staff_id)
select s.store_id, pt.total_amount_usd
from sakila.store as s
inner join sakila.staff as st
on s.store_id = st.store_id
inner join payments as pt
on st.staff_id = pt.staff_id; 

#What is the average running time of films by category?
select c.name, AVG(f.length) as avg_running_time
from sakila.category as c
inner join sakila.film_category as fc
on c.category_id = fc.category_id
inner join sakila.film as f
on fc.film_id = f.film_id
group by c.name;

#Which film categories are longest?
select distinct c.name as category_name
from sakila.category as c
inner join sakila.film_category as fc
on c.category_id = fc.category_id
inner join sakila.film as f
on fc.film_id = f.film_id
and f.length = (select max(length) from sakila.film);


#Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) num_rentals 
from sakila.film as f
inner join sakila.inventory as i
on f.film_id = i.film_id
inner join sakila.rental as r
on i.inventory_id = r.inventory_id
group by f.film_id
order by num_rentals desc;

#List the top five genres in gross revenue in descending order.
select c.name as genre, sum(p.amount) as gross_revenue
from sakila.category as c
inner join sakila.film_category as fc
on c.category_id = fc.category_id
inner join sakila.film as f
on fc.film_id = f.film_id 
inner join sakila.inventory as i
on f.film_id = i.film_id
inner join sakila.rental as r
on i.inventory_id = r.inventory_id
inner join payment as p
on p.rental_id = r.rental_id
group by c.name
order by gross_revenue desc
limit 5;

#Is "Academy Dinosaur" available for rent from Store 1?
SELECT CASE
  WHEN COUNT(i.inventory_id) - COUNT(r.rental_id) > 0 THEN 'Available'
  ELSE 'Not Available'
END AS Availability_Flag
FROM inventory AS i
LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE i.store_id = 1
AND i.film_id = (SELECT f.film_id FROM film AS f WHERE f.title = 'Academy Dinosaur');



