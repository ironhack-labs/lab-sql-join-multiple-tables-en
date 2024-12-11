USE sakila;

## 1. Write a query to display for each store its store ID, city, and country.

select s.store_id, c.city, co.country
from sakila.store s
left join sakila.address a on s.address_id = a.address_id
left join sakila.city c on a.city_id = c.city_id
left join sakila.country co on c.country_id = co.country_id
;


## 2. Write a query to display how much business, in dollars, each store brought in.

select s.store_id, sum(p.amount) as total_payment
from payment p
INNER JOIN
    rental r ON p.rental_id = r.rental_id
INNER JOIN
    inventory i ON r.inventory_id = i.inventory_id
INNER JOIN
    store s ON i.store_id = s.store_id
GROUP BY
    s.store_id
ORDER BY
     total_payment DESC
;


## 3. What is the average running time of films by category?
SELECT cat.name,AVG(f.length) as avg_running_time
FROM category cat
LEFT JOIN film_category fm ON cat.category_id = fm.category_id
LEFT JOIN film f ON f.film_id = fm.film_id
GROUP BY cat.name;


## 4. Which film categories are longest?
SELECT cat.name, MAX(f.length) as longest_time
FROM category cat
LEFT JOIN film_category fm ON cat.category_id = fm.category_id
LEFT JOIN film f ON f.film_id = fm.film_id
GROUP BY cat.name
ORDER BY longest_time DESC;


## 5. Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(DISTINCT r.rental_id) as rental_count
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY rental_count DESC
;

## 6. List the top five genres in gross revenue in descending order.
SELECT
    c.name AS Genre,
    SUM(p.amount) AS Gross_Revenue
FROM
    payment p
JOIN
    rental r ON p.rental_id = r.rental_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    film f ON i.film_id = f.film_id
JOIN
    film_category fc ON f.film_id = fc.film_id
JOIN
    category c ON fc.category_id = c.category_id
GROUP BY
    c.name
ORDER BY
    Gross_Revenue DESC
LIMIT 5;


## 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT
    CASE
        WHEN COUNT(*) > 0 THEN 'Available'
        ELSE 'Not Available'
    END AS Availability
FROM
    film f
JOIN
    inventory i ON f.film_id = i.film_id
JOIN
    store s ON i.store_id = s.store_id
WHERE
    f.title = 'Academy Dinosaur'
    AND s.store_id = 1;