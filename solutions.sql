/*
Write a query to display for each store its store ID, city, and country.
*/

SELECT st.store_id, c.city, cou.country 
from 
store as st 
join address as addr on st.address_id = addr.address_id
join city as c on c.city_id = addr.city_id
join country as cou on cou.country_id = c.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
select c.city, SUM(amount)
FROM payment as pay
join staff_list on pay.staff_id = staff_list.ID
join city as c on c.city = staff_list.city
Group BY c.city;

--What is the average running time of films by category? AVG(duration)
SELECT c.name, AVG(f.length) FROM 
film as f JOIN
film_category as fc on fc.film_id = f.film_id JOIN
category as c on c.category_id = fc.category_id
GROUP BY c.name;

---Which film categories are longest?
SELECT c.name, MAX(f.length) as mmm FROM 
film as f JOIN
film_category as fc on fc.film_id = f.film_id JOIN
category as c on c.category_id = fc.category_id
GROUP BY c.name ORDER BY mmm DESC;

--- Display the most frequently rented movies in descending order.
SELECT f.title, count(*) as 'no of rentals'
FROM rental as re
join inventory as inv on re.inventory_id = inv.inventory_id
join film as f on f.film_id = inv.film_id
GROUP BY f.film_id
ORDER BY "no of rentals" DESC;

--List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(pay.amount) as REVENUE FROM
payment as pay JOIN
rental as re on pay.rental_id = re.rental_id JOIN
inventory as inv on inv.inventory_id = re.inventory_id JOIN
film as f on inv.film_id = f.film_id JOIN
film_category as fc on fc.film_id = f.film_id JOIN
category as c on c.category_id = fc.category_id
GROUP BY c.name
ORDER BY REVENUE DESC LIMIT 5;

---Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, s.store_id, COUNT(*) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE s.store_id = 1
 AND f.title = 'ACADEMY DINOSAUR'
-- "Academy Dinosaur" (in small letters) not found
GROUP BY f.title, s.store_id;