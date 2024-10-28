/*добавьте сюда запрос для решения задания 1*/
SELECT 
  (
    count(*) FILTER (
      WHERE 
        gasoline_consumption IS NULL
    ) * 100.0 / count(*)
  ) AS nulls_percentage_gasoline_consumption 
FROM 
  car_shop.cars;
