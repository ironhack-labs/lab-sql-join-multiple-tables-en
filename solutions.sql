-- Add you solution queries below:
use sakila;
show tables;

-- 1. Write a query to display for each store its store ID, city, and country.
select 
    s.store_id,
    c.city,
    co.country
from store s
inner join address a on s.address_id = a.address_id
inner join city c on a.city_id = c.city_id
inner join country co on c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.

select 
    s.store_id,
    count(p.amount) as total_amount
from store s
inner join 
    staff st on s.manager_staff_id = st.staff_id
inner join 
    payment p on st.staff_id = p.staff_id
group by s.store_id
order by total_amount desc;

-- 3. What is the average running time of films by category?

select 
    ca.name,
    AVG(f.length) as avg_time_films
from category ca
left join 
    film_category fc on ca.category_id = fc.category_id
left join 
    film f on fc.film_id = f.film_id
group by ca.name
order by avg_time_films desc;

--  4. Which film categories are longest?

select 
    ca.name,
    sum(f.length) as total_length
from category ca
left join 
    film_category fc on ca.category_id = fc.category_id
left join 
    film f on fc.film_id = f.film_id
group by ca.name
order by total_length desc
limit 1;

-- 5. Display the most frequently rented movies in descending order.

select 
    f.title,
    count(r.rental_id) as n_rentals
from film f
left JOIN
    inventory v on f.film_id = v.film_id
inner join 
    rental r on v.inventory_id = r.inventory_id
group by f.title
order by n_rentals desc;

-- 6. List the top five genres in gross revenue in descending order.

select 
    ca.name,
    sum(p.amount) as revenue
from category ca
left join 
    film_category fc on ca.category_id = fc.category_id
inner join 
    film f on fc.film_id = f.film_id
inner join 
    inventory v on f.film_id = v.film_id
inner join 
    rental r on v.inventory_id = r.inventory_id
inner join 
    payment p on r.rental_id = p.rental_id
group by ca.name
order by revenue DESC
limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT
    f.title,
    case 
        when count(v.inventory_id) > 0 then 'Avalaible'
        else 'Not available'
    end as availability
from film f
left join 
    inventory v on f.film_id = v.film_id and v.store_id = 1
where f.film_id = 1
group by f.title;