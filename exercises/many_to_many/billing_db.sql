/*
Billing Database for a webhosting services company
- Customers (many) to Services (many)
- A Customer have have no services.
- A Services must have a customer.
*/


-- To execute:
-- psql -d jason < billing_db.sql

-- Setup
DROP DATABASE IF EXISTS billing;
CREATE DATABASE billing;

\c billing

-- Exercise 1: Set Up Database
CREATE TABLE customers (
    id            serial  PRIMARY KEY,
    name          text    NOT NULL,
    payment_token char(8) NOT NULL
                          CHECK (payment_token ~ '^[A-Z]{8}$')
);

CREATE TABLE services (
    id          serial         PRIMARY KEY,
    description text           NOT NULL,
    price       numeric(10, 2) NOT NULL
                               CHECK (price >= 0.00)
);

-- Insert data
INSERT INTO customers (name, payment_token)
VALUES ('Pat Johnson',   'XHGOAHEQ'),
       ('Nancy Monreal', 'JKWQPJKL'),
       ('Lynn Blake',    'KLZXWEEE'),
       ('Chen Ke-Hua',   'KWETYCVX'),
       ('Scott Lakso',   'UUEAPQPS'),
       ('Jim Pornot',    'XKJEYAZA');

INSERT INTO services (description, price)
VALUES ('Unix Hosting',          5.95),
       ('DNS',                   4.95),
       ('Whois Registration',    1.95),
       ('High Bandwidth',       15.00),
       ('Business Support',    250.00),
       ('Dedicated Hosting',    50.00),
       ('Bulk Email',          250.00),
       ('One-to-one Training', 999.00);

-- Create join table
CREATE TABLE customers_services (
    id serial PRIMARY KEY,
    customer_id integer NOT NULL
                        REFERENCES customers (id)
                        ON DELETE CASCADE,
    service_id  integer NOT NULL
                        REFERENCES services (id),
    UNIQUE (customer_id, service_id)
);

