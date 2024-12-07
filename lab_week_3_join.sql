USE sakila;
-- Write a query to display for each store its store ID, city, and country.
SELECT s.store_id,c.city,co.country
FROM store as s
JOIN address as a ON s.address_id = a.address_id
JOIN city AS c ON c.city_id=a.city_id
JOIN country AS co ON  c.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id,COUNT(p.customer_id) AS Number_of_costumers ,SUM(p.amount) AS dollars
FROM store AS s
JOIN staff AS st ON st.store_id=s.store_id
JOIN payment AS p ON p.staff_id=st.staff_id
GROUP BY s.store_id;
-- What is the average running time of films by category?
select *
FROM category;
#no entiendo como conseguir el running time
-- Which film categories are longest?
SELECT c.name,AVG(f.length)
FROM film AS f
JOIN film_category AS fc ON fc.film_id=f.film_id
JOIN category AS c ON c.category_id=fc.category_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC;
-- Display the most frequently rented movies in descending order.
SELECT f.title,COUNT(r.rental_id)
FROM film AS f
JOIN inventory AS i ON i.film_id=f.film_id
JOIN rental AS r ON r.inventory_id=i.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;
-- List the top five genres in gross revenue in descending order.
SELECT c.name,SUM(p.amount)
FROM category AS c
JOIN film_category AS f ON f.category_id=c.category_id
JOIN inventory AS i ON i.film_id = f.film_id
JOIN rental AS r ON r.inventory_id=i.inventory_id
JOIN payment AS p ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC;
-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title, COUNT(r.rental_id)
FROM film AS f
JOIN inventory AS i ON i.film_id=f.film_id
JOIN rental AS r ON r.inventory_id=i.inventory_id
WHERE f.title="Academy Dinosaur" AND i.store_id=1 
GROUP BY f.title
HAVING COUNT(r.rental_id)>0;


