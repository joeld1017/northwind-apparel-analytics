-- Q5: Develope monthly scorecard for DC network; Showing total orders, on time %, and rank them best to worst based from OT%
-- Show 3 month rolling average of on-time % to showing DC trends
-- Stakeholders: Chief Operating Officer


WITH monthly_dc_performance AS(
	SELECT
		STRFTIME('%Y-%m', o.order_date) AS 
year_month,
		dc.dc_name,
		COUNT(*) AS num_orders,
		ROUND(AVG(o.on_time_delivery) * 100,
1) AS on_time_pct
	FROM orders o
	JOIN distribution_centers dc  ON o.dc_id 
= dc.dc_id 
	WHERE o.order_status = 'Delivered'
	GROUP BY year_month, dc.dc_name 
)
SELECT 
	year_month,
	dc_name,
	num_orders,
	on_time_pct,
	RANK() OVER (PARTITION BY year_month
ORDER BY on_time_pct DESC) AS
rank_this_month,
	ROUND(
		AVG(on_time_pct) OVER (
			PARTITION BY dc_name
			ORDER BY year_month
			ROWS BETWEEN 2 PRECEDING AND
CURRENT ROW
		),
		1
	) AS rolling_3mo_on_time
FROM  monthly_dc_performance
ORDER BY year_month, rank_this_month;
	