-- Insert data into join table
INSERT INTO customers_services (customer_id, service_id)
VALUES (1, 1), (1, 2), (1, 3),
       (3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
       (4, 1), (4, 4),
       (5, 1), (5, 2), (5, 6),
       (6, 1), (6, 6), (6, 7);

-- Alternative INSERT
-- INSERT INTO customers_services (customer_id, service_id)
--     SELECT customers.id, services.id
--       FROM customers
--      CROSS JOIN services
--      WHERE (name = 'Pat Johnson' AND description IN ('Unix Hosting', 'DNS', 'Whois Registration'))
--         OR (name = 'Lynn Blake'  AND description IN ('Unix Hosting', 'DNS', 'Whois Registration', 'High Bandwidth', 'Business Support'))
--         OR (name = 'Chen Ke-Hua' AND description IN ('Unix Hosting', 'High Bandwidth'))
--         OR (name = 'Scott Lakso' AND description IN ('Unix Hosting', 'DNS', 'Dedicated Hosting'))
--         OR (name = 'Jim Pornot'  AND description IN ('Unix Hosting', 'Dedicated Hosting', 'Bulk Email'))
-- ;


\d customers
TABLE customers;
\d services
TABLE services;
\d customers_services
TABLE customers_services;

-- Question 2: Get Customers with Services
-- EXPLAIN ANALYZE
SELECT DISTINCT customers.* 
  FROM customers
  JOIN customers_services
    ON customers.id = customers_services.customer_id;

-- Alternative, using GROUP BY
-- EXPLAIN ANALYZE
-- SELECT customers.*
--   FROM customers
--   JOIN customers_services
--     ON customers.id = customers_services.customer_id
--  GROUP BY customers.id;

 -- Using subquery
--  EXPLAIN ANALYZE
--  SELECT *
--   FROM customers
--  WHERE id IN (SELECT DISTINCT customer_id
--                 FROM customers_services);
 
--  EXPLAIN ANALYZE
--  SELECT *
--   FROM customers
--  WHERE id IN (SELECT customer_id
--                 FROM customers_services);


-- Question 3: Get Customers with No Services
SELECT c.*
  FROM customers AS c
  LEFT JOIN customers_services AS cs
    ON c.id = cs.customer_id
 WHERE cs.service_id IS NULL;


-- Using EXISTS
SELECT c.*
 FROM customers c
WHERE NOT EXISTS (SELECT 1
                    FROM customers_services
                   WHERE customers_services.customer_id = c.id);

-- Using subquery
SELECT *
  FROM customers c
 WHERE c.id NOT IN (SELECT customer_id
                      FROM customers_services);

-- Further Exploration: Display customers w/o service, and vice versa.
SELECT c.*,
       s.*
  FROM customers c
  FULL JOIN customers_services cs
    ON c.id = cs.customer_id
  FULL JOIN services s
    ON s.id = cs.service_id
 WHERE cs.id IS NULL;


-- Question 4: Get Services with No Customers
SELECT s.description
  FROM customers_services cs
 RIGHT JOIN services s
    ON s.id = cs.service_id
 WHERE cs.id IS NULL;

-- Using EXISTS
SELECT s.description
  FROM services s
 WHERE NOT EXISTS (SELECT 1
                     FROM customers_services cs
                    WHERE s.id = cs.service_id);

-- Using subquery
SELECT s.description
  FROM services s
 WHERE s.id NOT IN (SELECT service_id
                      FROM customers_services cs);


-- Question 5: Services for Each Customer
SELECT c.name,
       string_agg(s.description, ', ') AS services
  FROM customers c
  LEFT JOIN customers_services cs
    ON c.id = cs.customer_id
  LEFT JOIN services s
    ON cs.service_id = s.id
 GROUP BY c.name;

-- Using subqueries
SELECT c.name,
       (SELECT string_agg(s.description, ', ')
          FROM services s
         WHERE s.id IN (SELECT cs.service_id
                          FROM customers_services cs
                         WHERE cs.customer_id = c.id)
       ) AS services
  FROM customers c;

 -- Further Exploration with Window Functions
SELECT CASE WHEN c.name = lag(c.name) OVER (ORDER BY c.name)
            THEN ''
            ELSE c.name
            END,
       s.description
  FROM customers c
  LEFT JOIN customers_services cs
    ON c.id = cs.customer_id
  LEFT JOIN services s
    ON cs.service_id = s.id;


-- Question 6: Services with At Least 3 Customers
SELECT s.description,
       count(cs.id)
  FROM services s
  JOIN customers_services cs
    ON s.id = cs.service_id
 GROUP BY s.id
HAVING count(cs.id) >= 3
 ORDER BY s.description;

-- Using subqueries
SELECT description,
       count
  FROM (SELECT s.description,
               (SELECT count(cs.customer_id)
                  FROM customers_services cs
                 WHERE s.id = cs.service_id
               ) AS count
          FROM services s) AS service_enrollments
 WHERE count >= 3;

-- Using CTE
WITH service_enrollments AS (SELECT s.description,
                                    (SELECT count(cs.customer_id)
                                       FROM customers_services cs
                                      WHERE s.id = cs.service_id
                                    ) AS count
                               FROM services s)
SELECT description,
       count
  FROM service_enrollments
 WHERE count >= 3
 ORDER BY description;


-- Question 7: Total Gross Income
SELECT sum(s.price) AS gross
  FROM services s
  JOIN customers_services cs
    ON s.id = cs.service_id;

-- Use subquery
SELECT sum(s.price * (SELECT count(cs.customer_id)
                        FROM customers_services cs
                       WHERE cs.service_id = s.id
                     )
          ) AS gross
  FROM services s;


-- Question 8: Add New Customer
INSERT INTO customers (name, payment_token)
VALUES ('John Doe', 'EYODHLCN');

INSERT INTO customers_services (customer_id, service_id)
VALUES (7, 1), (7, 2), (7, 3);

DELETE FROM customers_services
 WHERE customer_id = 7;

-- Using SELECT instead of VALUES
INSERT INTO customers_services (customer_id, service_id)
SELECT c.id,
       s.id
  FROM customers c
 CROSS JOIN services s
 WHERE (c.name = 'John Doe' AND c.payment_token = 'EYODHLCN' AND s.description = 'Unix Hosting')
    OR (c.name = 'John Doe' AND c.payment_token = 'EYODHLCN' AND s.description = 'DNS')
    OR (c.name = 'John Doe' AND c.payment_token = 'EYODHLCN' AND s.description = 'Whois Registration');

-- Check that data were correctly inserted
TABLE customers;
SELECT description
  FROM services
 WHERE id IN (SELECT service_id
                FROM customers_services
               WHERE customer_id = 7);


-- Question 9: Hypothetically
-- Using inner join
SELECT sum(s.price) AS gross
  FROM services s
  JOIN customers_services cs
    ON s.id = cs.service_id
 WHERE s.price > 100;

-- Using subquery
SELECT count(customers.id) * (SELECT sum(s.price)
                                FROM services s
                               WHERE s.price > 100
                             ) AS sum
  FROM customers;

-- Multiplying scalar subqueries
SELECT (SELECT count(*)
          FROM customers
       ) * 
       (SELECT sum(price)
          FROM services
         WHERE price > 100
       ) AS sum;

-- Using cross join
SELECT sum(services.price)
  FROM customers
 CROSS JOIN services
 WHERE services.price > 100;


-- Question 10: Deleting Rows
-- ON DELETE CASCADE automatically deletes rows in join table referencing CHen Ke-Hua.
DELETE FROM customers
 WHERE name = 'Chen Ke-Hua';

-- Must delete foreign keys before primary keys.
DELETE FROM customers_services
 WHERE service_id = 7;

DELETE FROM services
 WHERE description = 'Bulk Email';

TABLE customers;
TABLE services;
TABLE customers_services;


-- Teardown
\c jason
DROP DATABASE billing;