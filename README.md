# Northwind Apparel Analytics

End-to-end supply chain & customer analytics on a synthetic mid-size apparel retailer dataset. SQL analysis answering stakeholder questions across operations, finance, and marketing personas. Tableau & Power BI dashboards and Python forecasting to follow.

---

## Project Overview

**Northwind Apparel Co.** is a fictional mid-size US athletic apparel and footwear retailer with regional distribution centers and 3 years of operating data (2023–2025). The dataset contains ~157,000 rows across 5 normalized tables:

- **customers** (8,000 rows) — region, state, segment, signup date
- **products** (56 rows) — category, subcategory, brand, price, cost
- **distribution_centers** (4 rows) — regional fulfillment facilities
- **orders** (50,000 rows) — order header data, shipping, on-time delivery flags
- **order_items** (~99,000 rows) — line-item revenue and cost

The dataset is synthetic but contains deliberately planted operational patterns (DC performance gaps, holiday seasonality, margin variance across categories) for analytical discovery.

---

## Key Findings

### 1. Critical operational gap at Sacramento Distribution Center
Sacramento DC delivers on-time only **25.6%** of the time, vs. **63.8%** at Newburgh — a **38-percentage-point gap**. Rankings are static across all 36 months analyzed, indicating a structural issue rather than transient operational problems. **Recommendation:** Sacramento needs an operational overhaul, not optimization.

### 2. Profit-per-unit varies 3.5x across categories
Footwear delivers **$52.54 in profit per unit sold**, vs. **$14.79 for Accessories**, despite Accessories carrying the highest gross margin percentage (61.3%). This reframes acquisition strategy: optimizing for margin % is different from optimizing for absolute profit. **Recommendation:** Re-examine customer acquisition spend by category.

### 3. Customer segmentation shows minimal differentiation
VIP, Premium, and Standard customers all spend approximately **$830–$906 per customer** on average — a less-than-10% spread between the highest and lowest tiers. A working segmentation framework should show 2–3x differentiation. **Recommendation:** Audit segment assignment criteria before allocating 2026 acquisition budget.

### 4. Volume seasonality, not basket-size seasonality
December order volume is **3x January**, but average order value stays flat at ~$140 year-round. Customers shop *more often* during the holidays, not *bigger*. **Implication:** Capacity planning must scale to peak volume, not average — and Sacramento's on-time issues are likely worse during this Q4 surge.

---

## Repository Structure

```
.
├── data/                              # Source CSV files
│   ├── customers.csv
│   ├── products.csv
│   ├── distribution_centers.csv
│   ├── orders.csv
│   └── order_items.csv
├── 01_on_time_delivery.sql
├── 02_profit_margin_by_category.sql
├── 03_customer_segment_value.sql
├── 04_monthly_revenue_trends.sql
└── 05_dc_performance_ranking.sql
```

---

## Tools & Techniques

**SQL (SQLite via DBeaver)**
- Multi-table JOINs with table aliases
- Aggregate functions: COUNT, SUM, AVG, with COUNT(DISTINCT) for accurate unique counts
- GROUP BY with multi-dimensional aggregation
- HAVING for filtering aggregated groups
- CAST for handling integer division
- Common Table Expressions (CTEs) for multi-step analysis
- Window functions: RANK() OVER (PARTITION BY), AVG() OVER (ROWS BETWEEN ...) for rolling averages
- Date functions: STRFTIME for time-series grouping

**Live Dashboard:** [Northwind Apparel Supply Chain Dashboard](https://public.tableau.com/app/profile/joel.diaz5841/viz/NorthwindApparelSupplyChainDashboard/NorthwindApparelCo_-SupplyChainOperationsDashboard)

---

**Forecasting Notebook:** [`northwind_demand_forecast.ipynb`](northwind_demand_forecast.ipynb)

Multi-model demand forecast comparing SMA (MAPE 37.1%), Holt-Winters (3.86%), 
and Facebook Prophet (2.73%) on 36 months of supply chain data. Includes time-series 
decomposition, seasonal analysis, and a 12-month 2026 forward forecast with 95% 
confidence intervals.

Key finding: Prophet forecasts 2026 annual revenue of $1,966,619 (-9.4% YoY), 
with Sacramento DC on-time rate projected to fall below 15% during Q4 2026 
peak — compounding the operational gap identified in the SQL analysis.

## About the Analyst

I'm pivoting into supply chain and operations analytics after 10+ years in operations leadership at Nike (5 years, four promotions), Gap Inc., and UNFI. This project draws on the operational patterns I worked with day-to-day in apparel/footwear distribution.

**Contact:** [LinkedIn](https://www.linkedin.com/in/joeld1017) · joeld1017@icloud.com
