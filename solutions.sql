-- Add you solution queries below:

1 - Write a query to display for each store its store ID, city, and country.

SELECT
  s.store_id   AS "STORE ID",
  ci.city      AS "CITY",
  co.country   AS "COUNTRY"
FROM store s
JOIN address a  ON s.address_id = a.address_id
JOIN city ci    ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
ORDER BY s.store_id;

2 - Write a query to display how much business, in dollars, each store brought in

SELECT
  s.store_id AS "STORE ID",
  ROUND(SUM(p.amount), 2) AS "TOTAL REVENUE ($)"
FROM store s
JOIN staff st  ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY s.store_id;

3 - What is the average running time of films by category?

SELECT
  c.name AS "CATEGORY",
  ROUND(AVG(f.length), 2) AS "AVERAGE LENGTH (MINUTES)"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY "AVERAGE LENGTH (MINUTES)" DESC;

4 - Which film categories are longest?

SELECT
  c.name AS "CATEGORY",
  ROUND(AVG(f.length), 2) AS "AVERAGE LENGTH (MINUTES)"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c       ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY "AVERAGE LENGTH (MINUTES)" DESC;

5 - Display the most frequently rented movies in descending order

SELECT
  f.film_id AS "FILM ID",
  f.title   AS "TITLE",
  COUNT(r.rental_id) AS "TIMES RENTED"
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY "TIMES RENTED" DESC, f.title ASC;

6 - List the top five genres in gross revenue in descending order.

SELECT
  c.name AS "CATEGORY",
  ROUND(SUM(p.amount), 2) AS "GROSS REVENUE ($)"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i      ON fc.film_id = i.film_id
JOIN rental r         ON i.inventory_id = r.inventory_id
JOIN payment p        ON r.rental_id = p.rental_id
GROUP BY c.category_id, c.name
ORDER BY "GROSS REVENUE ($)" DESC
LIMIT 5;

7 - Is "Academy Dinosaur" available for rent from Store 1?

WITH target_film AS (
  SELECT film_id
  FROM film
  WHERE title = 'Academy Dinosaur'
),
store_inventory AS (
  SELECT i.inventory_id
  FROM inventory i
  JOIN target_film tf ON i.film_id = tf.film_id
  WHERE i.store_id = 1
),
currently_rented AS (
  SELECT r.inventory_id
  FROM rental r
  WHERE r.return_date IS NULL
)
SELECT
  CASE
    WHEN EXISTS (
      SELECT 1
      FROM store_inventory si
      JOIN currently_rented cr ON si.inventory_id = cr.inventory_id
      WHERE cr.inventory_id IS NULL  
      LIMIT 1
    )
    THEN 'Yes'
    ELSE 'No'
  END AS "AVAILABLE FROM STORE 1";



