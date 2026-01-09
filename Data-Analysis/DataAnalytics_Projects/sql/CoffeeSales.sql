SELECT
    coffee_name,
    ROUND(SUM(money), 2) AS total_sales
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_sales DESC;