-- Setup
DROP DATABASE IF EXISTS films2;
CREATE DATABASE films2;

\c films2

DROP TABLE IF EXISTS public.films;
CREATE TABLE films (title varchar(255), year integer, genre varchar(100), director varchar(255), duration integer);

INSERT INTO films(title, year, genre, director, duration) VALUES ('Die Hard', 1988, 'action', 'John McTiernan', 132);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('Casablanca', 1942, 'drama', 'Michael Curtiz', 102);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('The Conversation', 1974, 'thriller', 'Francis Ford Coppola', 113);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127);  
INSERT INTO films(title, year, genre, director, duration) VALUES ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);


-- Question 2
ALTER TABLE films
ALTER COLUMN title
  SET NOT NULL;

ALTER TABLE films
ALTER COLUMN year
  SET NOT NULL;

ALTER TABLE films
ALTER COLUMN genre
  SET NOT NULL;

ALTER TABLE films
ALTER COLUMN director
  SET NOT NULL;

ALTER TABLE films
ALTER COLUMN duration
  SET NOT NULL;

\d films
TABLE films;


-- Question 3
-- Column Nullable shows "not null".


-- Question 4
-- ALTER TABLE films
--   ADD UNIQUE (title);

ALTER TABLE films
  ADD CONSTRAINT unique_title UNIQUE (title);

\d films


-- Question 5
/*
Indexes:
    "unique_title" UNIQUE CONSTRAINT, btree (title)
*/


-- Question 6
ALTER TABLE films
 DROP CONSTRAINT unique_title;

\d films


-- Question 7
ALTER TABLE films
ALTER column title
  SET NOT NULL;

ALTER TABLE films
  ADD CONSTRAINT check_title_length CHECK (length(title) >= 1);

\d films


-- Question 8
-- INSERT INTO films
-- VALUES ('', 2007, 'drama', 'Brad Bird', 111);
/*
ERROR:  new row for relation "films" violates check constraint "check_title_length"
DETAIL:  Failing row contains (, 2007, drama, Brad Bird, 111).
*/


-- Question 9
/*
Check constraints:
    "check_title_length" CHECK (length(title::text) >= 1)
*/


-- Question 10
ALTER TABLE films
 DROP CONSTRAINT check_title_length;

\d films


-- Question 11
ALTER TABLE films
  ADD CONSTRAINT year_range CHECK (year BETWEEN 1900 AND 2100);

\d films


-- Question 12
/*
Check constraints:
    "year_range" CHECK (year >= 1900 AND year <= 2100)
*/


-- Question 13
ALTER TABLE films
  ADD CONSTRAINT director_length
CHECK (length(director) >= 3 AND position(' ' in director) > 0);
--   ADD CONSTRAINT director_space CHECK (director LIKE '% %');

\d films


-- Question 14
/*
Check constraints:
    "director_length" CHECK (length(director::text) >= 3 AND POSITION((' '::text) IN (director)) > 0)
*/


-- Question 15
-- UPDATE films
--    SET director = 'Johnny'
--  WHERE title = 'Die Hard';
/*
ERROR:  new row for relation "films" violates check constraint "director_length"
DETAIL:  Failing row contains (Die Hard, 1988, action, Johnny, 132).
*/


-- Question 16
-- Constraints: NOT NULL, DEFAULT, UNIQUE, various CHECKs
-- Data type, length limitation


-- Question 17
DROP TABLE IF EXISTS public.my_table;

CREATE TABLE my_table (
    attribute  text          DEFAULT NULL NOT NULL,
    attribute2 decimal(5, 2) DEFAULT 1
                             CHECK (attribute2 > 5)
);

INSERT INTO my_table
VALUES ('abc', 4);


-- Question 18
TABLE my_table;
\d my_table


-- Teardown
\c jason
DROP DATABASE films2;