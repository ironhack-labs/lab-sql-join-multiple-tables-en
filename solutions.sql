-- Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, co.country
from store as s 
join address as a on a.address_id=s.address_id
join city as c on a.city_id=c.city_id
join country as co on c.country_id=co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as total
from store as s
join staff as st on st.store_id=s.store_id
join payment as p on p.staff_id=st.staff_id
group by s.store_id;
-- What is the average running time of films by category?
select c.name as category , round(avg(f.length), 2) as avg_duration
from category as c
join film_category as fc on fc.category_id=c.category_id
join film as f on fc.film_id=f.film_id
group by category 
order by avg_duration desc;

-- Which film categories are longest?
select c.name as category , round(avg(f.length), 2) as avg_duration
from category as c
join film_category as fc on fc.category_id=c.category_id
join film as f on fc.film_id=f.film_id
group by category 
order by avg_duration desc
limit 5;

-- Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as rentals
from inventory as i
join rental as r on r.inventory_id=i.inventory_id
join film as f on  i.film_id=f.film_id
group by f.film_id
order by rentals desc;
-- List the top five genres in gross revenue in descending order
select c.name, sum(p.amount) as revenue
from payment as p
join rental  as r on p.rental_id=r.rental_id
join inventory as i ON r.inventory_id=i.inventory_id
join film_category as fc ON i.film_id = fc.film_id
join category as c on c.category_id=fc.film_id
group by c.category_id
order by revenue desc
limit 5;
-- Is "Academy Dinosaur" available for rent from Store 1?
select f.title,  i.inventory_id, r.rental_id, r.rental_date
from inventory i
join film f  on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id
                 and r.return_date IS NULL   
where i.store_id=1 and f.title = 'ACADEMY DINOSAUR' 	 
-- answer: YES