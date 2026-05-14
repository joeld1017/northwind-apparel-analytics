-- Q2: Which product categories are most profitable?
-- Stakeholder: CFO
-- Finding: Accessories has the highest gross margin (61.3%) but lowest revenue.
-- Footwear is the largest by revenue ($3.7M) but lowest margin (51%).
-- Opportunity: Grow accessories revenue to lift overall company margin

-- Updated Finding: Footwear delivers $52.54 profit/unit (3.5x Accessories at $14.79).
-- Lower margin % but highest per-unit profit and total gross profit.
-- Strategic question: Are we optimizing customer acquisition by margin or volume?

SELECT p.category,
	SUM(oi.line_revenue) AS total_revenue,
	SUM(oi.line_cost) AS total_cost,
	SUM(oi.quantity) AS total_units_sold,
	SUM(oi.line_revenue) - SUM(oi.line_cost) AS gross_profit,
		ROUND(
		(SUM(oi.line_revenue) - SUM(oi.line_cost)) / SUM(oi.quantity), 2
		)
		AS profit_per_unit,
		ROUND(
		(SUM(oi.line_revenue) - SUM(oi.line_cost)) / SUM(oi.line_revenue) * 100,1) AS gross_margin_pct
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id 
GROUP BY p.category
ORDER BY gross_margin_pct DESC;
