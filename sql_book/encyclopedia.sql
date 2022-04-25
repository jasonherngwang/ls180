\echo 'Create & View Tables, Exercise 2 --------------------'
CREATE TABLE countries (
    id serial,
    name varchar(50) UNIQUE NOT NULL,
    capital varchar(50) NOT NULL,
    population integer
);

SELECT * FROM countries;

\echo 'Create & View Tables, Exercise 3 --------------------'
CREATE TABLE famous_people (
    id serial,
    name varchar(100) NOT NULL,
    occupation varchar(150),
    date_of_birth varchar(50),
    deceased boolean DEFAULT false
);

SELECT * FROM famous_people;

\echo 'Create & View Tables, Exercise 4 --------------------'
CREATE TABLE animals (
    id serial,
    name varchar(100) NOT NULL,
    binomial_name varchar(100) NOT NULL,
    max_weight_kg decimal(8, 3),
    max_age_years integer,
    conservation_status char(2)
);

SELECT * FROM animals;

\echo 'Create & View Tables, Exercise 5 --------------------'
\dt

\echo 'Create & View Tables, Exercise 6 --------------------'
\d animals

\echo 'Alter Tables, Exercise 1 --------------------'
ALTER TABLE famous_people
    RENAME TO celebrities;

\d celebrities

\echo 'Alter Tables, Exercise 2 --------------------'
ALTER TABLE celebrities
    RENAME COLUMN name TO first_name;

ALTER TABLE celebrities
    ALTER COLUMN first_name TYPE varchar(80);

\d celebrities

\echo 'Alter Tables, Exercise 3 --------------------'
ALTER TABLE celebrities
    ADD COLUMN last_name varchar(100) NOT NULL;

\d celebrities

\echo 'Alter Tables, Exercise 4 --------------------'
ALTER TABLE celebrities
    ALTER COLUMN date_of_birth TYPE date USING date_of_birth::date,
    ALTER COLUMN date_of_birth SET NOT NULL;

\d celebrities

\echo 'Alter Tables, Exercise 5 --------------------'
ALTER TABLE animals
    ALTER COLUMN max_weight_kg TYPE decimal(10, 4);

\d animals

\echo 'Alter Tables, Exercise 6 --------------------'
ALTER TABLE animals
    ADD CONSTRAINT unique_binomial_name UNIQUE (binomial_name);

\d animals

\echo 'Add Data, Exercise 1 --------------------'
INSERT INTO countries (name, capital, population)
    VALUES ('France', 'Paris', 67158000);

SELECT * FROM countries;

\echo 'Add Data, Exercise 2 --------------------'
INSERT INTO countries (name, capital, population)
    VALUES ('USA', 'Washington D.C.', 325365189),
           ('Germany', 'Berlin', 82349400),
           ('Japan', 'Tokyo', 126672000);

SELECT * FROM countries;

\echo 'Add Data, Exercise 3 --------------------'
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
    VALUES ('Bruce', 'Springsteen', 'Singer, Songwriter', 'September 23, 1949', false);

SELECT * FROM celebrities;

\echo 'Add Data, Exercise 4 --------------------'
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
    VALUES ('Scarlett', 'Johansson', 'Actress', '11/22/1984', DEFAULT);

SELECT * FROM celebrities;

\echo 'Add Data, Exercise 5 --------------------'
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
    VALUES ('Frank', 'Sinatra', 'Singer, Actor', '1915-12-12', true),
           ('Tom', 'Cruise', 'Actor', '1962-07-03', DEFAULT);

SELECT * FROM celebrities;

\echo 'Add Data, Exercises 6 & 7 --------------------'
ALTER TABLE celebrities
    ALTER COLUMN last_name DROP NOT NULL;

INSERT INTO celebrities (first_name, occupation, date_of_birth, deceased)
    VALUES ('Madonna', 'Singer, Actress', '1958-08-16', false),
           ('Prince', 'Singer, Songwriter, Musician, Actor', '1958-06-07', true);

SELECT * FROM celebrities;

\echo 'Add Data, Exercise 8 --------------------'
INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
    VALUES ('Elvis', 'Presley', 'Singer, Musician, Actor', '1935-01-08', NULL);

SELECT * FROM celebrities;

\echo 'Add Data, Exercise 9 --------------------'
ALTER TABLE animals
    DROP CONSTRAINT unique_binomial_name;

