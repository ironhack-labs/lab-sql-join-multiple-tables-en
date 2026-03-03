/* Part 1 */
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

/* Part 2 */
SELECT s.store_id, SUM(p.amount) AS total_business
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

/* Part 3 */
SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

/* Part 4 */
SELECT c.name AS category, AVG(f.length) AS avg_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY avg_running_time DESC;

/* Part 5 */
SELECT f.title, COUNT(r.rental_id) AS rental_frequency
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_frequency DESC;

/* Part 6 */
SELECT c.name AS genre, SUM(p.amount) AS gross_revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY gross_revenue DESC
LIMIT 5;

/* Part 7 */
SELECT f.title, i.store_id, COUNT(i.inventory_id) AS copies_in_stock
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'ACADEMY DINOSAUR' AND i.store_id = 1;
