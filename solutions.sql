-- Add you solution queries below:

-- 1
SELECT s.store_id AS "STORE ID", ci.city AS "CITY", co.country AS "COUNTRY"
FROM store AS s
JOIN address AS a ON a.address_id = s.address_id
JOIN city AS ci ON a.city_id = ci.city_id
JOIN country AS co ON ci.country_id = co.country_id;

-- 2
SELECT s.store_id AS "STORE ID", SUM(p.amount) AS "TOTAL"
FROM payment AS p
JOIN staff ON p.staff_id = staff.staff_id
JOIN store AS s ON s.store_id = staff.store_id
GROUP BY "STORE ID";

-- 3
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name;

-- 4
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_length
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY avg_length DESC
LIMIT 3;
-- Sports, Games and Foreign movies have the longest average run times.

-- 5
SELECT f.title AS "TITLE", COUNT(*) AS "TIMES RENTED"
FROM rental AS r
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY "TIMES RENTED" DESC;

-- 6
SELECT c.name AS "GENRE", SUM(p.amount) AS "REVENUE"
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN inventory AS i ON fc.film_id = i.film_id
JOIN rental AS r ON r.inventory_id = i.inventory_id
JOIN payment AS p ON p.rental_id = r.rental_id
GROUP BY "GENRE"
ORDER BY "REVENUE" DESC
LIMIT 5;

-- 7
SELECT *
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
WHERE f.title == "Academy Dinosaur" AND i.store_id == 1;
-- No, Academy Dinosaur is not available at Store 1 as it is not in the store's inventory.