\echo 'Create & View Tables, Exercise 10 --------------------'
CREATE TABLE orders (
    id serial,
    customer_name varchar(100) NOT NULL,
    burger varchar(50),
    side varchar(50),
    drink varchar(50),
    order_total decimal(4, 2) NOT NULL
);

\d orders

\echo 'Alter Tables, Exercise 7 --------------------'
ALTER TABLE orders
    ADD COLUMN customer_email varchar(50),
    ADD COLUMN customer_loyalty_points integer DEFAULT 0;

\d orders

\echo 'Alter Tables, Exercise 8 --------------------'
ALTER TABLE orders
    ADD COLUMN burger_cost decimal(4, 2) DEFAULT 0,
    ADD COLUMN side_cost decimal(4, 2) DEFAULT 0,
    ADD COLUMN drink_cost decimal(4, 2) DEFAULT 0;

\d orders

\echo 'Alter Tables, Exercise 9 --------------------'
ALTER TABLE orders
    DROP COLUMN order_total;

\d orders

\echo 'Add Data, Exercises 10 --------------------'
INSERT INTO orders (customer_name, customer_email, burger, side, drink, customer_loyalty_points, burger_cost, side_cost, drink_cost)
    VALUES ('James Bergman', 'james1998@email.com', 'LS Chicken Burger', 'Fries', 'Cola', 28, 4.50, 0.99, 1.50),
           ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Cheeseburger', 'Fries', NULL, 18, 3.50, 0.99, DEFAULT),
           ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Double Deluxe Burger', 'Onion Rings', 'Chocolate Shake', 42, 6.00, 1.50, 2.00),
           ('Aaron Muller', NULL, 'LS Burger', NULL, NULL, 10, 3.00, DEFAULT, DEFAULT);

SELECT * FROM orders;

\echo 'SELECT, Exercise 13 --------------------'
SELECT burger FROM orders
WHERE burger_cost < 5.00
ORDER BY burger_cost;

\echo 'SELECT, Exercise 14 --------------------'
SELECT customer_name, customer_email, customer_loyalty_points
FROM orders
WHERE customer_loyalty_points >= 20
ORDER BY customer_loyalty_points DESC;

\echo 'SELECT, Exercise 15 --------------------'
SELECT burger FROM orders
WHERE customer_name = 'Natasha O''Shea';

\echo 'SELECT, Exercise 16 --------------------'
SELECT customer_name FROM orders
WHERE drink IS NULL;

\echo 'SELECT, Exercise 17 --------------------'
SELECT burger, side, drink
FROM orders
WHERE side != 'Fries'
OR side IS NULL;

\echo 'SELECT, Exercise 18 --------------------'
SELECT burger, side, drink
FROM orders
WHERE side IS NOT NULL
AND drink IS NOT NULL;


\echo 'More on Select, Exercise 12'
SELECT avg(burger_cost) FROM orders
WHERE side = 'Fries';

\echo 'More on Select, Exercise 13'
SELECT min(side_cost) FROM orders
WHERE side IS NOT NULL;

\echo 'More on Select, Exercise 14'
SELECT side, count(id) FROM orders
WHERE side = 'Fries' OR side = 'Onion Rings'
GROUP BY side;


\echo 'Update Data, Exercise 8'
UPDATE orders
SET drink = 'Lemonade'
WHERE customer_name = 'James Bergman';

SELECT * FROM orders;

\echo 'Update Data, Exercise 9'
UPDATE orders
SET side = 'Fries'
    side_cost = 0.99,
    customer_loyalty_points = 13
WHERE customer_name = 'Aaron Muller';

SELECT * FROM orders;

\echo 'Update Data, Exercise 9'
UPDATE orders
SET side_cost = 1.20
WHERE side = 'Fries';

SELECT * FROM orders;

