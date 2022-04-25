--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Ubuntu 13.2-1.pgdg20.04+1)
-- Dumped by pg_dump version 13.2 (Ubuntu 13.2-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: authors; Type: TABLE; Schema: public; Owner: temp
--

CREATE TABLE public.authors (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.authors OWNER TO temp;

--
-- Name: authors_books; Type: TABLE; Schema: public; Owner: temp
--

CREATE TABLE public.authors_books (
    id integer NOT NULL,
    book_id integer NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE public.authors_books OWNER TO temp;

--
-- Name: authors_books_id_seq; Type: SEQUENCE; Schema: public; Owner: temp
--

CREATE SEQUENCE public.authors_books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authors_books_id_seq OWNER TO temp;

--
-- Name: authors_books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: temp
--

ALTER SEQUENCE public.authors_books_id_seq OWNED BY public.authors_books.id;


--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: temp
--

CREATE SEQUENCE public.authors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.authors_id_seq OWNER TO temp;

--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: temp
--

ALTER SEQUENCE public.authors_id_seq OWNED BY public.authors.id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: temp
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title text NOT NULL,
    date_published date DEFAULT '1970-01-01'::date,
    publisher_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.books OWNER TO temp;

--
-- Name: books_genres; Type: TABLE; Schema: public; Owner: temp
--

CREATE TABLE public.books_genres (
    id integer NOT NULL,
    book_id integer NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE public.books_genres OWNER TO temp;

--
-- Name: books_genres_id_seq; Type: SEQUENCE; Schema: public; Owner: temp
--

CREATE SEQUENCE public.books_genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_genres_id_seq OWNER TO temp;

--
-- Name: books_genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: temp
--

ALTER SEQUENCE public.books_genres_id_seq OWNED BY public.books_genres.id;


--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: temp
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_id_seq OWNER TO temp;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: temp
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: checkouts; Type: TABLE; Schema: public; Owner: temp
--

CREATE TABLE public.checkouts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    book_id integer NOT NULL,
    due date DEFAULT (CURRENT_DATE + 14) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.checkouts OWNER TO temp;

--
-- Name: checkouts_id_seq; Type: SEQUENCE; Schema: public; Owner: temp
--

CREATE SEQUENCE public.checkouts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.checkouts_id_seq OWNER TO temp;

--
-- Name: checkouts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: temp
--

ALTER SEQUENCE public.checkouts_id_seq OWNED BY public.checkouts.id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: temp
--

CREATE TABLE public.genres (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.genres OWNER TO temp;

--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: temp
--

CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.genres_id_seq OWNER TO temp;

--
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: temp
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- Name: publishers; Type: TABLE; Schema: public; Owner: temp
--

CREATE TABLE public.publishers (
    id integer NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    phone text NOT NULL,
    email text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT publishers_phone_check CHECK ((phone ~ '\d{10}'::text))
);


ALTER TABLE public.publishers OWNER TO temp;

--
-- Name: publishers_id_seq; Type: SEQUENCE; Schema: public; Owner: temp
--

CREATE SEQUENCE public.publishers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publishers_id_seq OWNER TO temp;

--
-- Name: publishers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: temp
--

ALTER SEQUENCE public.publishers_id_seq OWNED BY public.publishers.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: temp
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text,
    email text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    admin boolean
);


ALTER TABLE public.users OWNER TO temp;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: temp
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO temp;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: temp
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);


--
-- Name: authors_books id; Type: DEFAULT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.authors_books ALTER COLUMN id SET DEFAULT nextval('public.authors_books_id_seq'::regclass);


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: books_genres id; Type: DEFAULT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.books_genres ALTER COLUMN id SET DEFAULT nextval('public.books_genres_id_seq'::regclass);


--
-- Name: checkouts id; Type: DEFAULT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.checkouts ALTER COLUMN id SET DEFAULT nextval('public.checkouts_id_seq'::regclass);


--
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- Name: publishers id; Type: DEFAULT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.publishers ALTER COLUMN id SET DEFAULT nextval('public.publishers_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: temp
--

INSERT INTO public.authors VALUES (1, 'Freida', 'Quigley', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (2, 'Clemmie', 'Abshire', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (3, 'Ottilie', 'Kertzmann', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (4, 'Bella', 'Emmerich', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (5, 'Deontae', 'Hudson', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (6, 'Mercedes', 'Murphy', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (7, 'Vanessa', 'Volkman', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (8, 'Vella', 'Oberbrunner', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (9, 'Milton', 'Quitzon', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (10, 'Ole', 'Leannon', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (11, 'Lauren', 'Mayer', '2021-02-11 10:54:19.293562');
INSERT INTO public.authors VALUES (12, 'Bernita', 'Bahringer', '2021-02-11 10:54:19.293562');


--
-- Data for Name: authors_books; Type: TABLE DATA; Schema: public; Owner: temp
--

INSERT INTO public.authors_books VALUES (1, 1, 11);
INSERT INTO public.authors_books VALUES (2, 2, 9);
INSERT INTO public.authors_books VALUES (3, 2, 6);
INSERT INTO public.authors_books VALUES (4, 3, 9);
INSERT INTO public.authors_books VALUES (5, 4, 2);
INSERT INTO public.authors_books VALUES (6, 5, 4);
INSERT INTO public.authors_books VALUES (7, 6, 5);
INSERT INTO public.authors_books VALUES (8, 7, 12);
INSERT INTO public.authors_books VALUES (9, 8, 3);
INSERT INTO public.authors_books VALUES (10, 9, 1);
INSERT INTO public.authors_books VALUES (11, 10, 10);
INSERT INTO public.authors_books VALUES (12, 11, 12);
INSERT INTO public.authors_books VALUES (13, 12, 10);
INSERT INTO public.authors_books VALUES (14, 13, 12);
INSERT INTO public.authors_books VALUES (15, 14, 12);
INSERT INTO public.authors_books VALUES (16, 15, 11);
INSERT INTO public.authors_books VALUES (17, 16, 3);
INSERT INTO public.authors_books VALUES (18, 17, 1);
INSERT INTO public.authors_books VALUES (19, 17, 8);
INSERT INTO public.authors_books VALUES (20, 18, 9);
INSERT INTO public.authors_books VALUES (21, 19, 5);
INSERT INTO public.authors_books VALUES (22, 20, 4);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: temp
--

INSERT INTO public.books VALUES (1, 'Femme Nikita, La (Nikita)', '1975-01-24', 9, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (2, 'Kummeli Stories', '2002-12-25', 8, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (3, 'Chariots of Fire', '1970-11-06', 5, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (4, 'The Sinners of Hell', '1998-03-12', 5, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (5, 'Battery, The', '2004-03-14', 2, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (6, 'Otakus in Love', '1996-12-04', 10, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (7, 'Soap and Water', '1982-11-20', 3, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (8, 'Wrong Move, The (Falsche Bewegung)', '2006-07-01', 7, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (9, 'Off and Running', '2004-09-07', NULL, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (10, 'Not Reconciled', '1973-04-04', 4, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (11, 'Calculator', '1983-06-11', 2, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (12, 'Metro', '1987-06-20', 6, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (13, 'Yellow Earth (Huang tu di)', '2016-09-09', 7, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (14, 'Magic Camp', '1987-01-10', 11, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (15, 'Star Trek III: The Search for Spock', '1981-10-25', 9, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (16, 'Figures: The Movie', '2013-06-13', NULL, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (17, 'Castle of Cloads, The (Pilvilinna)', '1983-08-28', 7, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (18, 'Aliens in Uniform', '1974-08-23', 3, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (19, 'Man Entertained', '1983-04-24', 11, '2021-02-11 10:54:41.366764');
INSERT INTO public.books VALUES (20, 'Taste of Tea, The (Cha no aji)', '1997-12-04', 1, '2021-02-11 10:54:41.366764');


--
-- Data for Name: books_genres; Type: TABLE DATA; Schema: public; Owner: temp
--

INSERT INTO public.books_genres VALUES (1, 5, 9);
INSERT INTO public.books_genres VALUES (2, 6, 6);
INSERT INTO public.books_genres VALUES (3, 15, 9);
INSERT INTO public.books_genres VALUES (4, 2, 8);
INSERT INTO public.books_genres VALUES (5, 2, 7);
INSERT INTO public.books_genres VALUES (6, 8, 5);
INSERT INTO public.books_genres VALUES (7, 14, 6);
INSERT INTO public.books_genres VALUES (8, 3, 8);
INSERT INTO public.books_genres VALUES (9, 13, 4);
INSERT INTO public.books_genres VALUES (10, 14, 9);
INSERT INTO public.books_genres VALUES (11, 4, 5);
INSERT INTO public.books_genres VALUES (12, 2, 6);
INSERT INTO public.books_genres VALUES (13, 2, 9);
INSERT INTO public.books_genres VALUES (14, 8, 9);
INSERT INTO public.books_genres VALUES (15, 17, 6);
INSERT INTO public.books_genres VALUES (16, 9, 7);
INSERT INTO public.books_genres VALUES (17, 15, 5);
INSERT INTO public.books_genres VALUES (18, 2, 4);
INSERT INTO public.books_genres VALUES (19, 10, 8);
INSERT INTO public.books_genres VALUES (20, 9, 8);


--
-- Data for Name: checkouts; Type: TABLE DATA; Schema: public; Owner: temp
--

INSERT INTO public.checkouts VALUES (1, 4, 1, '2021-02-27', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (2, 4, 3, '2021-02-27', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (3, 4, 5, '2021-03-10', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (4, 4, 6, '2021-02-27', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (5, 3, 7, '2021-02-27', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (6, 7, 8, '2021-02-23', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (7, 4, 9, '2021-02-08', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (8, 10, 10, '2021-02-27', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (9, 5, 11, '2021-02-15', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (10, 2, 12, '2021-02-27', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (11, 7, 13, '2021-02-18', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (12, 8, 14, '2021-02-27', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (13, 8, 15, '2021-02-27', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (14, 2, 16, '2021-02-10', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (15, 2, 17, '2021-02-27', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (16, 10, 19, '2021-02-14', '2021-02-13 08:29:14.762501');
INSERT INTO public.checkouts VALUES (17, 6, 20, '2021-02-27', '2021-02-13 08:29:14.762501');


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: temp
--

INSERT INTO public.genres VALUES (1, 'Classic');
INSERT INTO public.genres VALUES (2, 'Crime');
INSERT INTO public.genres VALUES (3, 'Horror');
INSERT INTO public.genres VALUES (4, 'Mystery');
INSERT INTO public.genres VALUES (5, 'Realistic Fiction');
INSERT INTO public.genres VALUES (6, 'Romance');
INSERT INTO public.genres VALUES (7, 'Travel');
INSERT INTO public.genres VALUES (8, 'Biography');
INSERT INTO public.genres VALUES (9, 'Reference');


--
-- Data for Name: publishers; Type: TABLE DATA; Schema: public; Owner: temp
--

INSERT INTO public.publishers VALUES (1, 'Dolor Sit Company', '1117 Eget, Av.', '9240712553', 'mauris@elitfermentumrisus.ca', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (2, 'Mattis Velit Justo Associates', '461-761 Per Av.', '1166242196', 'eu@vitaesodalesnisi.org', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (3, 'Viverra Maecenas Iaculis Institute', 'Ap #871-7990 Orci Street', '2214324510', 'Quisque.purus@pedenecante.net', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (4, 'Quisque Incorporated', '9458 Nisl. St.', '9795828968', 'et.euismod.et@utcursusluctus.co.uk', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (5, 'Taciti Inc.', '5844 In Ave', '7482791558', 'luctus@hendreritconsectetuer.net', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (6, 'Mi Felis Adipiscing Consulting', '388-7555 Ut Ave', '9929988035', NULL, '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (7, 'Libero PC', '755-2919 Tempor Ave', '4828817364', 'sed@Namtempordiam.com', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (8, 'In Ornare Ltd', 'P.O. Box 602, 9653 Lacus Rd.', '5880513295', 'tincidunt.nunc@diamat.ca', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (9, 'Velit Cras Lorem Inc.', '996-2428 Vitae Rd.', '4769631029', 'amet@In.edu', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (10, 'Ut Institute', '947-9285 In Rd.', '4175784775', NULL, '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (11, 'Elit Foundation', 'Ap #628-3704 Et Av.', '3555534470', 'Aliquam.rutrum@diam.net', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (12, 'Mollis Vitae Consulting', '544 Nibh. Avenue', '1784356834', 'tempor.lorem.eget@ligulaNullam.org', '2021-02-11 10:54:19.361832');
INSERT INTO public.publishers VALUES (13, 'Duis Gravida Praesent Corp.', 'Ap #672-9081 Mauris St.', '5841931550', 'sodales.Mauris.blandit@VivamusrhoncusDonec.net', '2021-02-11 10:54:19.361832');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: temp
--

INSERT INTO public.users VALUES (4, 'Margret', 'Rodriguez', 'Jimmie_Swaniawski@lisandro.me', '2021-02-13 08:28:52.415286', NULL);
INSERT INTO public.users VALUES (5, 'Jovanny', 'Kerluke', NULL, '2021-02-13 08:28:52.415286', NULL);
INSERT INTO public.users VALUES (1, 'Sherman', 'Abbott', 'Janae@edgar.ca', '2021-02-13 08:28:52.415286', true);
INSERT INTO public.users VALUES (3, 'Florencio', 'Hermiston', 'Audreanne.Predovic@shaina.name', '2021-02-13 08:28:52.415286', true);
INSERT INTO public.users VALUES (6, 'Easter', 'Gutkowski', 'Arjun@ova.org', '2021-02-13 08:28:52.415286', true);
INSERT INTO public.users VALUES (2, 'Kaycee', 'Homenick', 'Brian_Lebsack@richmond.biz', '2021-02-13 08:28:52.415286', false);
INSERT INTO public.users VALUES (7, 'Manuel', 'Corwin', 'Neal_King@eda.ca', '2021-02-13 08:28:52.415286', false);
INSERT INTO public.users VALUES (8, 'Clement', 'Grant', NULL, '2021-02-13 08:28:52.415286', false);
INSERT INTO public.users VALUES (9, 'Madelynn', 'Barrows', 'Fernando@amina.com', '2021-02-13 08:28:52.415286', false);
INSERT INTO public.users VALUES (10, 'Simone', 'Trantow', 'Ethyl@emmalee.ca', '2021-02-13 08:28:52.415286', false);


--
-- Name: authors_books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: temp
--

SELECT pg_catalog.setval('public.authors_books_id_seq', 22, true);


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: temp
--

SELECT pg_catalog.setval('public.authors_id_seq', 14, true);


--
-- Name: books_genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: temp
--

SELECT pg_catalog.setval('public.books_genres_id_seq', 20, true);


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: temp
--

SELECT pg_catalog.setval('public.books_id_seq', 20, true);


--
-- Name: checkouts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: temp
--

SELECT pg_catalog.setval('public.checkouts_id_seq', 17, true);


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: temp
--

SELECT pg_catalog.setval('public.genres_id_seq', 9, true);


--
-- Name: publishers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: temp
--

SELECT pg_catalog.setval('public.publishers_id_seq', 14, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: temp
--

SELECT pg_catalog.setval('public.users_id_seq', 10, true);


--
-- Name: authors_books authors_books_book_id_author_id_key; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.authors_books
    ADD CONSTRAINT authors_books_book_id_author_id_key UNIQUE (book_id, author_id);


--
-- Name: authors_books authors_books_pkey; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.authors_books
    ADD CONSTRAINT authors_books_pkey PRIMARY KEY (id);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: books_genres books_genres_book_id_genre_id_key; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.books_genres
    ADD CONSTRAINT books_genres_book_id_genre_id_key UNIQUE (book_id, genre_id);


--
-- Name: books_genres books_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.books_genres
    ADD CONSTRAINT books_genres_pkey PRIMARY KEY (id);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: books books_title_key; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_title_key UNIQUE (title);


--
-- Name: checkouts checkouts_pkey; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.checkouts
    ADD CONSTRAINT checkouts_pkey PRIMARY KEY (id);


--
-- Name: checkouts checkouts_user_id_book_id_key; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.checkouts
    ADD CONSTRAINT checkouts_user_id_book_id_key UNIQUE (user_id, book_id);


--
-- Name: genres genres_name_key; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (id);


--
-- Name: publishers publishers_name_key; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_name_key UNIQUE (name);


--
-- Name: publishers publishers_pkey; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.publishers
    ADD CONSTRAINT publishers_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: authors_books authors_books_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.authors_books
    ADD CONSTRAINT authors_books_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id) ON DELETE CASCADE;


--
-- Name: authors_books authors_books_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.authors_books
    ADD CONSTRAINT authors_books_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: books_genres books_genres_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.books_genres
    ADD CONSTRAINT books_genres_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: books_genres books_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.books_genres
    ADD CONSTRAINT books_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(id) ON DELETE CASCADE;


--
-- Name: books books_publisher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_publisher_id_fkey FOREIGN KEY (publisher_id) REFERENCES public.publishers(id) ON DELETE CASCADE;


--
-- Name: checkouts checkouts_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.checkouts
    ADD CONSTRAINT checkouts_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: checkouts checkouts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: temp
--

ALTER TABLE ONLY public.checkouts
    ADD CONSTRAINT checkouts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

