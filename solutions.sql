-- Add you solution queries below:
/*1*/
SELECT s.store_id, c.city, co.country
FROM 'store' as s

LEFT JOIN address AS a
ON s.address_id=a.address_id

INNER JOIN city as c
on a.city_id=c.city_id

INNER JOIN country as co
ON c.country_id=co.country_id

/*2*/

SELECT s.store_id, sum(p.amount) as Total_amount
FROM 'store' as s

LEFT JOIN customer as c
on s.store_id=c.store_id

LEFT JOIN payment as p
on c.customer_id=p.customer_id

GROUP by s.store_id

/*3*/

SELECT C.name, AVG(F.length) AS DURATION_AVG
FROM category AS C
LEFT JOIN film_category AS FC
ON C.category_id=FC.category_id
LEFT JOIN film AS F
ON FC.film_id=F.film_id
GROUP BY C.name

/*4*/

SELECT C.name, AVG(F.length) AS DURATION_AVG
FROM category AS C

LEFT JOIN film_category AS FC
ON C.category_id=FC.category_id

LEFT JOIN film AS F
ON FC.film_id=F.film_id

GROUP BY C.name

ORDER BY DURATION_AVG DESC
LIMIT 1

/*5*/

SELECT F.title, COUNT(R.RENTAL_ID) AS COUNT_RENT
FROM FILM AS F
LEFT JOIN inventory I
ON F.film_id=I.film_id
LEFT JOIN rental AS R
ON I.inventory_id=R.inventory_id
GROUP BY F.title
ORDER BY COUNT_RENT DESC

/*6*/

SELECT C.name, SUM(P.AMOUNT) AS GROSS_REVENUE
FROM CATEGORY AS C

LEFT JOIN film_category AS FC
ON C.category_id=FC.category_id

LEFT JOIN FILM AS F
ON FC.film_id=F.film_id

LEFT JOIN inventory AS I
ON F.film_id=I.film_id

LEFT JOIN rental AS R
ON I.inventory_id=R.inventory_id

LEFT JOIN payment AS P
ON R.rental_id=P.rental_id

GROUP BY C.name
ORDER BY GROSS_REVENUE DESC
LIMIT 5

/*7*/

SELECT f.title, i.store_id
FROM film AS f

JOIN inventory AS i
ON f.film_id = i.film_id

LEFT JOIN rental AS r
ON i.inventory_id = r.inventory_id
AND r.return_date IS NULL

WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1
AND r.rental_id IS NULL







