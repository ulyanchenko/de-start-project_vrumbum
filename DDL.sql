/*Добавьте в этот файл все запросы, для создания схемы данных автосалона и
 таблиц в ней в нужном порядке*/
CREATE SCHEMA IF NOT EXISTS car_shop;

CREATE TABLE IF NOT EXISTS car_shop.makes (
  id SERIAL PRIMARY KEY, 
  name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS car_shop.car_models (
  id SERIAL PRIMARY KEY, 
  name VARCHAR(255) NOT NULL UNIQUE, 
  make_id INT NOT NULL, 
  FOREIGN KEY (make_id) REFERENCES car_shop.makes(id)
);

CREATE TABLE IF NOT EXISTS car_shop.colors (
  id SERIAL PRIMARY KEY, 
  color VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS car_shop.cars (
  id SERIAL PRIMARY KEY, 
  model_id INT NOT NULL, 
  gasoline_consumption DECIMAL(5, 2), 
  brand_origin VARCHAR(255), 
  color_id INT NOT NULL, 
  FOREIGN KEY (model_id) REFERENCES car_shop.car_models(id), 
  FOREIGN KEY (color_id) REFERENCES car_shop.colors(id)
);

CREATE TABLE IF NOT EXISTS car_shop.customers (
  id SERIAL PRIMARY KEY, 
  person_name VARCHAR(255), 
  phone VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS car_shop.sales (
  id SERIAL PRIMARY KEY, 
  car_id INT NOT NULL, 
  customer_id INT NOT NULL, 
  sale_date DATE, 
  price DECIMAL(10, 2), 
  discount DECIMAL(5, 2) DEFAULT 0, 
  FOREIGN KEY (car_id) REFERENCES car_shop.cars(id), 
  FOREIGN KEY (customer_id) REFERENCES car_shop.customers(id)
);
