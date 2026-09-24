-- Add you solution queries below:

/*
	1. Write a query to display for each store its store ID, city, and country.
*/

SELECT
	s.store_id,
	c.country,
	y.city
FROM store s
LEFT JOIN address a
	ON s.address_id = a.address_id
LEFT JOIN city y
	ON a.city_id = y.city_id
LEFT JOIN country c
	ON y.country_id = c.country_id


/*
	2. Write a query to display how much business, in dollars, each store brought in.
*/

SELECT
	s.store_id,
	SUM(p.amount)
FROM store s
LEFT JOIN payment p
	ON s.manager_staff_id = p.staff_id
GROUP BY s.store_id

/*
	3. What is the average running time of films by category?
*/

SELECT 
	c.category_id,
	c.name,
	ROUND(AVG(f.length), 2) as avg_movie_length
FROM film f
LEFT JOIN film_category fc
	ON f.film_id = fc.film_id
LEFT JOIN category c
	ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name

/*
	4. Which film categories are longest?
*/

SELECT 
	c.category_id,
	c.name,
	ROUND(AVG(f.length), 2) as avg_movie_length
FROM film f
LEFT JOIN film_category fc
	ON f.film_id = fc.film_id
LEFT JOIN category c
	ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY avg_movie_length DESC

/*
	5. Display the most frequently rented movies in descending order.
*/

SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC

/*
	6. List the top five genres in gross revenue in descending order.
*/

SELECT
    c.name AS genre,
    ROUND(SUM(p.amount),2)  AS gross_revenue
FROM category c
JOIN film_category fc
    ON c.category_id = fc.category_id
JOIN film f
    ON fc.film_id = f.film_id
JOIN inventory i
    ON f.film_id = i.film_id
JOIN rental r
    ON i.inventory_id = r.inventory_id
JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY c.category_id, c.name
ORDER BY gross_revenue DESC
LIMIT 5

/*
	7. Is "Academy Dinosaur" available for rent from Store 1?
*/

SELECT
    CASE
        WHEN COUNT(*) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS availability
FROM film f
JOIN inventory i
    ON f.film_id = i.film_id
LEFT JOIN rental r
    ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL
WHERE f.title = 'Academy Dinosaur'
    AND i.store_id = 1
    AND r.rental_id IS NULL