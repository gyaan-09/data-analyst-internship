SELECT 
    strftime('%Y', order_date) AS order_year,
    strftime('%m', order_date) AS order_month,
    SUM(amount) AS total_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM 
    orders
GROUP BY 
    order_year, 
    order_month
ORDER BY 
    order_year ASC, 
    order_month ASC;