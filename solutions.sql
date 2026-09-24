/*1. Write a query to display for each store its store ID, city, and country.*/
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
    ON c.country_id = co.country_id;

JOIN 
/*2. Write a query to display how much business, in dollars, each store brought in.*/
SELECT
    s.store_id AS "STORE ID",
    SUM(p.amount) AS "TOTAL REVENUE $"

FROM store AS s

JOIN staff AS st
    ON s.store_id = st.store_id

JOIN payment AS p
    ON st.staff_id = p.staff_id

GROUP BY s.store_id
	
/*3. What is the average running time of films by category?*/
SELECT
	c.name AS "CATEGORY",
	AVG(f.length) AS "AVG LENGHT",
	fm.category_id AS "CATEGORY ID"
FROM film AS f

JOIN film_category AS fm
	ON f.film_id = fm.film_id

JOIN category AS c
	ON fm.category_id = c.category_id

GROUP BY fm.category_id
/*4. Which film categories are longest?*/
SELECT
    c.name AS "CATEGORY",
    AVG(f.length) AS "AVERAGE LENGHT"

FROM category AS c

JOIN film_category AS fc
    ON c.category_id = fc.category_id

JOIN film AS f
    ON fc.film_id = f.film_id

GROUP BY c.category_id, c.name

ORDER BY AVG(f.length) DESC

LIMIT 3;
/*5. Display the most frequently rented movies in descending order.*/
SELECT 
	f.title AS "MOVIE",
	SUM(r.rental_id) AS "NUMBER OF RENTALS"

FROM film as f

JOIN inventory as i
		ON f.film_id = i.film_id
JOIN rental as r
	ON i.inventory_id = r.inventory_id
	
GROUP BY f.film_id, f.title

ORDER BY "NUMBER OF RENTALS" DESC;

/*6. List the top five genres in gross revenue in descending order.*/
SELECT c.name AS "GENRE",
	SUM(p.amount) AS "GROSS REVENUE ($)"
FROM category as c

JOIN film_category as fc
	ON c.category_id = fc.category_id

JOIN inventory AS i
    ON fc.film_id = i.film_id

JOIN rental AS r
    ON i.inventory_id = r.inventory_id

JOIN payment AS p
    ON r.rental_id = p.rental_id

GROUP BY c.category_id, c.name

ORDER BY SUM(p.amount) DESC

LIMIT 5; 

/*7. Is "Academy Dinosaur" available for rent from Store 1?*/
SELECT
    f.title AS "MOVIE",
    i.store_id AS "STORE ID",
    i.inventory_id AS "COPY ID",
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM rental AS r
            WHERE r.inventory_id = i.inventory_id
              AND r.return_date IS NULL
        )
        THEN 'Rented out'
        ELSE 'Available'
    END AS "STATUS"

FROM film AS f

JOIN inventory AS i
    ON f.film_id = i.film_id

WHERE f.title = 'ACADEMY DINOSAUR'
    AND i.store_id = 1;
	