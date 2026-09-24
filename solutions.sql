-- QUERY 1
-- SELECT 
-- 	sto.store_id,
-- 	ci.city,
-- 	co.country
-- FROM address AS ad
-- LEFT JOIN store AS sto
-- 	ON ad.address_id = sto.address_id
-- INNER JOIN city AS ci
-- 	ON ad.city_id = ci.city_id
-- INNER JOIN country AS co
-- 	ON ci.country_id = co.country_id
-- 	
SELECT 
	ad.address_id AS `STORE ID`,
	ci.city AS `CITY`,
	co.country AS `COUNTRY`
FROM address AS ad
INNER JOIN city AS ci
	ON ad.city_id = ci.city_id
INNER JOIN country AS co
	ON ci.country_id = co.country_id

-- QUERY 2
SELECT 
	ad.address AS `ADDRESS`,
	IFNULL(SUM(p.amount),0) AS `BUSINESS`
FROM address AS ad
LEFT JOIN customer AS cu
	ON ad.address_id = cu.address_id
LEFT JOIN payment AS p
	ON cu.customer_id = p.customer_id
GROUP BY	`ADDRESS`

-- QUERY 3
SELECT 
	ca.name AS `CATEGORY`,
	ROUND(AVG(f.length),2) AS `AVERAGE LENGTH (MIN)`
FROM category AS ca
LEFT JOIN film_category AS fc
	ON ca.category_id = fc.category_id
LEFT JOIN film AS f
	ON fc.film_id = f.film_id
GROUP BY `CATEGORY`

-- QUERY 4
SELECT 
	ca.name AS `CATEGORY`,
	COUNT(*) AS `TOTAL TITLES`
FROM category AS ca
LEFT JOIN film_category AS fc
	ON ca.category_id = fc.category_id
LEFT JOIN film AS f
	ON fc.film_id = f.film_id
GROUP BY `CATEGORY`
ORDER BY `TOTAL TITLES` DESC
LIMIT 1

-- QUERY 5
SELECT 
	f.title AS TITLE,
	COUNT(*) AS `TOTAL RENTALS`
FROM film AS f
LEFT JOIN inventory AS i
	ON f.film_id = i.film_id
LEFT JOIN rental AS r
	ON i.inventory_id = r.inventory_id
GROUP BY TITLE
ORDER BY `TOTAL RENTALS` DESC

-- QUERY 6
SELECT 
	ca.name AS `CATEGORY`,
	SUM(p.amount) AS `GROSS REVENUE ($)`
FROM category AS ca
LEFT JOIN film_category AS fc
	ON ca.category_id = fc.category_id
LEFT JOIN film AS f
	ON fc.film_id = f.film_id
LEFT JOIN inventory AS i
	ON f.film_id = i.film_id
LEFT JOIN rental AS r
	ON i.inventory_id = r.inventory_id
LEFT JOIN payment as p
	ON r.rental_id = p.rental_id
GROUP BY `CATEGORY`
ORDER BY `GROSS REVENUE ($)` DESC
LIMIT 5

-- QUERY 7
SELECT 
	f.title AS TITLE,
	cu.address_id
FROM film AS f
LEFT JOIN inventory AS i
	ON f.film_id = i.film_id
LEFT JOIN rental AS r
	ON i.inventory_id = r.inventory_id
LEFT JOIN	customer as cu
	ON r.customer_id = cu.customer_id
LEFT JOIN address as ad
	ON cu.address_id = ad.address_id
	WHERE f.title = 'ACADEMY DINOSAUR'  AND ad.address_id = 1
