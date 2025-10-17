SELECT 
    s.store_id AS "Store ID",
    c.city_id AS "City",
    co.country AS "Country"
FROM store AS s
JOIN address AS a ON s.address_id = a.address_id
JOIN city AS c ON a.city_id = c.city_id
JOIN country AS co ON c.country_id = co.country_id;


SELECT 
   sbs.store AS "STORE",
   sbs.total_sales AS "Business"
FROM sales_by_store AS sbs;


SELECT 
   c.name as "category",
   ROUND(AVG(f.length), 2) as "average running time"
From film as f
JOIN film_category as fc On f.film_id = fc.film_id
JOIN category as c on fc.category_id = c.category_id
group by category;


SELECT 
   c.name as "category",
   ROUND(AVG(f.length), 2) as "average running time"
From film as f
JOIN film_category as fc On f.film_id = fc.film_id
JOIN category as c on fc.category_id = c.category_id
group by category
order by ROUND(AVG(f.length), 2) DESC;


SELECT 
   f.film_id as "ID",
   f.title as "FILM TITLE",
   count(r.rental_id) as "renting times"
FROM film as f
JOIN inventory as i on f.film_id = i.film_id
JOIN rental as r on i.inventory_id = r.inventory_id
group by 
   f.film_id,
   f.title
ORDER BY COUNT(r.rental_id) DESC;

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