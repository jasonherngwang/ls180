-- Setup
DROP DATABASE IF EXISTS films1;
CREATE DATABASE films1;

\c films1


DROP TABLE IF EXISTS public.films;

CREATE TABLE films (title varchar(255), "year" integer, genre varchar(100));

INSERT INTO films(title, "year", genre) VALUES ('Die Hard', 1988, 'action');  
INSERT INTO films(title, "year", genre) VALUES ('Casablanca', 1942, 'drama');  
INSERT INTO films(title, "year", genre) VALUES ('The Conversation', 1974, 'thriller');  

/*
Question 1
The file drops any existing table named `films` and creates a new table named `films` with 3 columns.
The file inserts three rows of movie data.

Output:
DROP TABLE      - Dropped table `films`.
CREATE TABLE    - Created new table `films`.
INSERT 0 1      - Insert 1 new row.
INSERT 0 1
INSERT 0 1
*/


-- Question 2
TABLE films;


-- Question 3
SELECT *
  FROM films
 WHERE length(title) < 12;


 -- Question 4
 ALTER TABLE films
  ADD COLUMN director text,
  ADD COLUMN duration integer;

\d films

SELECT * FROM films;


-- Question 5
UPDATE films
   SET director = 'John McTiernan',
       duration = 132
 WHERE title = 'Die Hard';
 
UPDATE films
   SET director = 'Michael Curtiz',
       duration = 102
 WHERE title = 'Casablanca';

UPDATE films
   SET director = 'Francis Ford Coppola',
       duration = 113
 WHERE title = 'The Conversation';

SELECT * FROM films;


-- Question 6
INSERT INTO films(title, "year", genre, director, duration)
VALUES ('1984',                      1956, 'scifi',     'Michael Anderson', 90),
       ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson',  127),
       ('The Birdcage',              1996, 'compedy',   'Mike Nichols',     118);

SELECT * FROM films;


-- Question 7
SELECT title, (extract('year' from now()) - "year") as age
  FROM films
 ORDER BY age;


-- Question 8
SELECT title, duration
  FROM films
 WHERE duration > 120
 ORDER BY duration DESC;


-- Question 9
SELECT title
  FROM films 
 ORDER BY duration DESC
 LIMIT 1;


-- Teardown
\c jason
DROP DATABASE films1;