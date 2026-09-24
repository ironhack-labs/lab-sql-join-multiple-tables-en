SELECT
s.store_id AS "STORE ID",
c.city AS "CITY",
co.country AS "COUNTRY"
FROM store AS s
JOIN address AS a
ON s.address_id = a.address_id
JOIN city AS c
ON a.city_id = c.city_id
JOIN country AS co
ON c.country_id = co.country_id
ORDER BY s.store_id;

SELECT
s.store_id AS "STORE ID",
ROUND(SUM(p.amount), 2) AS "TOTAL REVENUE"
FROM store AS s
JOIN staff AS st
ON s.store_id = st.store_id
JOIN payment AS p
ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY s.store_id;

SELECT
c.name AS "CATEGORY",
ROUND(AVG(f.length), 2) AS "AVERAGE LENGTH"
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY c.name;

SELECT
c.name AS "CATEGORY",
ROUND(AVG(f.length), 2) AS "AVERAGE LENGTH"
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY "AVERAGE LENGTH" DESC;

SELECT
f.title AS "MOVIE",
COUNT(r.rental_id) AS "RENTAL COUNT"
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY "RENTAL COUNT" DESC;

SELECT
c.name AS "CATEGORY",
ROUND(SUM(p.amount), 2) AS "GROSS REVENUE"
FROM category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN inventory AS i
ON fc.film_id = i.film_id
JOIN rental AS r
ON i.inventory_id = r.inventory_id
JOIN payment AS p
ON r.rental_id = p.rental_id
GROUP BY c.category_id, c.name
ORDER BY "GROSS REVENUE" DESC
LIMIT 5;

SELECT
f.title AS "MOVIE",
i.inventory_id AS "INVENTORY ID"
FROM film AS f
JOIN inventory AS i
ON f.film_id = i.film_id
LEFT JOIN rental AS r
ON i.inventory_id = r.inventory_id
AND r.return_date IS NULL
WHERE UPPER(f.title) = 'ACADEMY DINOSAUR'
AND i.store_id = 1
AND r.rental_id IS NULL;
