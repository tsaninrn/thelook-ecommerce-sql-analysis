# Business Problem

## 1. Business Background

TheLook is a simulated online fashion retailer that sells clothing and
accessories across multiple product categories. Customers browse the website,
place orders, and receive products shipped from distribution centers.
This project uses TheLook's public dataset (synthetic data provided by Google)
to practice analyzing an e-commerce business.

## 2. Business Objective

Management wants to understand how the business is performing so that it can
make better decisions on marketing, product assortment, and operations.
This analysis aims to answer:

- How much valid revenue is generated, and how does it change over time?
- Which product categories and brands contribute the most?
- Who are the customers, and how many of them place orders?
- How often are orders cancelled or returned?

## 3. Stakeholders

| Stakeholder | What they need from this analysis |
|---|---|
| Management | Overall sales performance and key trends |
| Marketing team | Customer profiles and customer value to plan campaigns |
| Merchandising / product team | Best and worst performing categories, brands, and products |
| Operations team | Cancellation and return patterns to investigate |

## 4. Key Definitions

Order statuses in the dataset: Complete, Shipped, Processing, Cancelled, Returned.

| Metric | Definition |
|---|---|
| Gross sales | Sum of `sale_price` of all order items, regardless of status |
| Net sales | Sum of `sale_price` of items with status `Complete` only |
| Returned value | Sum of `sale_price` of items with status `Returned` |
| Cancelled value | Sum of `sale_price` of items with status `Cancelled` |
| Pipeline | Items with status `Shipped` or `Processing`, reported separately |

**Assumption:** Only `Complete` items are treated as realized sales, because
they are the only items that are neither cancelled, returned, nor still in
progress. This is a business assumption, not a fact in the data.

## 5. Scope

- **In scope:** products, customers, orders, order items, sales performance,
  cancellations, and returns.
- **Out of scope (for now):** web event analysis, marketing funnel, and
  logistics performance. These may be added later.

## 6. Limitations

- The dataset is synthetic, so findings describe this dataset and not a real company.
- Order status is identical for every item in an order, which is
  unlikely in real businesses.
- Figures may change when Google refreshes the dataset.
  Query execution dates are recorded in the SQL files.
