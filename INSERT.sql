INSERT INTO car_shop.origin (brand_origin) 
SELECT 
  DISTINCT brand_origin 
FROM 
  raw_data.sales;
INSERT INTO car_shop.colors (color) 
SELECT 
  DISTINCT TRIM(
    split_part(auto, ' ', -1)
  ) AS color 
FROM 
  raw_data.sales 
WHERE 
  split_part(auto, ' ', -1) IS NOT NULL;
INSERT INTO car_shop.makes (origin_id, name) 
SELECT 
  DISTINCT o.id AS origin_id, 
  TRIM(
    split_part(ts.auto, ' ', 1)
  ) AS make 
FROM 
  raw_data.sales ts 
  JOIN car_shop.origin o ON o.brand_origin = CASE WHEN TRIM(
    split_part(ts.auto, ' ', 1)
  ) IN ('Audi', 'BMW', 'Porsche') THEN 'Germany' WHEN TRIM(
    split_part(ts.auto, ' ', 1)
  ) IN ('Tesla') THEN 'USA' WHEN TRIM(
    split_part(ts.auto, ' ', 1)
  ) IN ('Kia', 'Hyundai') THEN 'South Korea' WHEN TRIM(
    split_part(ts.auto, ' ', 1)
  ) IN ('Lada') THEN 'Russia' ELSE NULL END 
WHERE 
  TRIM(
    split_part(ts.auto, ' ', 1)
  ) IS NOT NULL 
  AND o.brand_origin IS NOT NULL;
INSERT INTO car_shop.car_models (
  name, make_id, gasoline_consumption
) 
SELECT 
  DISTINCT TRIM(
    SUBSTRING(
      auto 
      FROM 
        POSITION(' ' IN auto) + 1 FOR POSITION(',' IN auto) - POSITION(' ' IN auto) -1
    )
  ) AS model, 
  m.id AS make_id, 
  ts.gasoline_consumption 
FROM 
  raw_data.sales AS ts 
  JOIN car_shop.makes m ON m.name = TRIM(
    split_part(auto, ' ', 1)
  ) 
WHERE 
  SUBSTRING(
    auto 
    FROM 
      POSITION(' ' IN auto) + 1 FOR POSITION(',' IN auto) - POSITION(' ' IN auto) -1
  ) IS NOT NULL;
INSERT INTO car_shop.cars (model_id, color_id) 
SELECT 
  cm.id AS model_id, 
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
    split_part(ts.auto, ' ', -1)
  );
INSERT INTO car_shop.customers (person_name, phone) 
SELECT 
  DISTINCT person_name, 
  phone 
FROM 
  raw_data.sales 
WHERE 
  person_name IS NOT NULL 
  AND phone IS NOT NULL;
INSERT INTO car_shop.discounts (discount) 
SELECT 
  DISTINCT discount 
FROM 
  raw_data.sales;
INSERT INTO car_shop.sales (
  car_id, customer_id, sale_date, price, 
  discount_id
) 
SELECT 
  car.id AS car_id, 
  c.id AS customer_id, 
  ts.date :: DATE, 
  ts.price, 
  (
    SELECT 
      id 
    FROM 
      car_shop.discounts 
    WHERE 
      discount = ts.discount
  ) AS discount_id 
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
