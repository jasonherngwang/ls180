-- To execute:
-- psql -d jason < animals.sql

-- 1. Create and connect to db
DROP DATABASE IF EXISTS animals;
CREATE DATABASE animals;
-- createdb animals

\c animals

-- 2. Create Table
CREATE TABLE birds (
    id      serial PRIMARY KEY,
    name    varchar(25),
    age     integer,
    species varchar(15)
);

\d birds


-- 3. Insert Data

-- Omitting id
-- INSERT INTO birds (name, age, species)
-- VALUES ('Charlie',  3, 'Finch'),
--        ('Allie',    5, 'Owl'),
--        ('Jennifer', 3, 'Magpie'),
--        ('Jamie',    4, 'Owl'),
--        ('Roy',      8, 'Crow');

-- Without specifying column names
INSERT INTO birds
VALUES (DEFAULT, 'Charlie',  3, 'Finch'),
       (DEFAULT, 'Allie',    5, 'Owl'),
       (DEFAULT, 'Jennifer', 3, 'Magpie'),
       (DEFAULT, 'Jamie',    4, 'Owl'),
       (DEFAULT, 'Roy',      8, 'Crow');


-- 4. Select Data
SELECT * FROM birds;
-- SELECT id, name, age, species FROM birds;


-- 5. WHERE Clause
SELECT * FROM birds
 WHERE age < 5;


-- 6. Update Data
UPDATE birds
   SET species = 'Raven'
 WHERE species = 'Crow';

SELECT * FROM birds;

UPDATE birds
   SET species = 'Hawk'
 WHERE name = 'Jamie';

SELECT * FROM birds;


-- 7. Delete Data
DELETE FROM birds
 WHERE age = 3
   AND species = 'Finch';

SELECT * FROM birds;


-- 8. Add Table Constraint
ALTER TABLE birds
  ADD CONSTRAINT check_age CHECK (age > 0);

-- Shorthand form
-- ALTER TABLE birds
--   ADD CHECK (age > 0);

\d birds

-- Fails check
-- INSERT INTO birds (name, age, species)
-- VALUES ('Jason', -9, 'Penguin');


-- 9. Drop Table
DROP TABLE IF EXISTS birds;


-- 10. Drop Database
-- Switch db so current db can be deleted.
\c jason

-- dropdb animals (from CLI)
DROP DATABASE animals;