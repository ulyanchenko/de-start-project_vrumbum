/*добавьте сюда запрос для решения задания 5*/
SELECT 
    c.brand_origin,
    MAX(s.price / (1 - s.discount / 100)) AS price_max,
    MIN(s.price / (1 - s.discount / 100)) AS price_min
FROM 
    car_shop.sales s
JOIN 
    car_shop.cars c ON s.car_id = c.id
JOIN 
    car_shop.car_models cm ON c.model_id = cm.id
JOIN 
    car_shop.makes m ON cm.make_id = m.id
WHERE
    c.brand_origin IS NOT NULL 
GROUP BY 
    c.brand_origin
ORDER BY 
    c.brand_origin ASC;
