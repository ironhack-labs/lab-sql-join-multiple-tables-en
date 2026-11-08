-- 1. Display each store's ID, city, and country.
SELECT
    s.store_id,
    ci.city,
    co.country
FROM store AS s
JOIN address AS a
    ON s.address_id = a.address_id
JOIN city AS ci
    ON a.city_id = ci.city_id
JOIN country AS co
    ON ci.country_id = co.country_id
ORDER BY s.store_id;

-- 2. Display the business, in dollars, brought in by each store.
SELECT
    s.store_id,
    SUM(p.amount) AS total_business_dollars
FROM store AS s
JOIN staff AS st
    ON st.store_id = s.store_id
JOIN payment AS p
    ON p.staff_id = st.staff_id
GROUP BY s.store_id
ORDER BY s.store_id;

-- 3. Display the average film running time by category.
SELECT
    c.name AS category,
    AVG(f.length) AS average_running_time_minutes
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY c.name;

-- 4. List film categories from the longest average running time to the shortest.
SELECT
    c.name AS category,
    AVG(f.length) AS average_running_time_minutes
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN film AS f
    ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY average_running_time_minutes DESC;

-- 5. Display movies by rental frequency, from most to least rented.
SELECT
    f.title,
    COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i
    ON f.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC, f.title;

-- 6. List the five highest-grossing genres.
SELECT
    c.name AS genre,
    SUM(p.amount) AS gross_revenue
FROM category AS c
JOIN film_category AS fc
    ON c.category_id = fc.category_id
JOIN inventory AS i
    ON fc.film_id = i.film_id
JOIN rental AS r
    ON i.inventory_id = r.inventory_id
JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY c.category_id, c.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 7. Check whether at least one copy of "Academy Dinosaur" is available at Store 1.
SELECT
    'Academy Dinosaur' AS title,
    1 AS store_id,
    CASE
        WHEN EXISTS (
            SELECT 1
            FROM film AS f
            JOIN inventory AS i
                ON i.film_id = f.film_id
            WHERE f.title = 'Academy Dinosaur'
              AND i.store_id = 1
              AND NOT EXISTS (
                  SELECT 1
                  FROM rental AS r
                  WHERE r.inventory_id = i.inventory_id
                    AND r.return_date IS NULL
              )
        ) THEN 'Yes'
        ELSE 'No'
    END AS available_for_rent;
