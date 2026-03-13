1. Write a query to display for each store its store ID, city, and country.

SELECT
    s.store_id AS "Store ID",
    c.city AS "City",
    t.country AS "Country"
FROM store as s
JOIN address as a ON s.address_id = a.address_id
JOIN city as c ON a.city_id = c.city_id
JOIN country as t ON c.country_id = t.country_id;

2. Write a query to display how much business, in dollars, each store brought in.

SELECT
    s.store_id AS "Store ID",
    SUM(p.amount) AS "Total Business ($)"
FROM store as s
JOIN staff as st ON s.store_id = st.store_id
JOIN payment as p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY "Total Business($)" DESC;

3. What is the average running time of films by category?

SELECT
    c.name AS "Category",
    AVG(f.length) AS "Average Running Time"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY "Average Running Time" DESC;

4. Which film categories are longest?

SELECT
    c.name AS "Category",
    AVG(f.length) AS "Average Length"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY "Average Length" DESC;

5. Display the most frequently rented movies in descending order.

SELECT
    f.title AS "Movie",
    COUNT(r.rental_id) AS "Times Rented"
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY "Times Rented" DESC;

6. List the top five genres in gross revenue in descending order.

SELECT
    c.name AS "Genre",
    SUM(p.amount) AS "Gross Revenue"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY "Gross Revenue" DESC
LIMIT 5;

7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT
    f.title,
    i.store_id,
    COUNT(i.inventory_id) AS available_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    AND r.return_date IS NULL
WHERE
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1
    AND r.rental_id IS NULL
GROUP BY f.title, i.store_id;