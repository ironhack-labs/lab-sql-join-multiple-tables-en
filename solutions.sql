/* 1.
SELECT
	sbs.store AS "STORE",
	s.store_id AS "STORE ID",
	ct.city AS "CITY",
	cntr.country AS "COUNTRY"
	
FROM store AS s

JOIN sales_by_store AS sbs ON sbs.store_id = s.store_id
JOIN address AS adr ON adr.address_id = s.address_id
JOIN city AS ct ON ct.city_id = adr.city_id
JOIN country AS cntr ON cntr.country_id = ct.country_id

GROUP BY s.store_id
*/

/* 2.
SELECT
	sbs.store AS "STORE",
	CONCAT(FORMAT(sbs.total_sales, 2), "$") AS "REVENUE"
	
FROM store AS s

JOIN sales_by_store AS sbs ON sbs.store_id = s.store_id
JOIN address AS adr ON adr.address_id = s.address_id
JOIN city AS ct ON ct.city_id = adr.city_id
JOIN country AS cntr ON cntr.country_id = ct.country_id

GROUP BY s.store_id
ORDER BY CAST(sbs.total_sales AS SIGNED) DESC
*/

/* 3. 4.
SELECT DISTINCT
	"category" as "GENRE",
	TIME(AVG("length")*60, "unixepoch") AS "AVG. RUNNING TIME"

FROM film_list

GROUP BY category
ORDER BY "AVG. RUNNING TIME" DESC
*/

/* 5.
SELECT DISTINCT
	f.title as "FILM",
	COUNT(r.rental_id) AS "No. of Rentals" 

FROM film as f

LEFT JOIN inventory as inv ON inv.film_id = f.film_id
LEFT JOIN rental as r ON r.inventory_id = inv.inventory_id

GROUP BY f.film_id
ORDER BY "No. of Rentals" DESC
*/

/* 6.
SELECT * FROM sales_by_film_category ORDER BY total_sales DESC LIMIT 5
*/

/* 7.
SELECT
	f.title AS "FILM",
	COUNT(inv.inventory_id) AS "No. Available"

FROM inventory AS inv

JOIN film AS f ON f.film_id = inv.film_id

WHERE f.title = "ACADEMY DINOSAUR" AND inv.store_id = 1
*/

