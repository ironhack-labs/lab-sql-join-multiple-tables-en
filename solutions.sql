-- 1. Write a query to display for each store its store ID, city, and country.
-- Joining stores with addresses, cities, and countries to get the location details for each store.
SELECT 
    s.store_id,
    ci.city,
    co.country
FROM 
    store s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    country co ON ci.country_id = co.country_id
ORDER BY 
    s.store_id;  -- Just to keep it neat, sorted by store ID.

-- 2. Write a query to display how much business, in dollars, each store brought in.
-- Summing up total rental amounts per store, considering all rentals linked to customers and stores.
SELECT 
    s.store_id,
    ROUND(SUM(p.amount), 2) AS total_revenue  -- Rounding to 2 decimals for that clean dollar look.
FROM 
    store s
JOIN 
    customer c ON s.store_id = c.store_id
JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    s.store_id
ORDER BY 
    total_revenue DESC;  -- Descending to see the top earner first – who's the MVP store?

-- 3. What is the average running time of films by category?
-- Grouping films by category and averaging their lengths – like checking average movie marathon times per genre.
SELECT 
    cat.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length_minutes  -- Rounding for readability; minutes make sense for run times.
FROM 
    category cat
JOIN 
    film_category fc ON cat.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    cat.category_id, cat.name
ORDER BY 
    avg_length_minutes DESC;  -- Sorted descending to spot the longest averages at the top.

-- 4. Which film categories are longest?
-- This builds on #3 but just grabs the top 5 longest by average runtime – no need to rewrite the wheel!
-- (If you want all, run #3; this is for the "longest" spotlight.)
SELECT 
    cat.name AS category,
    ROUND(AVG(f.length), 2) AS avg_length_minutes
FROM 
    category cat
JOIN 
    film_category fc ON cat.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
GROUP BY 
    cat.category_id, cat.name
ORDER BY 
    avg_length_minutes DESC
LIMIT 5;  -- Top 5 to keep it snappy – because who has time for all categories?

-- 5. Display the most frequently rented movies in descending order.
-- Counting rental counts per film, joining through inventory – the crowd-pleasers get the crown!
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count  -- Raw count of how many times it's been checked out.
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    rental_count DESC
LIMIT 10;  -- Limiting to top 10 for focus, but you can remove if you want the full leaderboard.

-- 6. List the top five genres in gross revenue in descending order.
-- Aggregating payment totals per category via the rental chain – where the money's at in genres!
SELECT 
    cat.name AS genre,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM 
    category cat
JOIN 
    film_category fc ON cat.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    cat.category_id, cat.name
ORDER BY 
    total_revenue DESC
LIMIT 5;  -- Top 5 cash cows – cha-ching for these categories!

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
-- Checking if any copy of this film is still available (not rented out) at Store 1 – green light or red?
SELECT 
    f.title,
    i.inventory_id,
    CASE 
        WHEN r.rental_id IS NULL THEN 'Yes, available!'
        ELSE 'No, currently rented out.'
    END AS availability_status
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
LEFT JOIN 
    rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL  -- Only current rentals (no return date).
WHERE 
    f.title = 'Academy Dinosaur'
    AND i.store_id = 1  -- Specific to Store 1.
    AND r.rental_date IS NULL;  -- Actually, to check availability, look for inventories without any active rental.
-- Wait, tweak: Better to use LEFT JOIN and check for NULL on rental.rental_id to see unrented copies.
-- If rows return with 'Yes', it's available; if none, then no copies free.
-- Run this and see: If output shows any 'Yes', bingo!