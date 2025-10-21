<?xml version="1.0" encoding="UTF-8"?><sqlb_project><db path="sqlite-sakila.db" readonly="0" foreign_keys="1" case_sensitive_like="0" temp_store="0" wal_autocheckpoint="1000" synchronous="2"/><attached/><window><main_tabs open="structure browser pragmas query" current="3"/></window><tab_structure><column_width id="0" width="300"/><column_width id="1" width="0"/><column_width id="2" width="100"/><column_width id="3" width="5544"/><column_width id="4" width="0"/><expanded_item id="0" parent="1"/><expanded_item id="1" parent="0"/><expanded_item id="1" parent="1"/><expanded_item id="2" parent="1"/><expanded_item id="3" parent="1"/></tab_structure><tab_browse><table title="store" custom_title="0" dock_id="1" table="4,5:mainstore"/><dock_state state="000000ff00000000fd00000001000000020000015c000002bcfc0100000001fb000000160064006f0063006b00420072006f007700730065003101000000000000015c0000010100ffffff0000015c0000000000000004000000040000000800000008fc00000000"/><default_encoding codec=""/><browse_table_settings><table schema="main" name="actor" show_row_id="0" encoding="" plot_x_axis="" unlock_view_pk="_rowid_" freeze_columns="0"><sort/><column_widths><column index="1" value="62"/><column index="2" value="84"/><column index="3" value="91"/><column index="4" value="113"/></column_widths><filter_values/><conditional_formats/><row_id_formats/><display_formats/><hidden_columns/><plot_y_axes/><global_filter/></table><table schema="main" name="address" show_row_id="0" encoding="" plot_x_axis="" unlock_view_pk="_rowid_" freeze_columns="0"><sort/><column_widths><column index="1" value="80"/><column index="2" value="212"/><column index="3" value="69"/><column index="4" value="55"/><column index="5" value="53"/><column index="6" value="88"/><column index="7" value="49"/><column index="8" value="113"/></column_widths><filter_values/><conditional_formats/><row_id_formats/><display_formats/><hidden_columns/><plot_y_axes/><global_filter/></table><table schema="main" name="city" show_row_id="0" encoding="" plot_x_axis="" unlock_view_pk="_rowid_" freeze_columns="0"><sort/><column_widths><column index="1" value="52"/><column index="2" value="147"/><column index="3" value="79"/><column index="4" value="113"/></column_widths><filter_values/><conditional_formats/><row_id_formats/><display_formats/><hidden_columns/><plot_y_axes/><global_filter/></table><table schema="main" name="country" show_row_id="0" encoding="" plot_x_axis="" unlock_view_pk="_rowid_" freeze_columns="0"><sort/><column_widths><column index="1" value="78"/><column index="2" value="195"/><column index="3" value="113"/></column_widths><filter_values/><conditional_formats/><row_id_formats/><display_formats/><hidden_columns/><plot_y_axes/><global_filter/></table><table schema="main" name="staff" show_row_id="0" encoding="" plot_x_axis="" unlock_view_pk="_rowid_" freeze_columns="0"><sort/><column_widths><column index="1" value="59"/><column index="2" value="79"/><column index="3" value="76"/><column index="4" value="82"/><column index="5" value="55"/><column index="6" value="156"/><column index="7" value="63"/><column index="8" value="48"/><column index="9" value="73"/><column index="10" value="255"/><column index="11" value="113"/></column_widths><filter_values/><conditional_formats/><row_id_formats/><display_formats/><hidden_columns/><plot_y_axes/><global_filter/></table><table schema="main" name="store" show_row_id="0" encoding="" plot_x_axis="" unlock_view_pk="_rowid_" freeze_columns="0"><sort><column index="0" mode="1"/></sort><column_widths><column index="1" value="62"/><column index="2" value="124"/><column index="3" value="82"/><column index="4" value="113"/></column_widths><filter_values/><conditional_formats/><row_id_formats/><display_formats/><hidden_columns/><plot_y_axes/><global_filter/></table></browse_table_settings></tab_browse><tab_sql><sql name="SQL 1">-- 1. Write a query to display for each store its store ID, city, and country.
SELECT 
    s.store_id AS 'STORE ID',
    c.city AS 'CITY',
    co.country AS 'COUNTRY'
FROM store s
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT 
    s.store_id AS 'STORE ID',
    SUM(p.amount) AS 'TOTAL REVENUE'
FROM store s
INNER JOIN staff st ON s.store_id = st.store_id
INNER JOIN payment p ON st.staff_id = p.staff_id
GROUP BY s.store_id
ORDER BY s.store_id;

-- 3. What is the average running time of films by category?
SELECT 
    c.name AS 'CATEGORY',
    AVG(f.length) AS 'AVERAGE RUNNING TIME'
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC;

-- 4. Which film categories are longest?
SELECT 
    c.name AS 'CATEGORY',
    AVG(f.length) AS 'AVERAGE RUNNING TIME'
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY AVG(f.length) DESC
LIMIT 5;

-- 5. Display the most frequently rented movies in descending order.
SELECT 
    f.title AS 'FILM TITLE',
    COUNT(r.rental_id) AS 'RENTAL COUNT'
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY COUNT(r.rental_id) DESC;

-- 6. List the top five genres in gross revenue in descending order.
SELECT 
    c.name AS 'GENRE',
    SUM(p.amount) AS 'GROSS REVENUE'
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- Question 7: Is &quot;Academy Dinosaur&quot; available for rent from Store 1?
SELECT
CASE 
  WHEN COUNT(inventory_id) &gt;= SUM(available) THEN 'Yes'

  ELSE 'No'

 END AS is_available 
FROM (
 SELECT i.inventory_id, CASE 
    WHEN max(r.rental_date) IS NOT NULL and  r.return_date IS NULL THEN 0
    ELSE 1
   END as available
  FROM inventory as i 
  INNER JOIN film as f ON f.film_id = i.film_id
  LEFT JOIN rental as r ON i.inventory_id = r.inventory_id
 WHERE  f.title LIKE &quot;%Academy Dinosaur%&quot; AND store_id = 1
 GROUP BY i.inventory_id
) as s;</sql><current_tab id="0"/></tab_sql></sqlb_project>
