DROP TABLE IF EXISTS names;

CREATE TABLE names (
    id serial,
    name text
);

INSERT INTO names (name)
VALUES ('Abedi'), 
       ('Allyssa'), 
       ('amy'), 
       ('ben'), 
       ('Becky'), 
       ('Christophe'), 
       ('Camila'), 
       ('david'), 
       ('Elsa'), 
       ('frank'), 
       ('Felipe');

SELECT upper(left(name, 1)), count(id)
  FROM names GROUP BY upper(left(name, 1))
  ORDER BY upper(left(name, 1));

SELECT upper(left(name, 1)) AS first_letter, count(id)
  FROM names GROUP BY first_letter
  ORDER BY first_letter;

SELECT left(upper(name), 1) AS first_letter, count(name)
  FROM names GROUP BY first_letter
  ORDER BY first_letter;

SELECT upper(substring(name from 1 for 1)) AS first_letter, count(id)
  FROM names GROUP BY first_letter
  ORDER BY first_letter;