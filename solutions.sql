--1.
/*SELECT s.store_id as  "Store ID",  city.city as "City", co.country as "Country"
FROM store AS s
JOIN address as ad
			on s. address_id = ad.address_id
JOIN city
		   on city.city_id = ad.city_id
JOIN country as co
			on co.country_id = city.country_id;
*/

--2.
/*SELECT s.store_id as  "Store ID",  sast.total_sales as "total sales"
FROM store AS s
JOIN sales_by_store as sast
			on s. store_id = sast.store_id
*/
			
--3.
/*SELECT cat.name  as "Category", avg(f.length) as "avg of length"
From film as f
Join film_category as fcat
		on f.film_id = fcat.film_id
Join category as cat
		on cat.category_id = fcat.category_id
GROUP by category
*/

--4.-Sports are the longetst.
/*SELECT cat.name as "Category", avg(f.length) as "avg of length"
From film as f
Join film_category as fcat
		on f.film_id = fcat.film_id
Join category as cat
		on cat.category_id = fcat.category_id
GROUP by category ORDER by "avg of length" DESC
-*/

--5.
/*SELECT f.title as "Movie", count(*) as "how many times rented"
FROM film as f
JOIN inventory as inv
		on f.film_id = inv.film_id
JOIN rental as rt
		on rt.inventory_id = inv.inventory_id
GROUP by f.title order by "how many times rented" DESC 
*/

--6
/*Select cat.name as "Genre" ,sum(py.amount) as "gross revenue"
From category as cat
JOIN film_category as fc
			on fc.category_id = cat.category_id
JOIN inventory as inv
			on inv.film_id = fc.film_id
JOIN rental as re
			on re.inventory_id = inv.inventory_id
JOIN payment as py
			on py.rental_id = re.rental_id
Group by cat.name order by "gross revenue" DESC LIMIT 5
*/

--7. Yes, still 4 pieces left.
/*SELECT f.title as "Title", 
		CASE 
				WHEN count(ivt.inventory_id) >0 Then "available" ELSE "sorry not available" 
		END as "Status", 
		count(ivt.inventory_id) as "left" 
FROM film AS f
JOIN inventory AS ivt
			ON f.film_id = ivt.film_id
where f.title = "ACADEMY DINOSAUR" and ivt.store_id= 1
GROUP by f.title
*/





