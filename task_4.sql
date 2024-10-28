/*добавьте сюда запрос для решения задания 4*/
SELECT 
    c.person_name AS person,
    STRING_AGG(DISTINCT m.name || ' ' || cm.name, ', ') AS cars
FROM 
    car_shop.customers c
JOIN 
    car_shop.sales s ON c.id = s.customer_id
JOIN 
    car_shop.cars car ON car.id = s.car_id
JOIN 
    car_shop.car_models cm ON cm.id = car.model_id
JOIN 
    car_shop.makes m ON m.id = cm.make_id
GROUP BY 
    c.person_name
ORDER BY 
    c.person_name ASC;
