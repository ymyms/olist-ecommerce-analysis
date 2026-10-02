-- Q3: How do customers rate their orders, and are late orders
-- associated with lower review scores?
WITH ranked_reviews AS (
    SELECT
        order_id,
        review_id,
        review_score,
        review_creation_date,
        review_answer_timestamp,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY review_answer_timestamp DESC,
                     review_creation_date DESC,
                     review_id DESC
        ) AS rn
    FROM order_reviews
)
SELECT
    o.order_id,
    o.order_purchase_timestamp,
    YEAR(o.order_purchase_timestamp) AS `year`,
    DATE(DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01')) AS month_start,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    r.review_id,
    r.review_answer_timestamp,
    CASE WHEN r.review_score BETWEEN 1 AND 5 THEN r.review_score END AS review_score,
    CASE
        WHEN o.order_delivered_customer_date >= o.order_purchase_timestamp
        THEN TIMESTAMPDIFF(SECOND,
            o.order_purchase_timestamp,
            o.order_delivered_customer_date
        ) / 86400.0
    END AS delivery_days,
    CASE
        WHEN o.order_delivered_customer_date >= o.order_purchase_timestamp
         AND DATE(o.order_estimated_delivery_date) >= DATE(o.order_purchase_timestamp)
        THEN DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date)
    END AS delay_days,
    CASE
        WHEN o.order_delivered_customer_date >= o.order_purchase_timestamp
         AND DATE(o.order_estimated_delivery_date) >= DATE(o.order_purchase_timestamp)
        THEN CASE
            WHEN DATE(o.order_delivered_customer_date) > DATE(o.order_estimated_delivery_date)
            THEN 1 ELSE 0
        END
    END AS is_late
FROM orders AS o
LEFT JOIN ranked_reviews AS r
    ON o.order_id = r.order_id
   AND r.rn = 1
WHERE o.order_status = 'delivered';