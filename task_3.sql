/*добавьте сюда запрос для решения задания 3*/
SELECT 
    EXTRACT(MONTH FROM s.sale_date) AS month,
    EXTRACT(YEAR FROM s.sale_date) AS year,
    ROUND(AVG(s.price * (1 - s.discount / 100)), 2) AS price_avg
FROM 
    car_shop.sales s
WHERE 
    EXTRACT(YEAR FROM s.sale_date) = 2022
GROUP BY 
    month, year
ORDER BY 
    month;
