\echo 'Create & View Tables'
CREATE TABLE users (
    id serial UNIQUE NOT NULL,
    username char(25),
    enabled boolean DEFAULT TRUE
);

\d users


\echo 'Alter Tables'
ALTER TABLE users
    RENAME TO all_users;

\dt

ALTER TABLE all_users
    RENAME COLUMN username TO full_name;

\d all_users

ALTER TABLE all_users
    ALTER COLUMN full_name TYPE varchar(25);

\d all_users

ALTER TABLE all_users
    ALTER COLUMN full_name
        SET NOT NULL;

\d all_users

ALTER TABLE all_users
    ALTER COLUMN id
        DROP DEFAULT;

\d all_users

ALTER TABLE all_users
    ADD COLUMN last_login timestamp
               NOT NULL
               DEFAULT NOW();
\d all_users

ALTER TABLE all_users
    DROP COLUMN enabled;

\d all_users

DROP TABLE all_users;

-- \d all_users


\echo 'Add Data'
CREATE TABLE users (
    id serial UNIQUE NOT NULL,
    full_name character varying(25) NOT NULL,
    enabled boolean DEFAULT true,
    last_login timestamp without time zone DEFAULT now()
);

SELECT * FROM users;

INSERT INTO users (full_name, enabled)
    VALUES ('John Smith', false);

SELECT * FROM users;

INSERT INTO users (full_name)
    VALUES ('Jane Smith'),
           ('Harry Potter');

SELECT * FROM users;

ALTER TABLE users ADD CHECK (full_name <> '');


\echo 'SELECT Statement and its Clauses'
-- Keyword: SELECT, FROM, etc.
-- Identifier: Everything that is not a keyword
SELECT enabled, full_name FROM users
WHERE id < 2;

-- false comes before true
SELECT full_name, enabled FROM users
ORDER BY enabled;

SELECT full_name, enabled FROM users
ORDER BY enabled DESC;

-- Multi-level sorting: Sort `id` within groups already sorted by `enabled`.
SELECT full_name, enabled FROM users
ORDER BY enabled DESC, id DESC;

-- Comparison Operators
SELECT full_name, enabled, last_login
    FROM users
    WHERE id >= 2;

SELECT * FROM users
WHERE full_name IS NOT NULL;

-- Logical Operators
SELECT * FROM users
    WHERE full_name = 'Harry Potter'
       OR enabled = 'false';

SELECT * FROM users
    WHERE full_name = 'Harry Potter'
      AND enabled = 'false';

-- String Matching Operators LIKE (case-sensitive) and ILIKE (non case-sensitive)
-- Wildcard % (multiple chars), _ (single char)
SELECT * FROM users
WHERE full_name LIKE '%Smith';

SELECT * FROM users
WHERE full_name LIKE '_ohn Smith';


\echo 'LIMIT and OFFSET Clauses'
SELECT * FROM users LIMIT 1;

-- Start from 2nd row
SELECT * FROM users LIMIT 1 OFFSET 1;


\echo 'DISTINCT'
INSERT INTO users (full_name)
    VALUES ('Harry Potter'),
           ('Harry Potter');

SELECT * FROM users;

SELECT DISTINCT full_name FROM users;

SELECT count(full_name) FROM users;
SELECT count(DISTINCT full_name) FROM users;


\echo 'Functions'
SELECT length(full_name) FROM users;

SELECT full_name FROM users
WHERE length(full_name) > 10;

SELECT trim(leading ' ' from full_name) FROM users;

SELECT full_name, date_part('year', last_login)
FROM users;

SELECT full_name, age(last_login)
FROM users;

SELECT sum(id) from users;

SELECT avg(id) from users;

SELECT min(last_login) from users;

SELECT max(last_login) from users;


\echo 'GROUP BY'
-- SELECT columns must also be in the GROUP BY clause.
SELECT enabled, count(id)
FROM users
GROUP BY enabled;

-- Unique, comma-separated list of names
SELECT enabled, string_agg(DISTINCT full_name, ', ')
FROM users
GROUP BY enabled;

-- Combined login age of users in the group
SELECT enabled, sum(age(last_login))
FROM users
GROUP BY enabled;


\echo 'UPDATE and DELETE'
-- Set every row
UPDATE users SET enabled = false;
SELECT * FROM users;

UPDATE users SET enabled = true
             WHERE full_name = 'Harry Potter'
                OR full_name = 'Jane Smith';
SELECT * FROM users;

UPDATE users
SET full_name = 'Alice Walker'
WHERE id=5;

SELECT * FROM users;

DELETE FROM users
WHERE full_name='Harry Potter'
AND id > 3;

SELECT * FROM users;


\echo 'one-to-one relationship'
/*
one-to-one: User has one address
*/

