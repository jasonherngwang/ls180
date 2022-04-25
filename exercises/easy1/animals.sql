-- 1. Create a db
-- createdb animals (from CLI)
-- CREATE DATABASE animals;

-- 2. Create Table
CREATE TABLE birds (
    id serial PRIMARY KEY,
    name varchar(25),
    age integer,
    species varchar(15)
);

\d birds

-- 3. Insert Data
-- INSERT INTO birds (name, age, species)
-- VALUES ('Charlie', 3, 'Finch'),
--        ('Allie', 5, 'Owl'),
--        ('Jennifer', 3, 'Magpie'),
--        ('Jamie', 4, 'Owl'),
--        ('Roy', 8, 'Crow');

-- Without specifying columns
INSERT INTO birds
VALUES (DEFAULT, 'Charlie', 3, 'Finch'),
       (DEFAULT, 'Allie', 5, 'Owl'),
       (DEFAULT, 'Jennifer', 3, 'Magpie'),
       (DEFAULT, 'Jamie', 4, 'Owl'),
       (DEFAULT, 'Roy', 8, 'Crow');

SELECT * FROM birds;

-- 4. Select Data
SELECT * FROM birds;

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
WHERE age = 3 AND species = 'Finch';

SELECT * FROM birds;

-- 8. Add Constraint
ALTER TABLE birds
-- ADD CHECK (age > 0);
ADD CONSTRAINT check_age CHECK (age > 0);

\d birds

-- Fails check
-- INSERT INTO birds (name, age, species)
-- VALUES ('Jason', -9, 'Penguin');

-- 9. Drop Table
DROP TABLE IF EXISTS birds;

-- 10. Drop Database
-- dropdb animals (from CLI)
-- DROP DATABASE animals;