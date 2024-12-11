use sakila;

/* Query 1 */
/* store address city country */
SELECT store_id, city, country from (((store join address on store.address_id = address.address_id) join city on address.city_id = city.city_id ) join country on city.country_id = country.country_id);

/* Query 2 */
select store.store_id, sum(payment.amount) from store join staff on store.manager_staff_id = staff.staff_id join payment on staff.staff_id = payment.staff_id group by store_id;

/* Query 3 */
Select category.name, avg(film.length) from film join film_category on film.film_id = film_category.film_id join category on category.category_id = film_category.category_id group by category.name order by category.name;

/* Query 4 */
Select category.name, avg(film.length) from film join film_category on film.film_id = film_category.film_id join category on category.category_id = film_category.category_id group by category.name order by avg(film.length) desc;

/* Query 5 */
select film.title, count(rental.rental_id) from film join inventory on film.film_id = inventory.film_id join rental on rental.inventory_id = inventory.inventory_id group by film.title order by count(rental.rental_id)desc;

/* Query 6 */
select category.name, sum(film.rental_rate) from rental join inventory on rental.inventory_id = inventory.inventory_id join film on film.film_id = inventory.film_id 
join film_category on film_category.film_id = film.film_id join category on category.category_id = film_category.category_id group by category.name order by sum(film.rental_rate) desc limit 5;

/* Query 7 */
SELECT
    f.title AS film_title,
    s.store_id,
    i.inventory_id,
    CASE
        WHEN r.rental_id IS NULL THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM
    film f
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    store s ON i.store_id = s.store_id
LEFT JOIN
    rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
WHERE
    f.title = 'Academy Dinosaur'
    AND s.store_id = 1;