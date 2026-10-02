-- Q1: How do sales and average order value vary over time,
-- and how are product sales distributed across categories?
SELECT
    o.order_id,
    oi.order_item_id,
    o.order_purchase_timestamp,
    YEAR(o.order_purchase_timestamp) AS `year`,
    MONTH(o.order_purchase_timestamp) AS `month`,
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS `year_month`,
    CAST(DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS DATE) AS month_start,
    oi.product_id,
    COALESCE(
        NULLIF(TRIM(REPLACE(t.product_category_name_english, CHAR(13), '')), ''),
        NULLIF(TRIM(REPLACE(p.product_category_name, CHAR(13), '')), ''),
        'Unknown'
    ) AS product_category,
    oi.price
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
LEFT JOIN products AS p
    ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation AS t
    ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered';
