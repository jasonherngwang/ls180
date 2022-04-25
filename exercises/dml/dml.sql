DROP DATABASE IF EXISTS workshop;
CREATE DATABASE workshop;

\c workshop

-- Exercise 1
CREATE TABLE devices (
    id         serial    PRIMARY KEY,
    name       text      NOT NULL,
    created_at timestamp DEFAULT now()
);

CREATE TABLE parts (
    id          serial  PRIMARY KEY,
    part_number integer UNIQUE NOT NULL,
    device_id   integer REFERENCES devices (id) ON DELETE CASCADE
);

-- Exercise 2
INSERT INTO devices (name)
VALUES ('Accelerometer'),
       ('Gyroscope');

INSERT INTO parts (part_number, device_id)
VALUES ( 1, 1),
       ( 2, 1),
       ( 3, 1),
       (44, 2),
       (45, 2),
       (46, 2),
       (47, 2),
       (48, 2),
       (79, NULL),
       (70, NULL),
       (71, NULL);

-- Exercise 3
SELECT devices.name, parts.part_number
  FROM devices
  JOIN parts
    ON devices.id = parts.device_id
;

-- Exercise 4
SELECT *
  FROM parts
 WHERE substring(part_number::text, 1, 1) = '3';

-- Exercise 5
SELECT devices.name,
       count(parts.device_id)
  FROM devices
  LEFT JOIN parts
    ON devices.id = parts.device_id
 GROUP BY devices.name;

-- Full join
-- SELECT CASE WHEN devices.name IS NULL
--             THEN '(Not assigned)'
--             ELSE devices.name
--             END,
--        count(parts.id)
--   FROM devices
--   FULL JOIN parts
--     ON devices.id = parts.device_id
--  GROUP BY devices.name;

-- Exercise 6
SELECT devices.name,
       count(parts.device_id)
  FROM devices
  LEFT JOIN parts
    ON devices.id = parts.device_id
 GROUP BY devices.name
 ORDER BY count(devices.name) DESC;

-- Exercise 7
SELECT part_number, device_id
  FROM parts
 WHERE device_id IS NOT NULL;

SELECT part_number, device_id
  FROM parts
 WHERE device_id IS NULL;

-- Exercise 8
INSERT INTO devices (name)
VALUES ('Magnetometer');

INSERT INTO parts (part_number, device_id)
VALUES (42, 3);

SELECT name AS oldest_device
  FROM devices
 ORDER BY created_at
 LIMIT 1;

SELECT name AS oldest_device,
       created_at
  FROM devices
 WHERE created_at = (
           SELECT MIN(created_at) FROM devices
       );

-- Exercise 9
-- UPDATE parts
--    SET device_id = 1
--  WHERE part_number = 47 OR
--        part_number = 48;

-- Using subquery
UPDATE parts
   SET device_id = 1
 WHERE part_number IN (
           SELECT part_number
             FROM parts
            WHERE device_id = 2
            ORDER BY part_number DESC
            LIMIT 2
       );

-- Further Exploration
-- UPDATE parts
--    SET device_id = 2
--  WHERE part_number = (
--            SELECT MIN(part_number)
--              FROM parts
--        );

UPDATE parts
   SET device_id = 2
 WHERE part_number IN (
           SELECT part_number
             FROM parts
            ORDER BY part_number
            LIMIT 1
       );

TABLE parts;

-- Exercise 10
-- To make this easier, add ON DELETE CASCADE when defining the Foreign Key.
-- DELETE FROM parts
--  WHERE device_id = 1;

ALTER TABLE parts
 DROP CONSTRAINT parts_device_id_fkey,
  ADD FOREIGN KEY (device_id) REFERENCES devices (id) ON DELETE CASCADE;

DELETE FROM devices
 WHERE name = 'Accelerometer';


\d devices
SELECT * FROM devices;
\d parts
SELECT * FROM parts;