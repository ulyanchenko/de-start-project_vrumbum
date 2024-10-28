CREATE SCHEMA IF NOT EXISTS car_shop;
CREATE TABLE IF NOT EXISTS car_shop.origin (
  id SERIAL PRIMARY KEY, 
  brand_origin VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS car_shop.makes (
  id SERIAL PRIMARY KEY, 
  origin_id INT NOT NULL, 
  name VARCHAR(255) NOT NULL UNIQUE, 
  FOREIGN KEY (origin_id) REFERENCES car_shop.origin(id)
);
CREATE TABLE IF NOT EXISTS car_shop.car_models (
  id SERIAL PRIMARY KEY, 
  name VARCHAR(255) NOT NULL UNIQUE, 
  make_id INT NOT NULL, 
  gasoline_consumption DECIMAL(5, 2), 
  FOREIGN KEY (make_id) REFERENCES car_shop.makes(id)
);
CREATE TABLE IF NOT EXISTS car_shop.colors (
  id SERIAL PRIMARY KEY, 
  color VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS car_shop.cars (
  id SERIAL PRIMARY KEY, 
  model_id INT NOT NULL, 
  color_id INT NOT NULL, 
  FOREIGN KEY (model_id) REFERENCES car_shop.car_models(id), 
  FOREIGN KEY (color_id) REFERENCES car_shop.colors(id)
);
CREATE TABLE IF NOT EXISTS car_shop.customers (
  id SERIAL PRIMARY KEY, 
  person_name VARCHAR(255), 
  phone VARCHAR(50) UNIQUE
);
CREATE TABLE IF NOT EXISTS car_shop.discounts (
  id SERIAL PRIMARY KEY, 
  discount DECIMAL(5, 2) NOT NULL
);
CREATE TABLE IF NOT EXISTS car_shop.sales (
  id SERIAL PRIMARY KEY, 
  car_id INT NOT NULL, 
  customer_id INT NOT NULL, 
  sale_date DATE, 
  price DECIMAL(10, 2), 
  discount_id INT, 
  FOREIGN KEY (car_id) REFERENCES car_shop.cars(id), 
  FOREIGN KEY (customer_id) REFERENCES car_shop.customers(id), 
  FOREIGN KEY (discount_id) REFERENCES car_shop.discounts(id)
);
