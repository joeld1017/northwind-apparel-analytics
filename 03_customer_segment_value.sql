-- Q3: How valueable are our different customer segments by region?
-- Stakeholder: VP of Marketing
-- Findings: Customer segmentation show minimal spending differentation.
-- Top avg revenue per customer is only $906 and segments cluster between ~$830-$906
-- regardless of whether the customer is Standard, Premium, or VIP.
-- VIP customers do not spend significantly more per customer than Standard customers
-- Recommendation: Audit segment assignment criteria before allocating 2026 acquisition budget.
-- A working segmentation should show 2-3x spend differentation between tiers.

SELECT 
	c.customer_segment, 
	c.region,
	COUNT(DISTINCT c.customer_id) AS 
num_customers,
	COUNT(o.order_id) AS num_orders,
	SUM(o.order_total) AS total_revenue,
	ROUND(SUM(o.order_total)/
COUNT(DISTINCT c.customer_id), 2) AS
avg_revenue_per_customer,
	ROUND(CAST(COUNT(o.order_id) AS REAL) /
COUNT(DISTINCT c.customer_id), 2) AS
avg_orders_per_customer
FROM customers c
JOIN orders o ON c.customer_id = 
o.customer_id
GROUP BY c.customer_segment, c.region
HAVING COUNT(DISTINCT c.customer_id) >= 100
ORDER BY avg_revenue_per_customer DESC;