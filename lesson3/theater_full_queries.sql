/*
Schema
CREATE TABLE customers (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    phone character varying(10) NOT NULL,
    email text NOT NULL
);
CREATE TABLE events (
    id integer NOT NULL,
    name text NOT NULL,
    starts_at timestamp without time zone NOT NULL,
    base_price numeric(4,2) NOT NULL
);
CREATE TABLE seats (
    id integer NOT NULL,
    section_id integer NOT NULL,
    "row" character varying(1) NOT NULL,
    number integer NOT NULL
);
CREATE TABLE sections (
    id integer NOT NULL,
    code text NOT NULL,
    name text NOT NULL,
    price_multiplier numeric(4,3) NOT NULL
);
CREATE TABLE tickets (
    id integer NOT NULL,
    event_id integer NOT NULL,
    seat_id integer NOT NULL,
    customer_id integer NOT NULL
);
*/

-- Question 2
SELECT count(id)
  FROM tickets;

-- Question 3
-- SELECT count(DISTINCT c.id)
--   FROM customers AS c
--   JOIN tickets AS t
--     ON c.id = t.customer_id;
SELECT count(DISTINCT customer_id)
  FROM tickets;

-- Question 4
SELECT round( count(DISTINCT t.customer_id) * 100.0
            / count(DISTINCT c.id), 
            2)
       AS percent
  FROM customers AS c
  LEFT JOIN tickets AS t
    ON c.id = t.customer_id;

-- Question 5
SELECT e.name,
       count(t.id) AS popularity
  FROM events AS e
  LEFT JOIN tickets AS t
    ON e.id = t.event_id
 GROUP BY e.name
 ORDER BY popularity DESC;

-- Question 6
-- SELECT c.id,
--        c.email,
--        count(DISTINCT e.id),
--        string_agg(DISTINCT e.name, ', ')
--   FROM customers AS c
--   JOIN tickets AS t
--     ON c.id = t.customer_id
--   JOIN events AS e
--     ON e.id = t.event_id
--  GROUP BY c.id
-- HAVING count(DISTINCT e.id) = 3
-- ;

SELECT c.id,
       c.email,
       count(DISTINCT t.event_id)
  FROM customers AS c
  JOIN tickets AS t
    ON c.id = t.customer_id
 GROUP BY c.id
HAVING count(DISTINCT t.event_id) = 3
;

-- Question 7
SELECT e.name AS event,
       e.starts_at,
       sec.name AS section,
       s.row,
       s.number AS seat
  FROM customers as c
  JOIN tickets as t
    ON c.id = t.customer_id
  JOIN seats AS s
    ON s.id = t.seat_id
  JOIN sections AS sec
    ON sec.id = s.section_id
  JOIN events AS e
    ON e.id = t.event_id
 WHERE c.email = 'gennaro.rath@mcdermott.co'
;