-- Add you solution queries below:
## Instructions

-- 1. Write a query to display for each store its store ID, city, and country.
-- 2. Write a query to display how much business, in dollars, each store brought in.
-- 3. What is the average running time of films by category?
-- 4. Which film categories are longest?
-- 5. Display the most frequently rented movies in descending order.
-- 6. List the top five genres in gross revenue in descending order.
-- 7. Is "Academy Dinosaur" available for rent from Store 1?



SELECT
    store.store_id,
    city.city,
    country.country
FROM store

INNER JOIN address
    ON address.address_id = store.address_id

INNER JOIN city
    ON address.city_id = city.city_id

INNER JOIN country
    ON city.country_id = country.country_id;




-- Exercise 2: Revenue by store
SELECT
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM store AS s
JOIN staff AS st ON s.store_id = st.store_id
JOIN payment AS p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY total_revenue DESC;

-- Exercise 3: Average film duration by category
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name;

-- Exercise 4: Longest film categories by average length
SELECT
    c.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN film AS f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_length_minutes DESC;

-- Exercise 5: Most frequently rented movies
SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC;

-- Exercise 6: Top five genres by gross revenue
SELECT
    c.name AS category,
    ROUND(SUM(p.amount), 2) AS gross_revenue
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN inventory AS i ON fc.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.category_id, c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- Exercise 7: Is Academy Dinosaur available at Store 1?
SELECT
    f.title,
    COUNT(i.inventory_id) AS total_copies,
    SUM(CASE
        WHEN i.inventory_id IS NOT NULL
         AND NOT EXISTS (
            SELECT 1
            FROM rental AS r
            WHERE r.inventory_id = i.inventory_id
              AND r.return_date IS NULL
         )
        THEN 1 ELSE 0
    END) AS available_copies
FROM film AS f
LEFT JOIN inventory AS i
    ON f.film_id = i.film_id
    AND i.store_id = 1
WHERE f.title = 'ACADEMY DINOSAUR'
GROUP BY f.film_id, f.title;
  