\echo 'Multiple Tables, Exercise 4'
-- CREATE TABLE orders (
--     id serial,
--     customer_name varchar(100) NOT NULL,
--     burger varchar(50),
--     side varchar(50),
--     drink varchar(50),
--     order_total decimal(4, 2) NOT NULL
-- );
CREATE TABLE customers (
    id serial PRIMARY KEY,
    customer_name varchar(100)
);
CREATE TABLE email_addresses (
    customer_id int,
    customer_email varchar(50) NOT NULL,
    PRIMARY KEY (customer_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
);

INSERT INTO customers (customer_name)
    VALUES ('James Bergman'),
           ('Natasha O''Shea'),
           ('Aaron Muller');
INSERT INTO email_addresses (customer_id, customer_email)
    VALUES (1, 'james1998@email.com'),
           (2, 'natasha@osheafamily.com');

SELECT * FROM customers;
SELECT * FROM email_addresses;

\echo 'Multiple Tables, Exercise 5'
CREATE TABLE products (
    id serial PRIMARY KEY,
    product_name varchar(50) NOT NULL,
    product_cost decimal(4, 2) DEFAULT 0,
    product_type varchar(20),
    product_loyalty_points integer DEFAULT 0
);

INSERT INTO products (product_name, product_cost, product_type, product_loyalty_points)
VALUES ('LS Burger', 3.00, 'Burger', 10),
       ('LS Cheeseburger', 3.50, 'Burger', 15),
       ('LS Chicken Burger', 4.50, 'Burger', 20),
       ('LS Double Deluxe Burger', 6.00, 'Burger', 30),
       ('Fries', 1.20, 'Side', 3),
       ('Onion Rings', 1.50, 'Side', 5),
       ('Cola', 1.50, 'Drink', 5),
       ('Lemonade', 1.50, 'Drink', 5),
       ('Vanilla Shake', 2.00, 'Drink', 7),
       ('Chocolate Shake', 2.00, 'Drink', 7),
       ('Strawberry Shake', 2.00, 'Drink', 7);

SELECT * FROM products;

\echo 'Multiple Tables, Exercise 6'
DROP TABLE orders;

CREATE TABLE orders (
    id serial PRIMARY KEY,
    customer_id integer NOT NULL,
    order_status varchar(20),
    FOREIGN KEY (customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
);

CREATE TABLE order_items (
    id serial PRIMARY KEY,
    order_id integer NOT NULL,
    product_id integer NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES orders (id)
        ON DELETE CASCADE,
    FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE CASCADE
);

\d order_items
\d orders

-- James (1) has one order, consisting of a Chicken Burger (3), Fries (5), Onion Rings (6), and a Lemonade (8).
-- It has a status of 'In Progress'.

-- Create order
INSERT INTO orders (customer_id, order_status)
VALUES (1, 'In Progress');

-- Add products.
INSERT INTO order_items (order_id, product_id)
VALUES (1, 3), (1, 5), (1, 6), (1, 8);

-- Natasha's two orders
INSERT INTO orders (customer_id, order_status)
VALUES (2, 'Placed'),
       (2, 'Complete');

INSERT INTO order_items (order_id, product_id)
VALUES (2, 2), (2, 5), (2, 7),
       (3, 4), (3, 2), (3, 5), (3, 5), (3, 6), (3, 10), (3, 9);

-- Aaron's order
INSERT INTO orders (customer_id, order_status)
VALUES (3, 'Placed');

INSERT INTO order_items (order_id, product_id)
VALUES (4, 1), (4, 5);

SELECT * FROM order_items;
SELECT * FROM orders;


\echo 'JOINs, Exercise 7'
SELECT * --o.id AS "Order", p.product_name AS "Product"
    FROM orders o
    JOIN order_items oi
        ON o.id = oi.order_id
    JOIN products p
        ON p.id = oi.product_id;

\echo 'JOINs, Exercise 8'
SELECT o.id AS "Order", p.product_name AS "Product"
    FROM orders o
    JOIN order_items oi
        ON o.id = oi.order_id
    JOIN products p
        ON p.id = oi.product_id
    WHERE p.product_name = 'Fries';

\echo 'JOINs, Exercise 9'
SELECT DISTINCT c.customer_name AS "Customers who like Fries"
    FROM orders o
    JOIN order_items oi
        ON o.id = oi.order_id
    JOIN products p
        ON p.id = oi.product_id
    JOIN customers c
        ON c.id = o.customer_id
    WHERE p.product_name = 'Fries';

\echo 'JOINs, Exercise 10'
SELECT sum(p.product_cost)
    FROM customers c
    JOIN orders o
        ON c.id = o.customer_id
    JOIN order_items oi
        ON o.id = oi.order_id
    JOIN products p
        ON p.id = oi.product_id
    WHERE c.customer_name = 'Natasha O''Shea';

\echo 'JOINs, Exercise 11'
SELECT p.product_name AS "Product", count(p.product_name) AS "Count"
    FROM order_items oi
    JOIN products p
        ON p.id = oi.product_id
    GROUP BY p.product_name
    ORDER BY p.product_name ASC;