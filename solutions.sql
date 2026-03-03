-- QUERY 1
SELECT
	s.store_id AS STORE_ID,
	ci.city AS CITY,
	co.country AS COUNTRY
FROM store s
JOIN `address` a
	ON s.address_id = a.address_id
JOIN city ci
	ON a.city_id = ci.city_id
JOIN country co
	ON ci.country_id = co.country_id;

-- QUERY 2
SELECT
	s.store_id AS `STORE`,
	SUM(p.amount) AS `TOTAL_SALES_$`
FROM staff s
JOIN payment p
	ON s.staff_id = p.staff_id
GROUP BY `STORE`;


-- QUERY 3
SELECT
	c.name AS `CATEGORY`,
	ROUND(AVG(f.`length`), 2) AS AVERAGE_RUNNING_TIME
FROM film_category fc
JOIN film f
	ON fc.film_id = f.film_id
JOIN category c
	ON fc.category_id = c.category_id
GROUP BY `CATEGORY`;


-- QUERY 4
SELECT
	c.name AS `CATEGORY`,
	SUM(f.`length`) AS TOTAL_RUNNING_TIME
FROM film_category fc
JOIN film f
	ON fc.film_id = f.film_id
JOIN category c
	ON fc.category_id = c.category_id
GROUP BY `CATEGORY`
ORDER BY TOTAL_RUNNING_TIME DESC
LIMIT 5;


-- QUERY 5
SELECT
	f.title AS `FILM`,
	COUNT(*) AS TIMES_RENTED
FROM film f
JOIN inventory i
	ON f.film_id = i.film_id
JOIN rental r
	ON i.inventory_id = r.inventory_id
GROUP BY `FILM`
ORDER BY TIMES_RENTED DESC
LIMIT 5;


-- QUERY 6
SELECT
	c.name AS `CATEGORY`,
	SUM(p.amount) AS `GROSS_REVENUE_$`
FROM film_category fc
JOIN category c
	ON fc.category_id = c.category_id
JOIN inventory i
	ON fc.film_id = i.film_id
JOIN rental r
	ON i.inventory_id = r.inventory_id
JOIN payment p
	ON r.rental_id = p.rental_id
GROUP BY `CATEGORY`
ORDER BY `GROSS_REVENUE_$` DESC
LIMIT 5;


-- QUERY 7
SELECT
  f.title,
  CASE
    WHEN SUM(CASE WHEN r.rental_id IS NULL OR r.return_date IS NOT NULL THEN 1 ELSE 0 END) > 0
      THEN 'Yes' ELSE 'No'
  END AS available
FROM film f
JOIN inventory i
  ON f.film_id = i.film_id
LEFT JOIN rental r
  ON i.inventory_id = r.inventory_id
  AND r.rental_date = (
    SELECT MAX(rr.rental_date)
    FROM rental rr
    WHERE rr.inventory_id = i.inventory_id
	)
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1
GROUP BY f.title;
