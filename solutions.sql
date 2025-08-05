-- Q1 Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, city."city", country."country"
FROM store
INNER JOIN address ON store.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id;

-- Q2 Write a query to display how much business, in dollars, each store brought in.
SELECT sales_by_store.store, sum(payment.amount) AS total_in_dollars
FROM store
INNER JOIN sales_by_store ON store.store_id = sales_by_store.store_id
INNER JOIN payment ON store.manager_staff_id = payment.staff_id
GROUP BY sales_by_store.store;

--Q3 What is the average running time of films by category?
SELECT category.name, avg(film."length") AS average_running_time
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id=category.category_id
GROUP BY category.name;

--Q4 Which film categories are longest?
SELECT category.name, avg(film."length") AS average_running_time
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id=category.category_id
GROUP BY category.name
ORDER BY average_running_time DESC;

--Q5 Display the most frequently rented movies in descending order.
SELECT film.title, sum(rental.rental_id) AS time_rented
FROM rental
INNER JOIN inventory ON rental.inventory_id=inventory.inventory_id
INNER JOIN film ON inventory.film_id=film.film_id
GROUP BY film.title
ORDER BY time_rented DESC LIMIT 10;

--Q6 List the top five genres in gross revenue in descending order.
SELECT category.name, sum(payment.amount) AS gross_revenue
FROM payment
INNER JOIN rental ON payment.rental_id=rental.rental_id
INNER JOIN inventory ON rental.inventory_id=inventory.inventory_id
INNER JOIN film_category ON inventory.film_id=film_category.film_id
INNER JOIN category ON film_category.category_id=category.category_id
GROUP BY category.name
ORDER BY gross_revenue DESC LIMIT 5;

--Q7 Is "Academy Dinosaur" available for rent from Store 1?
SELECT  
  CASE  
    WHEN EXISTS ( 
      SELECT 1  
      FROM inventory AS i 
      JOIN film AS f ON i.film_id = f.film_id 
      WHERE f.title = 'Academy Dinosaur' 
        AND i.store_id = 1 
        AND i.inventory_id NOT IN ( 
          SELECT inventory_id FROM rental WHERE return_date IS NULL 
        ) 
    ) THEN 'Yes' 
    ELSE 'No' 
  END AS is_available;