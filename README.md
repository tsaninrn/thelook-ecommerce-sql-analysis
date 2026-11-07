# TheLook E-commerce SQL Analysis

## 1. Project Overview

This project focuses on analyzing the TheLook E-commerce public dataset using SQL in Google BigQuery.

The project simulates the role of a Junior Data Analyst working with an e-commerce business to understand product performance, customer orders, sales performance, and product returns.

The main objective is to explore the dataset, answer business questions, identify patterns, and generate actionable business insights using SQL.

This project starts with basic SQL queries and simple JOIN operations, then expands into more comprehensive business analysis.

## 2. Dataset Information

- **Dataset:** TheLook E-commerce
- **Source:** Google BigQuery Public Dataset
- **Project ID:** `bigquery-public-data`
- **Dataset ID:** `thelook_ecommerce`
- **Platform:** Google BigQuery

### Tables Used

| Table | Description |
|---|---|
| `products` | Product information, categories, brands, and prices |
| `users` | Customer information and profiles |
| `orders` | Customer order information and order status |
| `order_items` | Individual products within customer orders, including transaction prices and item status |

## 3. Core Business Questions (Bootcamp Assignment)

The initial analysis addresses five business questions from the SQL bootcamp assignment.

### 3.1 Product Analysis
- What are the characteristics of products sold by the company?
- What are the product names, categories, departments, brands, and retail prices?

### 3.2 Premium Product Identification
- Which products have a retail price above 100?
- Which products have the highest retail prices?

### 3.3 Product Category Evaluation
- Which product categories have the highest number of products?
- How are products distributed across categories?

### 3.4 Customer and Order Analysis
- Which customers have placed orders?
- What are their order IDs, order statuses, and order creation dates?

### 3.5 Sales Analysis by Category
- Which product categories generate the highest total sales?
- How much sales value does each category contribute?

## 4. Additional Business Analysis

Beyond the initial bootcamp assignment, this project will be expanded to explore additional business questions.

### 4.1 Customer Analysis
- Which customers have never placed an order?
- Which customers have placed the most orders?
- How many orders does each customer make?
- Which customers have the highest total purchase value?

### 4.2 Sales Performance Analysis
- What are the monthly sales trends?
- Which months generate the highest sales?
- What is the total sales value by product category?
- What is the average transaction value?
- How do order statuses affect sales performance?

### 4.3 Product Performance Analysis
- Which products generate the highest sales?
- Which products contribute the most to total profit?
- Which categories have the highest average product prices?
- Which products have the lowest sales performance?

### 4.4 Order Cancellation Analysis
- Which product categories have the highest number of cancelled items?
- Which products are most frequently cancelled?
- What percentage of items are cancelled?
- Which categories have the highest cancellation rates?

### 4.5 Product Return Analysis
- Which product categories have the highest number of returned items?
- What is the average product cost among returned items?
- Which products are most frequently returned?
- What percentage of items are returned?

### 4.6 Business Performance Analysis
- What is the relationship between product cost and retail price?
- Which product categories generate the highest profit?
- Which categories have high sales but also high return rates?
- Which business areas require further investigation?

## 5. SQL Skills & Techniques

The following SQL concepts will be applied throughout this project:

- SELECT and FROM
- WHERE and ORDER BY
- GROUP BY and HAVING
- LIMIT and DISTINCT
- COUNT, SUM, AVG, MIN, and MAX
- INNER JOIN and LEFT JOIN
- CASE WHEN
- Subqueries
- Common Table Expressions (CTE)
- Date and Time Functions
- Aggregate Functions
- Data Filtering and Sorting
- Data Exploration and Business Analysis

Advanced techniques will be introduced gradually as the project develops.

## 6. Tools Used

- Google BigQuery
- SQL
- GitHub
- ChatGPT (SQL learning, query review, and analytical guidance)

## 7. Project Structure

```text
thelook-ecommerce-sql-analysis/
│
├── README.md
│
├── sql/
│   ├── 01_product_analysis.sql
│   ├── 02_customer_analysis.sql
│   ├── 03_sales_analysis.sql
│   ├── 04_cancellation_analysis.sql
│   └── 05_return_analysis.sql
│
├── results/
│   └── query_results/
│
└── screenshots/
    └── bigquery_results/
```

## 8. Key Business Insights

Business insights will be documented based on actual query results.

The analysis will focus on:
- Top-performing product categories.
- Products and categories with the highest sales.
- Customer purchasing patterns.
- Product cancellation and return patterns.
- Opportunities to improve business performance.

## 9. Project Goals

The goals of this project are:

1. Develop practical SQL skills using a real-world e-commerce dataset.
2. Understand relationships between multiple database tables.
3. Translate business questions into SQL queries.
4. Identify meaningful patterns and business insights.
5. Build a structured SQL portfolio for a Junior Data Analyst position.

## 10. Project Status

**Status:** In Progress

This project will be developed progressively, starting with basic SQL analysis and expanding into more advanced business analysis.

---

**Author:** SQL Data Analysis Portfolio  
**Dataset:** TheLook E-commerce Public Dataset  
**Platform:** Google BigQuery