CREATE TABLE addresses (
  user_id int, -- Both a primary and foreign key
  street varchar(30) NOT NULL,
  city varchar(30) NOT NULL,
  state varchar(30) NOT NULL,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id)
      REFERENCES users (id)
      ON DELETE CASCADE
);

INSERT INTO addresses
         (user_id, street, city, state)
  VALUES (1, '1 Market Street', 'San Francisco', 'CA'),
         (2, '2 Elm Street', 'San Francisco', 'CA'),
         (3, '3 Main Street', 'Boston', 'MA');

-- \d users
-- \d addresses

\echo 'one-to-many relationship'
CREATE TABLE books (
  id serial,
  title varchar(100) NOT NULL,
  author varchar(100) NOT NULL,
  published_date timestamp NOT NULL,
  isbn char(12),
  PRIMARY KEY (id),
  UNIQUE (isbn)
);

/*
 one-to-many: Book has many reviews
*/

CREATE TABLE reviews (
  id serial,
  book_id integer NOT NULL,
  reviewer_name varchar(255),
  content varchar(255),
  rating integer,
  published_date timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (book_id)
      REFERENCES books(id)
      ON DELETE CASCADE
);

INSERT INTO books
  (id, title, author, published_date, isbn)
  VALUES
      (1, 'My First SQL Book', 'Mary Parker',
          '2012-02-22 12:08:17.320053-03',
          '981483029127'),
      (2, 'My Second SQL Book', 'John Mayer',
          '1972-07-03 09:22:45.050088-07',
          '857300923713'),
      (3, 'My First SQL Book', 'Cary Flint',
          '2015-10-18 14:05:44.547516-07',
          '523120967812');


INSERT INTO reviews
  (id, book_id, reviewer_name, content, rating,
       published_date)
  VALUES
      (1, 1, 'John Smith', 'My first review', 4,
          '2017-12-10 05:50:11.127281-02'),
      (2, 2, 'John Smith', 'My second review', 5,
          '2017-10-13 15:05:12.673382-05'),
      (3, 2, 'Alice Walker', 'Another review', 1,
          '2017-10-22 23:47:10.407569-07');

SELECT * FROM books;
SELECT * FROM reviews;


\echo 'many-to-many relationship'
CREATE TABLE checkouts (
  id serial,
  user_id int NOT NULL,
  book_id int NOT NULL,
  checkout_date timestamp,
  return_date timestamp,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
                        ON DELETE CASCADE,
  FOREIGN KEY (book_id) REFERENCES books(id)
                        ON DELETE CASCADE
);

INSERT INTO checkouts
  (id, user_id, book_id, checkout_date, return_date)
  VALUES
    (1, 1, 1, '2017-10-15 14:43:18.095143-07',
              NULL),
    (2, 1, 2, '2017-10-05 16:22:44.593188-07',
              '2017-10-13 13:0:12.673382-05'),
    (3, 2, 2, '2017-10-15 11:11:24.994973-07',
              '2017-10-22 17:47:10.407569-07'),
    (4, 5, 3, '2017-10-15 09:27:07.215217-07',
              NULL);

SELECT * FROM checkouts;


\echo 'JOIN'
SELECT * FROM users;
SELECT * FROM addresses;

SELECT users.*, addresses.*
    FROM users
    INNER JOIN addresses
        ON users.id = addresses.user_id;

SELECT users.*, addresses.*
    FROM users
    LEFT JOIN addresses
        ON users.id = addresses.user_id;

SELECT * FROM books;
SELECT * FROM reviews;

SELECT reviews.book_id, reviews.content, reviews.rating, 
       reviews.published_date, books.id, books.title, books.author
    FROM reviews
    RIGHT JOIN books
          ON reviews.book_id = books.id;

SELECT * FROM users CROSS JOIN addresses;

-- Multiple JOIN
SELECT * FROM users;
SELECT * FROM checkouts;
SELECT * FROM books;

SELECT users.full_name, books.title, checkouts.checkout_date
    FROM users
    INNER JOIN checkouts
        ON users.id = checkouts.user_id
    INNER JOIN books
        ON books.id = checkouts.book_id;

-- Aliasing
SELECT u.full_name, b.title, c.checkout_date
    FROM users AS u
    INNER JOIN checkouts AS c
        ON u.id = c.user_id
    INNER JOIN books AS b
        ON b.id = c.book_id;

-- Without AS
SELECT u.full_name, b.title, c.checkout_date
    FROM users u
    INNER JOIN checkouts c
        ON u.id = c.user_id
    INNER JOIN books b
        ON b.id = c.book_id;

-- Subquery with NOT IN
SELECT u.full_name FROM users u
    WHERE u.id NOT IN (
        SELECT c.user_id FROM checkouts c
    )