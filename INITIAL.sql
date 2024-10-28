/*сохраните в этом файле запросы для первоначальной загрузки данных - создание схемы raw_data и таблицы sales и наполнение их данными из csv файла*/
CREATE SCHEMA IF NOT EXISTS raw_data;
CREATE TABLE IF NOT EXISTS raw_data.sales(
  id SERIAL PRIMARY KEY, 
  auto VARCHAR(255), 
  gasoline_consumption NUMERIC(4, 2), 
  price NUMERIC(15, 2), 
  sale_date DATE, 
  person_name VARCHAR(255), 
  phone VARCHAR(50), 
  discount INTEGER, 
  brand_origin VARCHAR(100)
);

COPY raw_data.sales (
  auto, gasoline_consumption, price, 
  sale_date, person_name, phone, discount, 
  brand_origin
) 
FROM 
  'C:/Dev/cars.csv' DELIMITER ',' CSV HEADER;

