# Olist E-commerce Analysis

A SQL and Tableau portfolio project exploring product sales, delivery performance, and customer reviews for delivered Olist orders in Brazil.

**[View the interactive Tableau dashboard](https://public.tableau.com/app/profile/yingming.sha/viz/olist_new_17909454795890/1)** · **[Read the short report](reports/analysis_report.md)**

## Business questions

1. **Sales:** How do sales and average order value vary over time, and how are product sales distributed across categories?
2. **Delivery:** Are orders delivered on time, and which customer states have higher late-delivery rates?
3. **Reviews:** How do customer review scores differ between on-time and late deliveries?

## Data and approach

Source: [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data). The analysis uses orders, order items, products, category translations, customers, and reviews. Payments are outside the scope.

SQL prepares detailed datasets; Tableau calculates and visualizes the metrics. All three queries select delivered orders and use purchase dates for year filters. They do not pre-aggregate by month or category.

| Dataset | One row represents | Preparation |
| --- | --- | --- |
| Q1 | An item within a delivered order | Join product categories; use a fallback category when the English translation is unavailable |
| Q2 | A delivered order | Join the customer state; calculate delivery duration and lateness |
| Q3 | A delivered order | Select one review per order using ROW_NUMBER; retain orders without reviews |

## Metric definitions

| Metric | Calculation |
| --- | --- |
| Product sales (BRL) | SUM(price), excluding freight and payments |
| Orders | COUNTD(order_id) |
| Average order value | SUM(price) / COUNTD(order_id) |
| Late delivery rate | AVG(is_late), excluding unknown delivery outcomes |
| Average delivery days | AVG(delivery_days), from purchase to actual delivery |
| Average review score | AVG(review_score), valid scores from 1 to 5 |

Delivery on the estimated calendar date counts as on time. Invalid or missing dates remain NULL. Missing review scores are not replaced with zero.

## Repository structure

```text
sql/
  explore_data.sql             Original exploratory queries
  q1.sql                      Sales dataset
  q2.sql                      Delivery dataset
  q3.sql                      Review dataset
reports/
  analysis_report.md          Questions, findings, and limitations
```

## Limits

Delivered-order purchase dates run from September 15, 2016 to August 29, 2018. The years are not equally complete, so this project describes the observed periods rather than comparing full-year growth. Review comparisons show association, not causation. See the report for details.
