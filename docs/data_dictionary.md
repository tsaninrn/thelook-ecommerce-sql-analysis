# Data Dictionary

**Source:** `bigquery-public-data.thelook_ecommerce`
**Schema retrieved:** 12 November 2026 via `INFORMATION_SCHEMA.COLUMNS` (see `sql/00_schema_inspection.sql`)

> Column names and data types below are verified from the actual schema.
> Descriptions and key roles are based on column names and are marked "to verify" until checked with queries.
> All columns are declared nullable in BigQuery, so key uniqueness is not guaranteed by the schema.

## Table Overview

| Table | Rows | Size (MB) | Grain (1 row =) |
|---|---:|---:|---|
| `events` | 2,423,896 | 367.1 | One web activity event |
| `inventory_items` | 489,169 | 77.4 | One physical inventory unit |
| `order_items` | 181,049 | 13.0 | One item within an order |
| `orders` | 124,777 | 6.4 | One order |
| `users` | 100,000 | 18.9 | One user |
| `products` | 29,120 | 4.1 | One product |
| `distribution_centers` | 10 | 0.0 | One distribution center |

*Row counts retrieved from `__TABLES__` on 12 November 2026.*

## orders

| Column | Type | Role | Notes |
|---|---|---|---|
| `order_id` | INT64 | PK candidate | To verify uniqueness |
| `user_id` | INT64 | FK candidate | References `users.id` |
| `status` | STRING | Attribute | Order-level status |
| `gender` | STRING | Attribute | Also exists in `users`, consistency to verify |
| `created_at` | TIMESTAMP | Attribute | Order creation time |
| `returned_at` | TIMESTAMP | Attribute | Expected NULL if not returned |
| `shipped_at` | TIMESTAMP | Attribute | Expected NULL if not shipped |
| `delivered_at` | TIMESTAMP | Attribute | Expected NULL if not delivered |
| `num_of_item` | INT64 | Attribute | Compare with count in `order_items` |

## order_items

| Column | Type | Role | Notes |
|---|---|---|---|
| `id` | INT64 | PK candidate | To verify uniqueness |
| `order_id` | INT64 | FK candidate | References `orders.order_id` |
| `user_id` | INT64 | FK candidate | References `users.id` |
| `product_id` | INT64 | FK candidate | References `products.id` |
| `inventory_item_id` | INT64 | FK candidate | References `inventory_items.id` |
| `status` | STRING | Attribute | Item-level status |
| `created_at` | TIMESTAMP | Attribute | |
| `shipped_at` | TIMESTAMP | Attribute | |
| `delivered_at` | TIMESTAMP | Attribute | |
| `returned_at` | TIMESTAMP | Attribute | |
| `sale_price` | FLOAT64 | Measure | Price charged per item (to verify) |

## products

| Column | Type | Role | Notes |
|---|---|---|---|
| `id` | INT64 | PK candidate | |
| `cost` | FLOAT64 | Measure | Also exists in `inventory_items` |
| `category` | STRING | Attribute | |
| `name` | STRING | Attribute | |
| `brand` | STRING | Attribute | |
| `retail_price` | FLOAT64 | Measure | List price |
| `department` | STRING | Attribute | |
| `sku` | STRING | Attribute | |
| `distribution_center_id` | INT64 | FK candidate | References `distribution_centers.id` |

## inventory_items

| Column | Type | Role | Notes |
|---|---|---|---|
| `id` | INT64 | PK candidate | |
| `product_id` | INT64 | FK candidate | References `products.id` |
| `created_at` | TIMESTAMP | Attribute | |
| `sold_at` | TIMESTAMP | Attribute | NULL expected for unsold units |
| `cost` | FLOAT64 | Measure | Cost of this unit |
| `product_category` | STRING | Attribute | Denormalized from products |
| `product_name` | STRING | Attribute | Denormalized from products |
| `product_brand` | STRING | Attribute | Denormalized from products |
| `product_retail_price` | FLOAT64 | Attribute | Denormalized from products |
| `product_department` | STRING | Attribute | Denormalized from products |
| `product_sku` | STRING | Attribute | Denormalized from products |
| `product_distribution_center_id` | INT64 | FK candidate | References `distribution_centers.id` |

## users

| Column | Type | Role | Notes |
|---|---|---|---|
| `id` | INT64 | PK candidate | |
| `first_name`, `last_name`, `email` | STRING | Personal data | Not needed for analysis |
| `age` | INT64 | Attribute | Check for unusual values |
| `gender` | STRING | Attribute | |
| `state`, `city`, `postal_code`, `country` | STRING | Attribute | Geographic analysis |
| `street_address` | STRING | Personal data | Not needed for analysis |
| `latitude`, `longitude` | FLOAT64 | Attribute | |
| `user_geom` | GEOGRAPHY | Attribute | Not needed for analysis |
| `traffic_source` | STRING | Attribute | Acquisition channel |
| `created_at` | TIMESTAMP | Attribute | Registration time |

## events

| Column | Type | Role | Notes |
|---|---|---|---|
| `id` | INT64 | PK candidate | |
| `user_id` | INT64 | FK candidate | May be NULL for anonymous visitors (to verify) |
| `sequence_number` | INT64 | Attribute | Order of events in a session |
| `session_id` | STRING | Attribute | Session identifier |
| `created_at` | TIMESTAMP | Attribute | |
| `ip_address`, `city`, `state`, `postal_code` | STRING | Attribute | |
| `browser` | STRING | Attribute | |
| `traffic_source` | STRING | Attribute | |
| `uri` | STRING | Attribute | Page visited |
| `event_type` | STRING | Attribute | Values to be inspected before funnel analysis |

## distribution_centers

| Column | Type | Role | Notes |
|---|---|---|---|
| `id` | INT64 | PK candidate | |
| `name` | STRING | Attribute | |
| `latitude`, `longitude` | FLOAT64 | Attribute | |
| `distribution_center_geom` | GEOGRAPHY | Attribute | |
