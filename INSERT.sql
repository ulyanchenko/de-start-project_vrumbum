/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме автосалона*/
INSERT INTO car_shop.makes (name) 
SELECT 
  DISTINCT split_part(auto, ' ', 1) AS make 
FROM 
  raw_data.sales;
 
INSERT INTO car_shop.colors (color) 
SELECT 
  DISTINCT split_part(auto, ' ', -1) AS color 
FROM 
  raw_data.sales;
 
INSERT INTO car_shop.car_models (name, make_id) 
SELECT 
  DISTINCT TRIM(
    SUBSTRING(
      auto 
      FROM 
        POSITION(' ' IN auto) + 1 FOR POSITION(',' IN auto) - POSITION(' ' IN auto) -1
    )
  ) AS model, 
  m.id AS make_id 
FROM 
  raw_data.sales AS ts 
  JOIN car_shop.makes m ON m.name = TRIM(
    SUBSTRING(
      auto 
      FROM 
        1 FOR POSITION(' ' IN auto) -1
    )
  );
 
INSERT INTO car_shop.cars (
  model_id, gasoline_consumption, brand_origin, 
  color_id
) 
SELECT 
  cm.id AS model_id, 
  ts.gasoline_consumption, 
  ts.brand_origin, 
  c.id AS color_id 
FROM 
  raw_data.sales ts 
  JOIN car_shop.car_models cm ON cm.name = TRIM(
    SUBSTRING(
      ts.auto 
      FROM 
        POSITION(' ' IN ts.auto) + 1 FOR POSITION(',' IN ts.auto) - POSITION(' ' IN ts.auto) -1
    )
  ) 
  JOIN car_shop.colors c ON c.color = TRIM(
    SUBSTRING(
      ts.auto 
      FROM 
        POSITION(',' IN ts.auto) + 1
    )
  );
 
INSERT INTO car_shop.customers (person_name, phone) 
SELECT 
  DISTINCT person_name, 
  phone 
FROM 
  raw_data.sales;
 
INSERT INTO car_shop.sales (
  car_id, customer_id, sale_date, price, 
  discount
) 
SELECT 
  car.id AS car_id, 
  c.id AS customer_id, 
  ts.date :: DATE, 
  ts.price, 
  ts.discount 
FROM 
  raw_data.sales ts 
  JOIN car_shop.cars car ON car.model_id = (
    SELECT 
      cm.id 
    FROM 
      car_shop.car_models cm 
    WHERE 
      cm.name = TRIM(
        SUBSTRING(
          ts.auto 
          FROM 
            POSITION(' ' IN ts.auto) + 1 FOR POSITION(',' IN ts.auto) - POSITION(' ' IN ts.auto) -1
        )
      )
  ) 
  JOIN car_shop.customers c ON c.person_name = ts.person_name 
  AND c.phone = ts.phone;
