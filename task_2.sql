/*добавьте сюда запрос для решения задания 2*/
SELECT 
  m.name AS brand_name, 
  EXTRACT(
    YEAR 
    FROM 
      s.sale_date
  ) AS year, 
  ROUND(
    AVG(
      s.price * (1 - s.discount / 100)
    ), 
    2
  ) AS price_avg 
FROM 
  car_shop.sales s 
  JOIN car_shop.cars c ON c.id = s.car_id 
  JOIN car_shop.car_models cm ON cm.id = c.model_id 
  JOIN car_shop.makes m ON m.id = cm.make_id 
GROUP BY 
  m.name, 
  year 
ORDER BY 
  m.name, 
  year;
