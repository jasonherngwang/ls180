DROP DATABASE IF EXISTS extrasolar;
CREATE DATABASE extrasolar;

\c extrasolar

-- Exercise 1
CREATE TABLE stars (
    PRIMARY KEY (id),
    id            serial,
    name          varchar(25) NOT NULL UNIQUE,
    distance      integer     NOT NULL
                              CHECK (distance > 0),
    spectral_type char(1),
    companions    integer     NOT NULL
                              CHECK (companions >= 0)
);

CREATE TABLE planets (
    PRIMARY KEY (id),
    id          serial,
    designation char(1) UNIQUE,
    mass        integer
);

-- Exercise 2
ALTER TABLE planets
  ADD COLUMN star_id integer NOT NULL
                              REFERENCES stars (id);

-- Exercise 3
-- Changing the string length will truncate longer strings.
ALTER TABLE stars
ALTER COLUMN name
 TYPE varchar(50);

-- Exercise 4
-- integer -> numeric causes no errors, but numeric -> integer will round to the nearest integer.
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

-- INSERT INTO stars (name, distance, spectral_type, companions)
--            VALUES ('Superstar 999999', 16.9, 'F', 0);

DELETE FROM stars
 WHERE spectral_type NOT IN ('O', 'B', 'A', 'F', 'G', 'K', 'M')
    OR spectral_type IS NULL;

ALTER TABLE stars
ADD CHECK (spectral_type SIMILAR TO 'O|B|A|F|G|K|M'),
ALTER COLUMN spectral_type SET NOT NULL;

-- Violates check constraint
-- INSERT INTO stars (name, distance, spectral_type, companions)
-- VALUES ('a', 1, 'Z', 0);


-- Exercise 6
ALTER TABLE stars
 DROP CONSTRAINT stars_spectral_type_check;

CREATE TYPE spectral_type_enum AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
ALTER COLUMN spectral_type
      TYPE spectral_type_enum
      USING spectral_type::spectral_type_enum;

-- Exercise 7
ALTER TABLE planets
ALTER COLUMN mass
      TYPE numeric,
ALTER COLUMN mass
      SET NOT NULL,
  ADD CHECK (mass > 0.0);

ALTER TABLE planets
ALTER COLUMN designation
      SET NOT NULL;

-- Exercise 8
ALTER TABLE planets
  ADD COLUMN semi_major_axis numeric NOT NULL;

-- ALTER TABLE planets
-- DROP COLUMN semi_major_axis;

-- DELETE FROM stars;
-- INSERT INTO stars (name, distance, spectral_type, companions)
--            VALUES ('Alpha Centauri B', 4.37, 'K', 3);
-- INSERT INTO stars (name, distance, spectral_type, companions)
--            VALUES ('Epsilon Eridani', 10.5, 'K', 0);

-- INSERT INTO planets (designation, mass, star_id)
--            VALUES ('b', 0.0036, 3); -- check star_id; see note below
-- INSERT INTO planets (designation, mass, star_id)
--            VALUES ('c', 0.1, 4); -- check star_id; see note below

-- ALTER TABLE planets
-- ADD COLUMN semi_major_axis numeric;

-- Exercise 9
CREATE TABLE moons (
    id              serial  PRIMARY KEY,
    designation     integer CHECK (designation > 0)         NOT NULL,
    semi_major_axis numeric CHECK (semi_major_axis > 0.0),
    mass            numeric CHECK (mass > 0.0),
    planet_id       integer REFERENCES planets (id)         NOT NULL
);


-- Exercise 10
-- pg_dump --inserts extrasolar > extrasolar.dump.sql
-- dropdb extrasolar


TABLE stars;
\d stars
TABLE planets;
\d planets
TABLE moons;
\d moons