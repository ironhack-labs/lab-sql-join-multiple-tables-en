/* 1. Write a query to display for each store its store ID, city, and country.*/
select store_id, city,country
from store
join address on store.address_id=address.address_id
join city on address.city_id=city.city_id
join country on city.country_id=country.country_id
group by store.store_id;

/* 2. Write a query to display how much business, in dollars, each store brought in.*/
select store_id, total_sales
from sales_by_store;

/* 3. What is the average running time of films by category? */
SELECT category_id,avg(length)
from film_category
join film on film_category.film_id=film.film_id
group by category_id;

/* 4. Which film categories are longest? */
SELECT category_id,avg(length)
from film_category
join film on film_category.film_id=film.film_id
group by category_id
order by avg(length) desc;

/* 5. Display the most frequently rented movies in descending order. */
select title,count(rental_id)
from film
join inventory on film.film_id=inventory.film_id
join rental on inventory.inventory_id=rental.inventory_id
group by title
order by count(rental_id) DESC;

/* 6. List the top five genres in gross revenue in descending order.*/
select "category", total_sales from sales_by_film_category;

/* 7. Is "Academy Dinosaur" available for rent from Store 1? */
select title, store.store_id,inventory_id
from inventory
join film on inventory.film_id=film.film_id
join store on inventory.store_id=store.store_id
where title="Academy Dinosaur" and store.store_id=1;