INSERT INTO animals (name, binomial_name, max_weight_kg, max_age_years, conservation_status)
    VALUES ('Dove', 'Columbidae Columbiformes', 2, 15, 'LC'),
           ('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
           ('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
           ('Pigeon', 'Columbidae Columbiformes', 2, 15, 'LC'),
           ('Kakapo', 'Strigops habroptila', 4, 60,'CR');

SELECT * FROM animals;

\echo 'SELECT, Exercise 1 --------------------'
SELECT population FROM countries
WHERE name = 'USA';

\echo 'SELECT, Exercise 2 --------------------'
SELECT population, capital FROM countries;

\echo 'SELECT, Exercise 3 --------------------'
SELECT name FROM countries
ORDER BY name;

\echo 'SELECT, Exercise 4 --------------------'
SELECT name, capital FROM countries
ORDER BY population;

\echo 'SELECT, Exercise 5 --------------------'
SELECT name, capital FROM countries
ORDER BY population DESC;

\echo 'SELECT, Exercise 6 --------------------'
SELECT name, binomial_name, max_weight_kg, max_age_years
FROM animals
ORDER BY max_age_years, max_weight_kg, name DESC;

\echo 'SELECT, Exercise 7 --------------------'
SELECT name FROM countries
WHERE population > 70000000;

\echo 'SELECT, Exercise 8 --------------------'
SELECT name FROM countries
WHERE population > 70000000
AND population < 200000000;

\echo 'SELECT, Exercise 9 --------------------'
SELECT first_name, last_name
FROM celebrities
WHERE deceased <> true
OR deceased IS NULL;

\echo 'SELECT, Exercise 10 --------------------'
SELECT first_name, last_name
FROM celebrities
WHERE occupation LIKE '%Singer%';

\echo 'SELECT, Exercise 11 --------------------'
SELECT first_name, last_name
FROM celebrities
WHERE occupation LIKE '%Actor%'
OR occupation LIKE '%Actress%';

\echo 'SELECT, Exercise 12 --------------------'
-- Use () to group clause
SELECT first_name, last_name
FROM celebrities
WHERE (occupation LIKE '%Actor%' OR occupation LIKE '%Actress%')
AND occupation LIKE '%Singer%';

-- AND has higher precedence than OR
SELECT first_name, last_name
FROM celebrities
WHERE occupation LIKE '%Actor%' OR occupation LIKE '%Actress%'
AND occupation LIKE '%Singer%';


\echo 'More on Select, Exercise 1'
SELECT * FROM countries
LIMIT 1;

\echo 'More on Select, Exercise 2'
SELECT name FROM countries
ORDER BY population DESC
LIMIT 1;

\echo 'More on Select, Exercise 3'
SELECT name FROM countries
ORDER BY population DESC
LIMIT 1
OFFSET 1;

\echo 'More on Select, Exercise 4'
SELECT DISTINCT binomial_name FROM animals;

\echo 'More on Select, Exercise 5'
SELECT binomial_name FROM animals
ORDER BY length(binomial_name) DESC
LIMIT 1;

\echo 'More on Select, Exercise 6'
SELECT first_name FROM celebrities
WHERE date_part('year', date_of_birth) = 1958;

\echo 'More on Select, Exercise 7'
SELECT max(max_age_years) FROM animals;

\echo 'More on Select, Exercise 8'
SELECT avg(max_weight_kg) FROM animals;

\echo 'More on Select, Exercise 9'
SELECT count(id) FROM countries;

\echo 'More on Select, Exercise 10'
SELECT sum(population) FROM countries;

\echo 'More on Select, Exercise 11'
SELECT conservation_status, count(id)
FROM animals
GROUP BY conservation_status;


\echo 'Update Data, Exercise 1'
ALTER TABLE animals
    ADD COLUMN class varchar(100);

UPDATE animals SET class = 'Aves';
SELECT * FROM animals;

\echo 'Update Data, Exercise 2'
ALTER TABLE animals
    ADD COLUMN phylum varchar(100),
    ADD COLUMN kingdom varchar(100);
UPDATE animals
SET phylum = 'Chordata',
    kingdom = 'Animalia';

SELECT * FROM animals;

\echo 'Update Data, Exercise 3'
ALTER TABLE countries
    ADD COLUMN continent varchar(50);

UPDATE countries
SET continent = 'Europe'
WHERE name = 'France' OR name = 'Germany';

UPDATE countries
SET continent = 'Asia'
WHERE name = 'Japan';

UPDATE countries
SET continent = 'North America'
WHERE name = 'USA';

SELECT * FROM countries;

\echo 'Update Data, Exercise 4'
-- Elvis currently has deceased = NULL
UPDATE celebrities
SET deceased = true
WHERE first_name = 'Elvis';

ALTER TABLE celebrities
ALTER COLUMN deceased SET NOT NULL;

SELECT * FROM celebrities;
\d celebrities

\echo 'Update Data, Exercise 5'
DELETE FROM celebrities
WHERE first_name = 'Tom'
AND last_name = 'Cruise';
SELECT * FROM celebrities;

\echo 'Update Data, Exercise 6'
ALTER TABLE celebrities
RENAME TO singers;

DELETE FROM singers
WHERE occupation NOT LIKE '%Singer%';

SELECT * FROM singers;

\echo 'Update Data, Exercise 7'
DELETE FROM countries;
SELECT * FROM countries;


\echo 'Multiple Tables, Exercise 1'
CREATE TABLE continents (
    id serial PRIMARY KEY,
    continent_name varchar(50)
);

ALTER TABLE countries
    DROP COLUMN continent;

ALTER TABLE countries
    ADD COLUMN continent_id integer;

ALTER TABLE countries
    ADD FOREIGN KEY (continent_id)
    REFERENCES continents(id);

\d continents
SELECT * FROM continents;
\d countries
SELECT * FROM countries;

\echo 'Multiple Tables, Exercise 2'
INSERT INTO continents (continent_name)
    VALUES ('Africa'), ('Asia'), ('Europe'), ('North America'), ('South America');

INSERT INTO countries (name, capital, population, continent_id)
    VALUES ('Brazil', 'Brasilia', 208385000, 5),
           ('Egypt', 'Cairo', 96308900, 1),
           ('France', 'Paris', 67158000, 3),
           ('Germany', 'Berlin', 82349400, 3),
           ('Japan', 'Tokyo', 126672000, 2),
           ('USA', 'Washington D.C.', 325365189, 4);

SELECT * FROM continents;
SELECT * FROM countries;

\echo 'Multiple Tables, Exercise 3'
ALTER TABLE singers
    ADD CONSTRAINT unique_id UNIQUE (id);

CREATE TABLE albums (
    id serial PRIMARY KEY,
    album_name varchar(100),
    released date,
    genre varchar(100),
    label varchar(100),
    singer_id integer NOT NULL,
    FOREIGN KEY (singer_id)
        REFERENCES singers(id)
        ON DELETE CASCADE
);

INSERT INTO albums (album_name, released, genre, label, singer_id)
VALUES ('Born to Run', 'August 25, 1975', 'Rock and roll', 'Columbia', 1),
       ('Purple Rain', 'June 25, 1984', 'Pop, R&B, Rock', 'Warner Bros', 6),
       ('Born in the USA', 'June 4, 1984', 'Rock and roll, pop', 'Columbia', 1),
       ('Madonna', 'July 27, 1983', 'Dance-pop, post-disco', 'Warner Bros', 5),
       ('True Blue', 'June 30, 1986', 'Dance-pop, Pop', 'Warner Bros', 5),
       ('Elvis', 'October 19, 1956', 'Rock and roll, Rhythm and Blues', 'RCA Victor', 7),
       ('Sign o'' the Times', 'March 30, 1987', 'Pop, R&B, Rock, Funk', 'Paisley Park, Warner Bros', 6),
       ('G.I. Blues', 'October 1, 1960', 'Rock and roll, Pop', 'RCA Victor', 7);

\d singers
SELECT * FROM singers;
\d albums
SELECT * FROM albums;


\echo 'JOINs, Exercise 1'
SELECT c.name, con.continent_name
    FROM countries c
    INNER JOIN continents con
        ON c.continent_id = con.id;

\echo 'JOINs, Exercise 2'
SELECT c.name, c.capital
    FROM countries c
    JOIN continents con
        ON c.continent_id = con.id
    WHERE con.continent_name = 'Europe';

\echo 'JOINs, Exercise 3'
SELECT DISTINCT s.first_name
    FROM singers s
    JOIN albums a
        ON s.id = a.singer_id
    WHERE a.label LIKE '%Warner Bros%';

\echo 'JOINs, Exercise 4'
SELECT s.first_name, s.last_name, a.album_name, a.released
    FROM singers s
    JOIN albums a
        ON s.id = a.singer_id
    WHERE (a.released >= '1/1/1980' AND a.released < '1/1/1990')
      AND s.deceased = false
    ORDER BY age(s.date_of_birth);

\echo 'JOINs, Exercise 5'
SELECT s.first_name, s.last_name
    FROM singers s
    LEFT JOIN albums a
        ON s.id = a.singer_id
    WHERE a.id IS NULL;

\echo 'JOINs, Exercise 6'
SELECT s.first_name, s.last_name
    FROM singers s
    WHERE s.id NOT IN (
        SELECT singer_id FROM albums
    );
