-- Add you solution queries below:
/* QUERY 1*/
SELECT store.store_id as "store ID", 
		city.city as "city", 
		country.country as "country"
FROM store LEFT JOIN address
			on store.address_id = address.address_id
		LEFT JOIN city
			on address.city_id = city.city_id
		LEFT JOIN country
			on city.country_id = country.country_id;

/* QUERY 2*/
SELECT store.store_id as "store ID",
		sum(payment.amount) as "business total"
FROM store LEFT JOIN staff
			on store.store_id = staff.store_id
	LEFT JOIN payment
			on staff.staff_id = payment.staff_id
GROUP BY store.store_id;

/* QUERY 3 */
SELECT avg(film.length) as "average film length",
		category.name as "category"
FROM film INNER JOIN film_category
	on film.film_id = film_category.film_id
		INNER JOIN category
	on film_category.category_id = category.category_id
GROUP BY category.name;

/* QUERY 4*/
SELECT avg(film.length) as "average film length",
		category.name as "category"
FROM film INNER JOIN film_category
	on film.film_id = film_category.film_id
		INNER JOIN category
	on film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY avg(film.length) DESC;

/* QUERY 5*/
SELECT film.title as "film",
		count(rental.rental_date) as "times rented"
FROM film INNER JOIN inventory
		on film.film_id = inventory.film_id
	INNER JOIN rental
		on inventory.inventory_id = rental.inventory_id
GROUP BY film.title	
ORDER BY count(rental.rental_date) DESC;

/* QUERY 6 */
SELECT category.name as "genre",
		sum(payment.amount) as "revenue"
FROM category INNER JOIN film_category
	on category.category_id = film_category.category_id
	INNER JOIN inventory
	on film_category.film_id = inventory.film_id
	INNER JOIN rental
	on inventory.inventory_id = rental.inventory_id
	INNER JOIN payment
	on rental.rental_id = payment.rental_id
GROUP BY category.name
ORDER BY sum(payment.amount) DESC
LIMIT 5;

/* QUERY 7 */
		
SELECT 
	CASE WHEN count(
					CASE WHEN rental.rental_id is NULL
					THEN inventory.inventory_id END)>0
	THEN "YES"
	ELSE "NO"
	END as available
FROM film INNER JOIN inventory
	on film.film_id = inventory.film_id
	LEFT JOIN rental
	on inventory.inventory_id = rental.inventory_id
	AND rental.return_date is NULL
WHERE film.title = "ACADEMY DINOSAUR" 
		AND inventory.store_id = 1;