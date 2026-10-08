# Olist E-commerce: Short Analysis Report

## Objective

Explore product sales, delivery reliability, and customer ratings using MySQL and Tableau. The analysis focuses on delivered orders and excludes payment analysis.

Data source: [Brazilian E-Commerce Public Dataset by Olist (Kaggle)](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data).

[Interactive dashboard](https://public.tableau.com/app/profile/yingming.sha/viz/olist_new_17909454795890/1)

## Q1 — Sales performance

**Question:** How do sales and average order value vary over time, and how are product sales distributed across categories?

Health & Beauty, Watches & Gifts, and Bed, Bath & Table were among the top-selling categories. Sports & Leisure and Computers & Accessories also contributed strongly to product sales.

The dashboard shows monthly sales and average order value for the selected year. Since the dataset does not cover complete calendar years, the analysis focuses on the available months rather than full-year growth.

## Q2 — Delivery performance

**Question:** Are orders delivered on time, and which customer states have higher late-delivery rates?

Each row represents one delivered order. An order is late when its actual delivery date is after the estimated delivery date. Average delivery days measure elapsed time from purchase to delivery. The state map shows the customer's destination, not the seller's location.

Full-range checks recorded **6,534 late orders out of 96,470 orders with valid delivery outcomes**, a late-delivery rate of **6.77%**. Eight delivered orders lacked an actual delivery date and were excluded from that rate.

The all-period state comparison showed AL at **21.41%**, MA at **17.43%**, and SE at **15.22%**. These locations merit further investigation, with order counts considered alongside rates. A high late rate does not necessarily mean the longest delivery duration, because lateness is measured against each order's promised date.

## Q3 — Customer reviews and delivery status

**Question:** How do customer review scores differ between on-time and late deliveries?

In the dashboard comparison, on-time orders received an average review score of around **4 out of 5**, while late orders averaged around **2 out of 5**. Late deliveries were associated with lower customer ratings, although this comparison alone does not establish causation.

One review is selected per order to avoid counting the same order multiple times.

## Interpretation and limitations

- Coverage is September 2016–August 2018 and is incomplete at both ends. Missing months are not zero-sales months.
- Results describe delivered orders only; cancelled and undelivered orders are excluded.
- State-level rates should be read with sample sizes; the destination does not establish responsibility for delays.
- Some selected reviews were submitted before delivery. The comparison is by eventual delivery status, not exclusively post-delivery feedback.
- Differences in review scores are associations. This analysis does not control for product quality, category, or other possible influences.
- Dashboard values change with the selected year.
