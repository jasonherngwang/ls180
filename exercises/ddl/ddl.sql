-- To execute:
-- psql -d jason < ddl.sql

-- Setup
DROP DATABASE IF EXISTS extrasolar;
CREATE DATABASE extrasolar;

\c extrasolar


-- Exercise 1
CREATE TABLE stars (
    id            serial      PRIMARY KEY,
    name          varchar(25) NOT NULL
                              UNIQUE,
    distance      integer     NOT NULL
                              CHECK (distance > 0),
    spectral_type char(1),
    companions    integer     NOT NULL
                              CHECK (companions >= 0)
);

CREATE TABLE planets (
    id          serial PRIMARY KEY,
    designation char(1) UNIQUE,
    mass        integer
);


-- Exercise 2
ALTER TABLE planets
  ADD COLUMN star_id integer NOT NULL
                             REFERENCES stars (id)
                             ON DELETE CASCADE;


-- Exercise 3
-- No error if new length is >= all current strings.
ALTER TABLE stars
ALTER COLUMN name
 TYPE varchar(50);

-- Error if any current string is longer than the new length. Manually truncate first:
-- ALTER TABLE stars
-- ALTER COLUMN name
--  TYPE varchar(10)
-- USING substr(name, 1, 10);


-- Exercise 4
-- integer -> numeric causes no errors.
-- numeric -> integer rounds to the nearest integer.
ALTER TABLE stars
ALTER COLUMN distance
 TYPE numeric;


-- Exercise 5
ALTER TABLE stars
  ADD CHECK (spectral_type IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')),
ALTER COLUMN spectral_type
  SET NOT NULL;

-- Further Exploration with NULL and illegal values
ALTER TABLE stars
DROP CONSTRAINT stars_spectral_type_check,
ALTER COLUMN spectral_type DROP NOT NULL;

INSERT INTO stars (name, distance, companions)
           VALUES ('Epsilon Eridani', 10.5, 0);

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Lacaille 9352', 10.68, 'X', 0);

-- Cannot add a constraint when a current row is in violation.
-- Must first delete the row with spectral type 'X' or NULL
DELETE FROM stars
 WHERE spectral_type NOT IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')
    OR spectral_type IS NULL;

-- After all values are compliant with the constraints, they can be added.
ALTER TABLE stars
  ADD CHECK (spectral_type SIMILAR TO 'O|B|A|F|G|K|M'),
ALTER COLUMN spectral_type
  SET NOT NULL;

-- Violates check constraint; row will not be added.
INSERT INTO stars (name, distance, spectral_type, companions)
VALUES ('a', 1, 'Z', 0);


-- Exercise 6
CREATE TYPE spectral_type_enum AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
 DROP CONSTRAINT stars_spectral_type_check,
ALTER COLUMN spectral_type
      TYPE spectral_type_enum
      USING spectral_type::spectral_type_enum;


-- Exercise 7
ALTER TABLE planets
ALTER COLUMN mass
 TYPE numeric,
ALTER COLUMN mass
  SET NOT NULL,
  ADD CHECK (mass > 0.0),
ALTER COLUMN designation
      SET NOT NULL;


-- Exercise 8
ALTER TABLE planets
  ADD COLUMN semi_major_axis numeric NOT NULL;

-- Can't add NOT NULL if current rows have NULL.

ALTER TABLE planets
DROP COLUMN semi_major_axis;

DELETE FROM stars;
INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Centauri B', 4.37, 'K', 3);
INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Epsilon Eridani', 10.5, 'K', 0);

INSERT INTO planets (designation, mass, star_id)
           VALUES ('b', 0.0036, 4); -- check star_id; see note below
INSERT INTO planets (designation, mass, star_id)
           VALUES ('c', 0.1, 5); -- check star_id; see note below

ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL;  -- Throws error

-- Fill in missing data and add the column again.
ALTER TABLE planets
ADD COLUMN semi_major_axis numeric;

UPDATE planets
   SET semi_major_axis = 0.04
 WHERE star_id = 4;

UPDATE planets
   SET semi_major_axis = 40
 WHERE star_id = 5;

ALTER TABLE planets
ALTER COLUMN semi_major_axis
  SET NOT NULL;


-- Exercise 9
CREATE TABLE moons (
    id              serial  PRIMARY KEY,
    designation     integer NOT NULL
                            CHECK (designation > 0),
    semi_major_axis numeric CHECK (semi_major_axis > 0.0),
    mass            numeric CHECK (mass > 0.0),
    planet_id       integer NOT NULL
                            REFERENCES planets (id)
                            ON DELETE CASCADE
);


TABLE stars;
\d stars
TABLE planets;
\d planets
TABLE moons;
\d moons


-- Exercise 10
-- pg_dump --inserts extrasolar > extrasolar.dump.sql
-- dropdb extrasolar


-- Teardown
\c jason
DROP DATABASE extrasolar;