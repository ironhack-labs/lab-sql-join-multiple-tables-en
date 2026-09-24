-- Add you solution queries below:

/* Task 1*/
SELECT store.store_id, city.city, country.country FROM store
	INNER JOIN address ON store.address_id = address.address_id
	INNER JOIN city ON city.city_id = address.city_id
	INNER JOIN country ON country.country_id = city.country_id
	
/* Task 2 */
SELECT store.store_id, SUM(payment.amount) FROM store
	INNER JOIN inventory ON store.store_id = inventory.store_id
	INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
	INNER JOIN payment ON rental.rental_id = payment.payment_id
GROUP BY store.store_id

/*Task 3*/
SELECT  category.name, AVG(film.length) FROM category 
	LEFT JOIN film_category ON film_category.category_id = category.category_id
	LEFT JOIN film ON film_category.film_id = film.film_id
GROUP BY category.category_id

/*Task 4*/
SELECT  category.name, AVG(film.length) FROM category 
	LEFT JOIN film_category ON film_category.category_id = category.category_id
	INNER JOIN film ON film_category.film_id = film.film_id
GROUP BY category.category_id
ORDER BY AVG(film.length) DESC

/*Task 5*/
SELECT  film.title, COUNT(rental.rental_id) FROM rental 
   RIGHT JOIN inventory ON inventory.inventory_id = rental.inventory_id
   RIGHT JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id
ORDER BY COUNT(rental.rental_id) DESC

/*Task 6*/
SELECT category.name, SUM(payment.amount) FROM category
	LEFT JOIN film_category ON film_category.category_id = category.category_id
	LEFT JOIN film ON film_category.film_id = film.film_id
	LEFT JOIN inventory ON inventory.film_id = film.film_id
	LEFT JOIN rental ON rental.inventory_id = inventory.inventory_id
	LEFT JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY category.category_id 
ORDER BY SUM(payment.amount) DESC LIMIT 5

/*Task 7*/
SELECT CASE WHEN EXISTS (
    SELECT 1
    FROM film f
    INNER JOIN inventory i ON i.film_id = f.film_id
    WHERE f.title = 'ACADEMY DINOSAUR'
      AND NOT EXISTS (
          SELECT 1 FROM rental r
          WHERE r.inventory_id = i.inventory_id
            AND r.return_date IS NULL
      )
) THEN 'Academy Dinosaur is available'
  ELSE 'Academy Dinosaur is not available'
END AS availability;