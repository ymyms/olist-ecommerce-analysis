SELECT *
FROM orders
LIMIT 10;

SELECT DISTINCT order_status
FROM orders;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

-- 1. one row per order

SELECT order_status,
COUNT(*) as num
FROM orders
GROUP BY order_status
ORDER BY num DESC;

SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customer_ids
FROM orders;

SELECT *
FROM customers
LIMIT 10;

SELECT COUNT(DISTINCT customer_id),
COUNT(DISTINCT customer_unique_id)
FROM customers;

-- 2. customer_unique_id may associated with more than one customer_id

SELECT customer_unique_id,
COUNT(*) as num_of_order
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY customer_unique_id
ORDER BY num_of_order DESC;
-- customer that placed most orders

SELECT *
FROM order_items
LIMIT 10;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM order_items;

-- 3. one row per order item within a order

SELECT order_id,
    order_item_id,
    COUNT(*) as num
FROM order_items
GROUP BY order_id, order_item_id
HAVING num != 1;
-- (order_id, order_item_id) is unique, confirmed composite key

SELECT product_id,
    seller_id,
    price,
    freight_value
FROM order_items
WHERE product_id IS NULL
   OR seller_id IS NULL
   OR price IS NULL
   OR freight_value IS NULL;

SELECT *
FROM products
LIMIT 10;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS unique_id
FROM products;
-- one row per product

SELECT oi.product_id
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT DISTINCT product_category_name
FROM products;

SELECT *
FROM product_category_name_translation
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_category_name) AS unique_categories
FROM product_category_name_translation;

SELECT DISTINCT
    CONCAT('>', p.product_category_name, '<') AS category,
    LENGTH(p.product_category_name) AS length
FROM products p
LEFT JOIN product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE t.product_category_name IS NULL;
-- identified blank-string category values that were not captured by standard NULL checks

SELECT COUNT(*) AS blank_category_products
FROM products
WHERE TRIM(product_category_name) = '';

SELECT
    COUNT(*) AS num_order_items,
    ROUND(SUM(oi.price), 2) AS product_sales
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
WHERE TRIM(p.product_category_name) = '';

SELECT
    COUNT(*) AS total_order_items,
    ROUND(SUM(price), 2) AS total_product_sales
FROM order_items;

SELECT *
FROM sellers
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT seller_id) AS unique_seller
FROM sellers;
-- one row per seller

SELECT DISTINCT oi.seller_id
FROM order_items oi
LEFT JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;
