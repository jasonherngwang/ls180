-- Setup
DROP DATABASE IF EXISTS films3;
CREATE DATABASE films3;

\c films3

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.films DROP CONSTRAINT title_unique;
DROP TABLE public.films;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: films; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE films (
    title character varying(255) NOT NULL,
    year integer NOT NULL,
    genre character varying(100) NOT NULL,
    director character varying(255) NOT NULL,
    duration integer NOT NULL,
    CONSTRAINT director_name CHECK (((length((director)::text) >= 1) AND ("position"((director)::text, ' '::text) > 0))),
    CONSTRAINT title_length CHECK ((length((title)::text) >= 1)),
    CONSTRAINT year_range CHECK (((year >= 1900) AND (year <= 2100)))
);


--
-- Data for Name: films; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO films VALUES ('Die Hard', 1988, 'action', 'John McTiernan', 132);
INSERT INTO films VALUES ('Casablanca', 1942, 'drama', 'Michael Curtiz', 102);
INSERT INTO films VALUES ('The Conversation', 1974, 'thriller', 'Francis Ford Coppola', 113);
INSERT INTO films VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90);
INSERT INTO films VALUES ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127);
INSERT INTO films VALUES ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);


--
-- PostgreSQL database dump complete
--



-- Using Keys
INSERT INTO films(title, year, genre, director, duration) VALUES ('Godzilla', 1998, 'scifi', 'Roland Emmerich', 139);
INSERT INTO films(title, year, genre, director, duration) VALUES ('Godzilla', 2014, 'scifi', 'Gareth Edwards', 123);

TABLE films;

-- Question 1
DROP SEQUENCE IF EXISTS counter;

CREATE SEQUENCE counter;

-- Question 2
SELECT nextval('counter');

-- Question 3
DROP SEQUENCE counter;

-- Question 4
DROP SEQUENCE IF EXISTS even_counter;

CREATE SEQUENCE even_counter
                INCREMENT BY 2
                START WITH 2;

SELECT nextval('even_counter'); -- 2
SELECT nextval('even_counter'); -- 4
SELECT nextval('even_counter'); -- 6

-- Question 5
CREATE TABLE regions (id serial PRIMARY KEY, name text, area integer);
\d regions
-- Sequence name is: regions_id_seq

-- Question 6
ALTER TABLE films
  ADD COLUMN id serial PRIMARY KEY;

\d films
TABLE films;

-- Question 7
-- UPDATE films
--    SET id = 2
--  WHERE title = 'Die Hard';

/*
ERROR:  duplicate key value violates unique constraint "films_pkey"
DETAIL:  Key (id)=(2) already exists.
*/

-- Question 8
ALTER TABLE films
  ADD COLUMN film_id serial PRIMARY KEY;
/*
ERROR:  multiple primary keys for table "films" are not allowed
*/

-- Question 9
ALTER TABLE films
 DROP CONSTRAINT films_pkey;

\d films
TABLE films;


-- Teardown
\c jason
DROP DATABASE films3;