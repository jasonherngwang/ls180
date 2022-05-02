-- Setup
DROP DATABASE IF EXISTS orders_products;
CREATE DATABASE orders_products;

\c orders_products


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

ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_product_id_fkey;
ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
ALTER TABLE public.products ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.products_id_seq;
DROP TABLE public.products;
DROP SEQUENCE public.orders_id_seq;
DROP TABLE public.orders;
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
-- Name: orders; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE orders (
    id integer NOT NULL,
    product_id integer,
    quantity integer NOT NULL
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -; Tablespace:
--

CREATE TABLE products (
    id integer NOT NULL,
    name text NOT NULL
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('orders_id_seq', 1, false);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('products_id_seq', 1, false);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace:
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);

--
-- PostgreSQL database dump complete
--


\d orders
\d products


-- Question 2
-- ALTER TABLE orders
--   ADD FOREIGN KEY (product_id)
--       REFERENCES products (id)
-- ;
ALTER TABLE orders
  ADD CONSTRAINT orders_product_id_fkey
      FOREIGN KEY (product_id)
      REFERENCES products (id);

\d orders


-- Question 3
INSERT INTO products (name)
VALUES ('small bolt'),
       ('large bolt');

INSERT INTO orders (product_id, quantity)
VALUES (1, 10),
       (1, 25),
       (2, 15);

TABLE products;
TABLE orders;


-- Question 4
SELECT orders.quantity, products.name
  FROM orders
  JOIN products
    ON products.id = orders.product_id;


-- Question 5
-- Yes. Unlike PKs, FKs do not have a NOT NULL constraint.
INSERT INTO orders (quantity)
VALUES (10);

TABLE orders;


-- Question 6 and 7
-- Must remove the order with a NULL FK, before we add the constraint.
DELETE FROM orders
 WHERE product_id IS NULL;

ALTER TABLE orders
ALTER COLUMN product_id
  SET NOT NULL;

\d orders


-- Question 8
DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
    id         serial   PRIMARY KEY,
    product_id integer  REFERENCES products(id),
    review     text NOT NULL
);

INSERT INTO reviews (product_id, review)
VALUES (1, 'a little small'),
       (1, 'very round!'),
       (2, 'could have been smaller');

TABLE reviews;


-- Question 9
-- FKs allow NULL unless a NOT NULL constraint is added.


-- Teardown
\c jason
DROP DATABASE orders_products;