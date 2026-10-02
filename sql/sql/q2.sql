-- Q2: Are orders delivered on time, and which customer states
-- have more delivery delays?
SELECT
    o.order_id,
    o.order_purchase_timestamp,
    YEAR(o.order_purchase_timestamp) AS `year`,
    DATE(DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01')) AS month_start,
    NULLIF(TRIM(c.customer_state), '') AS customer_state,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    -- Elapsed days from purchase to delivery, including fractional days.
    CASE
        WHEN o.order_delivered_customer_date >= o.order_purchase_timestamp
        THEN TIMESTAMPDIFF(SECOND,
            o.order_purchase_timestamp,
            o.order_delivered_customer_date
        ) / 86400.0
    END AS delivery_days,
    -- Calendar days relative to the promise: negative = early, positive = late.
    CASE
        WHEN o.order_delivered_customer_date >= o.order_purchase_timestamp
         AND DATE(o.order_estimated_delivery_date) >= DATE(o.order_purchase_timestamp)
        THEN DATEDIFF(
            o.order_delivered_customer_date,
            o.order_estimated_delivery_date
        )
    END AS delay_days,
    -- 1 = late, 0 = on time. Missing/invalid dates remain NULL.
    CASE
        WHEN o.order_delivered_customer_date >= o.order_purchase_timestamp
         AND DATE(o.order_estimated_delivery_date) >= DATE(o.order_purchase_timestamp)
        THEN CASE
            WHEN DATE(o.order_delivered_customer_date) > DATE(o.order_estimated_delivery_date)
            THEN 1 ELSE 0
        END
    END AS is_late
FROM orders AS o
LEFT JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered';
