-- 1. For each store: store ID, city, country
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
ORDER BY s.store_id;

-- 2. How much business, in dollars, each store brought in
SELECT s.store_id, ROUND(SUM(p.amount), 2) AS gross_revenue
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY s.store_id;

-- 3. Average running time of films by category
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_runtime
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_runtime DESC;

-- 4. Which film categories are longest
SELECT c.name AS category, ROUND(AVG(f.length), 2) AS avg_runtime
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY avg_runtime DESC;

-- 5. Most frequently rented movies in descending order
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC, f.title;

-- 6. Top five genres in gross revenue, descending
SELECT c.name AS genre, ROUND(SUM(p.amount), 2) AS gross_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.category_id, c.name
ORDER BY gross_revenue DESC, c.name
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT f.title,
       i.store_id,
       COUNT(*) AS available_copies
FROM inventory i
JOIN film f ON i.film_id = f.film_id
LEFT JOIN rental r
  ON i.inventory_id = r.inventory_id
 AND r.return_date IS NULL
WHERE f.title = 'ACADEMY DINOSAUR'
  AND i.store_id = 1
  AND r.rental_id IS NULL
GROUP BY f.title, i.store_id;
