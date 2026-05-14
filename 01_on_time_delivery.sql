-- Q1: Which distribution centers have the worst on-time delivery performance?
-- Stakeholder: VP of Operations
-- Finding: Sacramento DC delivers on time only 25.6% of orders, vs. 63.8% at Newburgh.
-- A 38-point gap warrants immediate operational investigation.

SELECT 'customers' AS tbl, COUNT(*) AS rows FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'distribution_centers', COUNT(*) FROM distribution_centers
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items;

--Retrieve all DCs showing best -> worst OT Delivery Rates--
SELECT 
	dc.dc_name,
	dc.dc_region,
	COUNT(*) AS total_delivered_orders,
	ROUND(AVG(on_time_delivery) * 100,1) AS on_time_pct
	FROM orders o
	JOIN distribution_centers dc ON o.dc_id = dc.dc_id
	WHERE o.order_status = 'Delivered'
	GROUP BY dc.dc_name, dc.dc_region
	ORDER BY on_time_pct ASC;

