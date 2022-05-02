-- Setup
DROP DATABASE IF EXISTS residents;
CREATE DATABASE residents;

\c residents
\i ./residents_with_data.sql


-- Question 3
SELECT *
  FROM people
 LIMIT 2;

\d people

SELECT state,
       count(id) AS population
  FROM people
 GROUP BY state
 ORDER BY population DESC
 LIMIT 10;


-- Question 4
SELECT split_part(email,'@', 2) AS domain,
       count(id)
  FROM people
 GROUP BY domain
 ORDER BY count DESC;


-- Question 5
DELETE FROM people
 WHERE id = 3399;


-- Question 6
DELETE FROM people
 WHERE state = 'CA';


-- Question 7
UPDATE people
   SET given_name = upper(given_name)
 WHERE email LIKE '%teleworm.us%';

SELECT given_name,
       email
  FROM people
 WHERE email LIKE '%teleworm.us%';

DELETE FROM people;


-- Teardown
\c jason
DROP DATABASE residents;