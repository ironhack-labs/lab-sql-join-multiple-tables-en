-- Add you solution queries below:

-- 1 Write a query to display for each store its store ID, city, and country.

SELECT store.store_id, city.city, country.country
from store 
JOIN  address ON store.address_id = address.address_id
JOIN city ON  address.city_id = city.city_id
JOIN country on country.country_id = city.country_id;


-- 2 Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, sum(payment.amount)
FROM store
JOIN customer on customer.store_id = store.store_id 
JOIN payment on payment.customer_id = customer.customer_id
group by store.store_id;

--3 What is the average running time of films by category?

SELECT category.name, avg(film.length)
FROM film
JOIN film_category on film.film_id = film_category.film_id
JOIN category on film_category.category_id = category.category_id
GROUP by category.name;

-- 4. Which film categories are longest?

SELECT category.name, avg(film.length)
FROM film
JOIN film_category on film.film_id = film_category.film_id
JOIN category on film_category.category_id = category.category_id
GROUP by category.name
ORDER by avg(film.length) DESC;

-- 5. Display the most frequently rented movies in descending order.

SELECT film.title, count(rental_id) as "rental count"
FROM film
JOIN inventory on film.film_id = inventory.film_id
JOIN rental on inventory.inventory_id = rental.inventory_id
GROUP by film.title
ORDER by count(rental.rental_id) desc;

-- 6. List the top five genres in gross revenue in descending order.  
SELECT category.name, SUM(payment.amount) AS gross_revenue
FROM payment
JOIN rental ON rental.rental_id = payment.rental_id
JOIN inventory on inventory.inventory_id = rental.inventory_id
JOIN film on film.film_id = inventory.film_id
JOIN film_category on film_category.film_id = film.film_id
JOIN category on category.category_id = film_category.category_id
GROUP by category.name
ORDER by gross_revenue DESC
limit 5;


--7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT film.title
from film
JOIN inventory on inventory.film_id = film.film_id
JOIN store on store.store_id = inventory.store_id
WHERE film.title = 'ACADEMY DINOSAUR' AND store.store_id = 1;
