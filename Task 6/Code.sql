SELECT
    strftime('%Y', order_date) AS order_year,
    strftime('%m', order_date) AS order_month,
    
    SUM(CAST(amount AS REAL)) AS total_revenue,
    
    COUNT(DISTINCT order_id) AS order_volume
FROM 
    online_sales

WHERE 
    order_date >= '2025-01-01' AND order_date <= '2025-12-31'

GROUP BY 
    order_year, 
    order_month

ORDER BY 
    order_year ASC, 
    order_month ASC;