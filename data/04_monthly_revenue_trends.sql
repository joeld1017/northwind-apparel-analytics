-- Q4: What does our monthly revenue trend look like? Where's the seasonality?
-- Stakeholder: CFO
-- Findings:
-- Strong Q4 holiday seasonality. December consistently 3x the volume of January.
-- Average order value is stable (~$140) year-round, meaning seasonality is driven by order count, not basket size,
-- customers shop more often, not bigger.
-- Implication: Capacity planning (warehouse staffing, inventory) must scale to peak volume, not average.
-- Sacramento DC's on-time issues from Q1 are likely worsened during Q4 surge.
-- Recommendation: Prioritize operational fixes there before next holiday season.

SELECT
	STRFTIME('%Y-%m', order_date) AS
year_month,
	COUNT(*) AS num_orders,
	SUM(order_total) AS total_revenue,
	ROUND(SUM(order_total) / COUNT(*), 2) AS
avg_order_value
FROM orders
WHERE order_status = 'Delivered'
GROUP BY year_month
ORDER BY year_month ASC;
