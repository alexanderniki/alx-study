/*
 * Часть 1
 */

-- 1. Сделайте сквозную нумерацию товаров в порядке увеличения стоимости товаров

SELECT *, 
    row_number() OVER (ORDER BY price)
FROM product;


-- 2. На какую сумму увеличивается или уменьшается стоимость товара относительно 
-- предыдущей стоимости, если делать сортировку по идентификатору товара?

SELECT
    product_id, 
    price,
    price - lag(price) OVER (ORDER BY product_id)
FROM product;


-- 3. В виде одной строки выведите фамилию и имя всех покупателей, которые 
-- купили на наименьшую сумму.

SELECT
    concat(c.last_name, ' ', c.first_name)
FROM (
    SELECT
        customer_id,
        sum(amount),
        DENSE_RANK() OVER (ORDER BY sum(amount) ASC)
    FROM
        orders
    GROUP BY
        customer_id
    ) t
JOIN customer c
    ON c.customer_id = t.customer_id
WHERE
    DENSE_RANK = 1;


-- 4. В виде одной строки выведите фамилию и имя всех покупателей, которые купили на 
наименьшую сумму.

SELECT concat(last_name, ' ', first_name)
FROM customer
WHERE 
    customer_id IN (
        SELECT customer_id 
        FROM orders
        GROUP BY customer_id
        HAVING sum(amount) = (
            SELECT sum(amount)
            FROM orders
            GROUP BY customer_id
            ORDER BY sum(amount) ASC
            LIMIT 1
        )
    )



-- 5. Выведите названия всех товаров и общее количество этих товаров в заказах.
    
SELECT
    p.product,
    opl.count
FROM product p
LEFT JOIN (
    SELECT product_id, count(amount)
    FROM order_product_list
    GROUP BY product_id 
) opl
    ON opl.product_id = p.product_id;



/*
 * Часть 2
 */

-- 1. Получите накопительный итог стоимости заказов по каждому пользователю в 
-- отдельности (сортировка по идентификатору заказа).

SELECT
    order_id,
    customer_id,
    amount,
    sum(amount) OVER (PARTITION BY customer_id ORDER BY order_id)
FROM orders;


-- 2. Выведите данные по 5 заказу каждого пользователя (сортировка по идентификатору заказа).

SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_id)
    FROM orders
) t
WHERE t.ROW_NUMBER = 5;


-- Получите среднее значение товаров в заказе для каждого пользователя.
-- Добавьте информацию по заказам и пользователям.
-- Получите среднее значение среднего значения товаров в заказе для каждого пользователя.
-- Сделайте сортировку по идентификатору пользователя.

SELECT c.customer_id, avg(opl.avg)
FROM (
    SELECT 
        order_id,
        avg(amount)
    FROM order_product_list
    GROUP BY order_id
) opl
JOIN orders o 
    ON o.order_id = opl.order_id
JOIN customer c
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY c.customer_id;


/* 
 * Часть 3
 */


-- 1. Найдите категорию товара, у которой наибольшее процентное отношение 
-- количества товаров от общего количества товаров.
-- Какова будет процентная доля у этой категории?


SELECT
    category.category,
    pr.products_amount, 
    pr.products_amount::NUMERIC * 100 / (
        SELECT count(*)
        FROM product
    ) AS percentage
FROM (
    SELECT
        category_id,
        count(product_id) AS products_amount
    FROM product
    GROUP BY category_id
) pr
JOIN category
    ON pr.category_id = category.category_id
ORDER BY percentage DESC;


-- 2. Из какой категории или категорий куплено на наибольшую сумму, без учета скидки?
-- Так как есть вероятность получения нескольких категорий, в решении можно 
-- использовать ранжирование.

SELECT
    tbl.category_id,
    tbl.category,
    sum(tbl.amount) AS total
FROM (
    SELECT
        opr.order_id,
        opr.product_id,
        orders.amount,
        product.category_id,
        category.category 
    FROM order_product_list opr
    JOIN orders
        ON opr.order_id = orders.order_id 
    JOIN product
        ON opr.product_id = product.product_id
    JOIN category
        ON product.category_id = category.category_id
) tbl
GROUP BY
    category_id, 
    tbl.category
ORDER BY total DESC;


-- 3. Были ли ситуации, когда стоимость заказа для каждого пользователя в отдельности 
-- была выше ровно на 25% по отношению к предыдущему заказу (сортировка по идентификатору 
-- заказа)? Если работать с заказами каждого пользователя в отдельности.

SELECT * FROM (
    SELECT
        customer_id,
        order_id,
        amount,
        amount / lag(amount) OVER (
            PARTITION BY customer_id 
            ORDER BY order_id 
        ) AS percentage
    FROM orders
) tbl
WHERE percentage = 1.25;
