/*
 * Часть 1
 */


-- 1. Напишите запрос, который выведет из таблицы с 
-- пользователями столбцы с именем и фамилией и для этих столбцов 
-- задайте алиасы, присоедините таблицу с адресами и выведите 
-- значение адреса

SELECT
    c.first_name,
    c.last_name,
    a.address 
FROM customer c 
JOIN address a 
    ON c.address_id = a.address_id;


-- 2. Напишите запрос, который выведет из таблицы с 
-- пользователями столбцы с именем и фамилией и для этих 
-- столбцов задайте алиасы, присоедините таблицу с адресами и 
-- выведите значение адреса, добавьте таблицу с городами и 
-- выведите значение города. 

SELECT
    c.first_name,
    c.last_name,
    a.address,
    ct.city
FROM customer c 
JOIN address a 
    ON c.address_id = a.address_id
JOIN city ct 
    ON a.city_id = ct.city_id;



-- 3. Напишите запрос, который выведет количество 
-- товаров в категории "Музыка"

SELECT count(*)
FROM category cat
JOIN product p
    ON p.category_id = cat.category_id 
WHERE 
    cat.category = 'Музыка';



/*
 * Часть 2
 */


-- 1. Выведите имя и фамилию пользователя из города “Aden”

SELECT
    customer.first_name,
    customer.last_name,
    city.city 
FROM customer
JOIN address
    ON customer.address_id = address.address_id
JOIN city
    ON address.city_id = city.city_id 
WHERE
    city.city = 'Aden';


-- 2. Получите количество сотрудников, которые числятся в “Группа развития розничных продаж”.

SELECT count(*)
FROM staff s
JOIN "structure" s2
    ON s.unit_id = s2.unit_id
WHERE 
    s2.unit = 'Группа развия розничных продаж';


-- 3.Получите среднее значение платежей по каждому пользователю, при этом работать 
-- нужно только с пользователями, у которых первая буква фамилии начинается на “А”.

SELECT avg(orders.amount)
FROM customer
JOIN orders
    ON orders.customer_id = customer.customer_id
WHERE
    customer.last_name ILIKE 'a%';


-- 4. Получите максимальное значение стоимости товара, если работать только с теми 
-- товарами, стоимость которых находятся в диапазоне от 0 до 50.

SELECT max(price)
FROM product
WHERE 
    price >= 0 AND 
    price <= 50;


-- 5. Выведите названия категорий в которой находится более 30 товаров.

SELECT category.category
FROM product
JOIN category
    ON category.category_id = product.category_id
GROUP BY category.category_id 
    HAVING count(*) > 30;



/*
 * Часть 3
 */


-- 1. Какое количество платежей было совершено?

SELECT count(*)
FROM orders;


-- 2. Какое количество заказов было совершено пользователями из города “El Alto”?

SELECT count(*)
FROM orders
JOIN customer
    ON orders.customer_id = customer.customer_id 
JOIN address
    ON customer.address_id = address.address_id 
JOIN city
    ON address.city_id = city.city_id
WHERE 
    city.city = 'El Alto';


-- 3. Сколько “Черепах” купила “Williams Linda”?

SELECT count(*)
FROM order_product_list
JOIN orders
    ON order_product_list.order_id = orders.order_id 
JOIN product
    ON order_product_list.product_id = product.product_id
JOIN customer
    ON orders.customer_id = customer.customer_id
WHERE 
    product.product LIKE 'Черепаха' AND 
    customer.first_name LIKE 'Linda' AND 
    customer.last_name LIKE 'Williams';


-- 4. Сколько уникальных пользователей совершали покупки товаров из категории “Игрушки”?

SELECT count(DISTINCT(orders.customer_id))
FROM order_product_list
JOIN orders
    ON order_product_list.order_id = orders.order_id 
JOIN product
    ON order_product_list.product_id = product.product_id
JOIN category
    ON product.category_id = category.category_id
WHERE 
    category.category LIKE 'Игрушки';