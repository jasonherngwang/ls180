-- Setup
DROP DATABASE IF EXISTS single_table;
CREATE DATABASE single_table;

\c single_table

DROP TABLE IF EXISTS public.people;
DROP TABLE IF EXISTS public.birds;
DROP TABLE IF EXISTS public.menu_items;


-- Question 1
CREATE TABLE people (
    id         serial PRIMARY KEY,
    name       text,
    age        integer,
    occupation text
);


-- Question 2
INSERT INTO people (name, age, occupation)
VALUES ('Abby',      34, 'biologist'),
       ('Mu''nisah', 26, NULL),
       ('Mirabelle', 40, 'contractor');

SELECT * FROM people;


-- Question 3
SELECT *
  FROM people
 WHERE id = 2;

SELECT *
  FROM people
 LIMIT 1
OFFSET 1;

SELECT *
  FROM people
 WHERE occupation IS NULL;


 -- Question 4
 CREATE TABLE birds (
    id       serial PRIMARY KEY,
    name     varchar(255) NOT NULL,
    length   decimal(4, 1),
    wingspan decimal(4, 1),
    family   varchar(255),
    extinct  boolean DEFAULT false
);


-- Question 5
INSERT INTO birds (name, length, wingspan, family, extinct)
VALUES ('Spotted Towhee',    21.6, 26.7, 'Emberizidae',  'f'),
       ('American Robin',    25.5, 36.0, 'Turdidae',     'f'),
       ('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', 't'),
       ('Carolina Parakeet', 33.0, 55.8, 'Psittacidae',  't'),
       ('Common Kestrel',    35.5, 73.5, 'Falconidae',   'f');

SELECT * FROM birds;


-- Question 6
   SELECT name, family
     FROM birds
    WHERE extinct = false
 ORDER BY length DESC;


 -- Question 7
 SELECT round(avg(wingspan), 1),
        min(wingspan),
        max(wingspan)
   FROM birds;


-- Question 8
CREATE TABLE menu_items (
    id              serial PRIMARY KEY,
    item            varchar(255),
    prep_time       integer,
    ingredient_cost decimal(5, 2),
    sales           integer,
    menu_price      decimal(5, 2)
);


-- Question 9
INSERT INTO menu_items (item, prep_time, ingredient_cost, sales, menu_price)
VALUES ('omelette', 10, 1.50, 182, 7.99),
       ('tacos',     5, 2.00, 254, 8.99),
       ('oatmeal',   1, 0.50,  79, 5.99);

SELECT * FROM menu_items;


-- Question 10
  SELECT item,
         (menu_price - ingredient_cost) AS profit
    FROM menu_items
ORDER BY profit DESC
   LIMIT 1;


-- Question 11
  SELECT item,
         menu_price,
         ingredient_cost,
         round(prep_time / 60.0 * 13, 2) AS labor,
         menu_price - ingredient_cost - round(prep_time / 60.0 * 13, 2) AS profit
    FROM menu_items
ORDER BY profit DESC;

-- Using subquery
SELECT item,
       menu_price,
       ingredient_cost,
       labor,
       menu_price - ingredient_cost - labor AS profit
  FROM (SELECT item,
               menu_price,
               ingredient_cost,
               round(prep_time / 60.0 * 13, 2) AS labor
          FROM menu_items
       ) AS profits
 ORDER BY profit DESC;


-- Teardown
\c jason
DROP DATABASE single_table;