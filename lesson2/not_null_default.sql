-- Setup
DROP DATABASE IF EXISTS employees_temperatures;
CREATE DATABASE employees_temperatures;

\c employees_temperatures

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS temperatures;

CREATE TABLE employees (
    first_name         character varying(100),
    last_name          character varying(100),
    department         character varying(100),
    vacation_remaining integer
);

INSERT INTO employees
VALUES ('Leonardo', 'Ferreira', 'finance', 14);

INSERT INTO employees
VALUES ('Sara', 'Mikaelsen', 'operations', 14);

INSERT INTO employees
VALUES ('Lian', 'Ma', 'marketing', 13);

ALTER TABLE employees
ALTER COLUMN vacation_remaining
  SET NOT NULL;

ALTER TABLE employees
ALTER COLUMN vacation_remaining
  SET DEFAULT 0;

INSERT INTO employees (first_name, last_name)
VALUES ('Haiden', 'Smith');

SELECT *
  FROM employees
 ORDER BY vacation_remaining DESC;

SELECT *,
       vacation_remaining * 15.50 * 8 AS amount
  FROM employees
 ORDER BY vacation_remaining DESC;


-- Question 2
ALTER TABLE employees
ALTER COLUMN department
  SET DEFAULT 'unassigned';

UPDATE employees
   SET department = 'unassigned'
 WHERE department IS NULL;

ALTER TABLE employees
ALTER COLUMN department
  SET NOT NULL;

\d employees
TABLE employees;


-- Question 3
CREATE TABLE temperatures (
    "date" date    NOT NULL,
    low    integer NOT NULL,
    high   integer NOT NULL
);


-- Question 4
INSERT INTO temperatures
VALUES ('2016-03-01', 34, 43),
       ('2016-03-02', 32, 44),
       ('2016-03-03', 31, 47),
       ('2016-03-04', 33, 42),
       ('2016-03-05', 39, 46),
       ('2016-03-06', 32, 43),
       ('2016-03-07', 29, 32),
       ('2016-03-08', 23, 31),
       ('2016-03-09', 17, 28);

TABLE temperatures;


-- Question 5
SELECT date,
       round((low + high) / 2.0, 1) AS avg
    --    ((low + high) / 2.0)::decimal(3, 1) AS avg
    --    cast((low + high) / 2.0 AS decimal(3, 1)) AS avg
  FROM temperatures
 WHERE date BETWEEN '2016-03-02' AND '2016-03-08';


-- Question 6
ALTER TABLE temperatures
  ADD COLUMN rainfall integer DEFAULT 0;

\d temperatures


-- Question 7
UPDATE temperatures
   SET rainfall = (low + high) / 2 - 35
 WHERE (low + high) / 2 > 35;

SELECT * FROM temperatures;


-- Question 8
ALTER TABLE temperatures
ALTER COLUMN rainfall
 TYPE decimal(6, 3);

UPDATE temperatures
   SET rainfall = rainfall / 25.4;

TABLE temperatures;


-- Question 9
 ALTER TABLE temperatures
RENAME TO weather;

\d


-- Question 10
\d weather


-- Question 11
-- pg_dump -d employees_temperatures -t weather --inserts > weather_dump.sql


-- Teardown
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS temperatures;
DROP TABLE IF EXISTS weather;

\c jason
DROP DATABASE employees_temperatures;