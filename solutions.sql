
SELECT 
  s.store_id AS "Store ID",
  c.city AS "City",
  co.country AS "Country"
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON a.city_id = c.city_id
JOIN country AS co ON c.country_id = co.country_id;


SELECT 
  s.store_id AS "Store ID",
  SUM(p.amount) AS "Total revenue ($)"
FROM store AS s
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY "Total revenue ($)" DESC;

SELECT
  c.name as "Category",
  ROUND(AVG(f.length),2) as "Average Film Duration (minutes)"
FROM category as c
JOIN film_category as fm ON fm.category_id = c.category_id
JOIN film as f ON f.film_id = fm.film_id
GROUP BY c.name
ORDER BY "Average Film Duration (minutes)" DESC;

SELECT 
  title as "Title",
  COUNT(r.rental_id) AS "Times Rented"
FROM film as f
JOIN inventory as i ON f.film_id = i.film_id
JOIN rental as r ON i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY "Times Rented" DESC;


SELECT
  c.name AS "Category",
  ROUND(SUM(p.amount), 2) AS "Amount paid ($)"
FROM category AS c
JOIN film_category AS fc ON fc.category_id = c.category_id
JOIN inventory AS i ON i.film_id = fc.film_id
JOIN rental AS r ON r.inventory_id = i.inventory_id
JOIN payment AS p ON p.rental_id = r.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;


SELECT 
s.store_id,
f.title
FROM store as s
JOIN inventory as i on i.store_id = s.store_id
JOIN film as f on f.film_id = i.film_id
WHERE f.title LIKE "ACADEMY DINOSAUR"