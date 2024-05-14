use sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
select distinct 
sakila.store.store_id,
sakila.city.city,
sakila.country.country
from sakila.store
	inner join sakila.address on  sakila.address.address_id = sakila.store.address_id
	inner join sakila.city on sakila.city.city_id = sakila.address.city_id
	inner join sakila.country on sakila.country.country_id = sakila.city.country_id;


-- 2. Write a query to display how much business, in dollars, each store brought in.
select *
from sakila.sales_by_store;

-- 3. What is the average running time of films by category?
select distinct
sakila.category.name,
avg(sakila.film.length) as average_running_time
from sakila.film
	inner join sakila.film_category on sakila.film.film_id = sakila.film_category.film_id
    inner join sakila.category on sakila.film_category.category_id = sakila.category.category_id
group by sakila.category.name;

-- 4. Which film categories are longest?
select distinct
sakila.category.name,
max(sakila.film.length) as max_running_time
from sakila.film
	inner join sakila.film_category on sakila.film.film_id = sakila.film_category.film_id
    inner join sakila.category on sakila.film_category.category_id = sakila.category.category_id
group by sakila.category.name
order by max_running_time;

-- 5. Display the most frequently rented movies in descending order.
select distinct 
title,
sum(rental_duration) as rental_duration
from film
group by title
order by rental_duration desc;

-- 6. List the top five genres in gross revenue in descending order.
select distinct
sakila.sales_by_film_category.category,
sum(sakila.sales_by_film_category.total_sales) as gross_revenue
from sales_by_film_category
group by sakila.sales_by_film_category.category
order by gross_revenue desc
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select distinct 
sakila.film.title,
sakila.inventory.store_id
from sakila.inventory
	inner join sakila.film on sakila.film.film_id = sakila.inventory.film_id
where sakila.inventory.store_id = 1 and sakila.film.title like 'academy dinosaur'