-- Write a query to display for each store its store ID, city, and country.
SELECT
	s.store_id as "Store ID",
	c.city as "City",
	co.country as "Country"
FROM
	store as s
JOIN address as a on s.address_id = a.address_id
JOIN city as c on c.city_id = a.city_id
join country as co on co.country_id = c.country_id;
-- Write a query to display how much business, in dollars, each store brought in.
SELECT
  s.store_id as "Store ID", 
  c.city||','||cy.country AS "Store",
  SUM(p.amount) as "Businnes ($)"
FROM payment as p
JOIN rental as r on p.rental_id = r.rental_id
JOIN inventory as i on r.inventory_id = i.inventory_id
JOIN store as s on i.store_id = s.store_id
JOIN address as a on s.address_id = a.address_id
JOIN city as c on a.city_id = c.city_id
JOIN country as cy on c.country_id = cy.country_id
GROUP BY  
  s.store_id, "Store";
-- What is the average running time of films by category?
SELECT
	c.name as "Category",
	avg(f.length) as "Average running time"
FROM category as c
JOIN film_category as fc on fc.category_id = c.category_id
JOIN film as f on f.film_id = fc.film_id
group by c.name;
--Which film categories are longest?
SELECT
	c.name as "Category",
	sum(f.length) as "Longest running time"
FROM category as c
JOIN film_category as fc on fc.category_id = c.category_id
JOIN film as f on f.film_id = fc.film_id
group by c.name
order by sum(f.length) DESC;
-- Display the most frequently rented movies in descending order.
SELECT
	f.title as "Movie",
	count(r.inventory_id) as "Times Rented"
from film as f
left join inventory as i on i.film_id = f.film_id
left JOIN rental as r on r.inventory_id = i.inventory_id
group by f.film_id, f.title
ORDER by "Times Rented" DESC;
--- List the top five genres in gross revenue in descending order.
SELECT
	c.name as category, SUM(p.amount) as total_sales
FROM payment as p
JOIN rental as r on p.rental_id = r.rental_id
JOIN inventory as i on r.inventory_id = i.inventory_id
JOIN film as f on i.film_id = f.film_id
JOIN film_category as fc on f.film_id = fc.film_id
JOIN category as c on fc.category_id = c.category_id
GROUP BY c.name
order by total_sales DESC
limit 5;
-- Is "Academy Dinosaur" available for rent from Store 1?
SELECT
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM inventory i
            LEFT JOIN rental r
                ON r.inventory_id = i.inventory_id
               AND r.return_date IS NULL
            JOIN film f
                ON f.film_id = i.film_id
            WHERE f.title = 'Academy Dinosaur'
              AND i.store_id = 1
              AND r.rental_id IS NULL
        )
        THEN 'Yes'
        ELSE 'No'
    END AS Available;