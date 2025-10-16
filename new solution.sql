SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

SELECT s.store_id, sum(p.amount) AS total_sales
FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id;

SELECT c.name AS category, avg(f.length) AS avg_runtime
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP by c.name;

SELECT c.name as category, Avg(f.length) as avg_runtime
FROM film f
JOIN film_category fc on f.film_id = fc.film_id
JOIN category c on fc.category_id = c.category_id
GROUP by c.name
ORDER by avg_runtime DESC;

SELECT f.title, count(r.rental_id) as rental_count
FROM film f
JOIN inventory i on f.film_id = i.film_id
JOIN rental r on i.inventory_id = r.inventory_id
GROUP by f.title
ORDER by rental_count DESC;


SELECT c.name AS category, SUM(p.amount) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_revenue DESC
LIMIT 5;

SELECT
    f.title,
	i.inventory_id,
	i.store_id,
	ifnull(r.rental_id, 'available') as status
FROM film f
JOIN inventory i on f.film_id = i.film_id
LEFT JOIN rental r on i.inventory_id = r.inventory_id AND r.return_date is NULL
WHERE f.title = 'academy dinosaur' AND i.store_id = 1 AND r.rental_id is NULL;