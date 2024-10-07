--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

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

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: contractnotificationstatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.contractnotificationstatus AS ENUM (
    'sign_act',
    'message'
);


ALTER TYPE public.contractnotificationstatus OWNER TO postgres;

--
-- Name: ordertype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.ordertype AS ENUM (
    'renovation',
    'building'
);


ALTER TYPE public.ordertype OWNER TO postgres;

--
-- Name: posttype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.posttype AS ENUM (
    'news',
    'blog'
);


ALTER TYPE public.posttype OWNER TO postgres;

--
-- Name: tarifftype; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.tarifftype AS ENUM (
    'base',
    'standard',
    'comfort',
    'business'
);


ALTER TYPE public.tarifftype OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: additional_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.additional_options (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying
);


ALTER TABLE public.additional_options OWNER TO postgres;

--
-- Name: additional_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.additional_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.additional_options_id_seq OWNER TO postgres;

--
-- Name: additional_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.additional_options_id_seq OWNED BY public.additional_options.id;


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contracts (
    id integer NOT NULL,
    object character varying,
    order_type public.ordertype,
    tariff_type public.tarifftype,
    square integer,
    location character varying,
    current_stage character varying,
    total_cost integer,
    materials_cost integer,
    work_cost integer,
    revenue integer,
    client_id integer,
    date character varying,
    document bytea
);


ALTER TABLE public.contracts OWNER TO postgres;

--
-- Name: contracts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contracts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contracts_id_seq OWNER TO postgres;

--
-- Name: contracts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contracts_id_seq OWNED BY public.contracts.id;


--
-- Name: faqs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faqs (
    id integer NOT NULL,
    heading character varying,
    label character varying,
    date character varying,
    key_word character varying
);


ALTER TABLE public.faqs OWNER TO postgres;

--
-- Name: faqs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faqs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faqs_id_seq OWNER TO postgres;

--
-- Name: faqs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faqs_id_seq OWNED BY public.faqs.id;


--
-- Name: flat_additional_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flat_additional_options (
    flat_id integer NOT NULL,
    additional_option_id integer NOT NULL
);


ALTER TABLE public.flat_additional_options OWNER TO postgres;

--
-- Name: flats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flats (
    id integer NOT NULL,
    square integer NOT NULL,
    address character varying NOT NULL,
    number_of_rooms integer NOT NULL,
    number_of_doors integer NOT NULL,
    number_of_wc integer NOT NULL,
    demolition boolean,
    wall_build boolean,
    liquid_floor boolean,
    ceiling_stretching boolean,
    tariff_id integer,
    style_id integer
);


ALTER TABLE public.flats OWNER TO postgres;

--
-- Name: flats_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.flats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.flats_id_seq OWNER TO postgres;

--
-- Name: flats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.flats_id_seq OWNED BY public.flats.id;


--
-- Name: notification_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notification_type (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.notification_type OWNER TO postgres;

--
-- Name: notification_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_type_id_seq OWNER TO postgres;

--
-- Name: notification_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_type_id_seq OWNED BY public.notification_type.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    notification_status public.contractnotificationstatus,
    title character varying,
    date character varying,
    label character varying,
    attachment bytea,
    contract_id integer,
    user_id integer
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO postgres;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: paragraphs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paragraphs (
    id integer NOT NULL,
    title character varying,
    body character varying,
    post_id integer
);


ALTER TABLE public.paragraphs OWNER TO postgres;

--
-- Name: paragraphs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paragraphs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paragraphs_id_seq OWNER TO postgres;

--
-- Name: paragraphs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paragraphs_id_seq OWNED BY public.paragraphs.id;


--
-- Name: platform_news; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.platform_news (
    id integer NOT NULL,
    title character varying,
    date character varying,
    label character varying
);


ALTER TABLE public.platform_news OWNER TO postgres;

--
-- Name: platform_news_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.platform_news_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.platform_news_id_seq OWNER TO postgres;

--
-- Name: platform_news_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.platform_news_id_seq OWNED BY public.platform_news.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    title character varying,
    post_type public.posttype NOT NULL,
    image1 character varying,
    image2 character varying,
    image3 character varying
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO postgres;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: project_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.project_type (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.project_type OWNER TO postgres;

--
-- Name: project_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.project_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_type_id_seq OWNER TO postgres;

--
-- Name: project_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.project_type_id_seq OWNED BY public.project_type.id;


--
-- Name: styles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.styles (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying
);


ALTER TABLE public.styles OWNER TO postgres;

--
-- Name: styles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.styles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.styles_id_seq OWNER TO postgres;

--
-- Name: styles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.styles_id_seq OWNED BY public.styles.id;


--
-- Name: tariffs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tariffs (
    id integer NOT NULL,
    name character varying NOT NULL,
    description character varying
);


ALTER TABLE public.tariffs OWNER TO postgres;

--
-- Name: tariffs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tariffs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tariffs_id_seq OWNER TO postgres;

--
-- Name: tariffs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tariffs_id_seq OWNED BY public.tariffs.id;


--
-- Name: user_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_type (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.user_type OWNER TO postgres;

--
-- Name: user_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_type_id_seq OWNER TO postgres;

--
-- Name: user_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_type_id_seq OWNED BY public.user_type.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying,
    hashed_password character varying,
    name character varying,
    surname character varying,
    patronymic character varying,
    phone character varying,
    user_type_id integer,
    user_referral_code character varying,
    others_referral_code character varying,
    notification_status_id integer,
    is_verified boolean,
    is_superuser boolean,
    avatar character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: work_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.work_status (
    id integer NOT NULL,
    title character varying,
    document bytea,
    status boolean,
    contract_id integer
);


ALTER TABLE public.work_status OWNER TO postgres;

--
-- Name: work_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.work_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.work_status_id_seq OWNER TO postgres;

--
-- Name: work_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.work_status_id_seq OWNED BY public.work_status.id;


--
-- Name: works; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.works (
    id integer NOT NULL,
    title character varying,
    project_type_id integer,
    deadline character varying,
    cost integer,
    square integer,
    task character varying,
    description character varying[],
    image1 character varying,
    image2 character varying,
    image3 character varying,
    image4 character varying,
    image5 character varying,
    video_link character varying,
    video_duration character varying
);


ALTER TABLE public.works OWNER TO postgres;

--
-- Name: works_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.works_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.works_id_seq OWNER TO postgres;

--
-- Name: works_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.works_id_seq OWNED BY public.works.id;


--
-- Name: additional_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.additional_options ALTER COLUMN id SET DEFAULT nextval('public.additional_options_id_seq'::regclass);


--
-- Name: contracts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts ALTER COLUMN id SET DEFAULT nextval('public.contracts_id_seq'::regclass);


--
-- Name: faqs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faqs ALTER COLUMN id SET DEFAULT nextval('public.faqs_id_seq'::regclass);


--
-- Name: flats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flats ALTER COLUMN id SET DEFAULT nextval('public.flats_id_seq'::regclass);


--
-- Name: notification_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_type ALTER COLUMN id SET DEFAULT nextval('public.notification_type_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: paragraphs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paragraphs ALTER COLUMN id SET DEFAULT nextval('public.paragraphs_id_seq'::regclass);


--
-- Name: platform_news id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platform_news ALTER COLUMN id SET DEFAULT nextval('public.platform_news_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: project_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_type ALTER COLUMN id SET DEFAULT nextval('public.project_type_id_seq'::regclass);


--
-- Name: styles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.styles ALTER COLUMN id SET DEFAULT nextval('public.styles_id_seq'::regclass);


--
-- Name: tariffs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariffs ALTER COLUMN id SET DEFAULT nextval('public.tariffs_id_seq'::regclass);


--
-- Name: user_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_type ALTER COLUMN id SET DEFAULT nextval('public.user_type_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: work_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_status ALTER COLUMN id SET DEFAULT nextval('public.work_status_id_seq'::regclass);


--
-- Name: works id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works ALTER COLUMN id SET DEFAULT nextval('public.works_id_seq'::regclass);


--
-- Data for Name: additional_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.additional_options (id, name, description) FROM stdin;
\.


--
-- Data for Name: contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contracts (id, object, order_type, tariff_type, square, location, current_stage, total_cost, materials_cost, work_cost, revenue, client_id, date, document) FROM stdin;
1	string	\N	base	\N	string	string	\N	\N	\N	0	\N	\N	\N
2	string	\N	base	\N	string	string	\N	\N	\N	0	\N	\N	\N
3	string	\N	base	\N	string	string	\N	\N	\N	0	\N	\N	\N
4	string	\N	base	\N	string	string	\N	\N	\N	110	\N	\N	\N
\.


--
-- Data for Name: faqs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faqs (id, heading, label, date, key_word) FROM stdin;
1	string	\N	string	string
2	string	\N	string	string
3	string	\N	string	string
4	string	\N	string	st1ring
\.


--
-- Data for Name: flat_additional_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flat_additional_options (flat_id, additional_option_id) FROM stdin;
\.


--
-- Data for Name: flats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flats (id, square, address, number_of_rooms, number_of_doors, number_of_wc, demolition, wall_build, liquid_floor, ceiling_stretching, tariff_id, style_id) FROM stdin;
\.


--
-- Data for Name: notification_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_type (id, name) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, notification_status, title, date, label, attachment, contract_id, user_id) FROM stdin;
1	message	string	string	string	\N	\N	\N
2	message	string	string	string	\N	\N	\N
\.


--
-- Data for Name: paragraphs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paragraphs (id, title, body, post_id) FROM stdin;
1	string	string	1
\.


--
-- Data for Name: platform_news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.platform_news (id, title, date, label) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, title, post_type, image1, image2, image3) FROM stdin;
1	string	news	string	\N	\N
\.


--
-- Data for Name: project_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_type (id, name) FROM stdin;
2	Строительство домов
3	Ремонт квартир
\.


--
-- Data for Name: styles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.styles (id, name, description) FROM stdin;
\.


--
-- Data for Name: tariffs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tariffs (id, name, description) FROM stdin;
\.


--
-- Data for Name: user_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_type (id, name) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, name, surname, patronymic, phone, user_type_id, user_referral_code, others_referral_code, notification_status_id, is_verified, is_superuser, avatar) FROM stdin;
1	user@example.com	$2b$12$8o5NXdPWPbltdij4bCq5IOgYSOXCQUcwzSbMOxwex3EHe7i2WyY..	\N	\N	\N	\N	\N	7H6LE6VYWF2AGH5C	\N	\N	f	t	\N
\.


--
-- Data for Name: work_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.work_status (id, title, document, status, contract_id) FROM stdin;
\.


--
-- Data for Name: works; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.works (id, title, project_type_id, deadline, cost, square, task, description, image1, image2, image3, image4, image5, video_link, video_duration) FROM stdin;
1	Дом из кирпича 560 м2 на Барвихе	2	15 дней	2500000	240	Театр, специализирующийся на разнообразных представлениях, выразил желание усовершенствовать свои технические возможности для привлечения новой аудитории и создания незабываемых визуальных впечатлений. Заказчик искал комплексное решение для обновления мультимедийного оборудования на сцене и в зрительном зале.	{"Тест1: абоба","Тест2: обабо"}	\N	\N	\N	\N	\N	https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley	1:25 минут
\.


--
-- Name: additional_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.additional_options_id_seq', 1, false);


--
-- Name: contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contracts_id_seq', 4, true);


--
-- Name: faqs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faqs_id_seq', 4, true);


--
-- Name: flats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flats_id_seq', 1, false);


--
-- Name: notification_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_type_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 2, true);


--
-- Name: paragraphs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paragraphs_id_seq', 1, true);


--
-- Name: platform_news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.platform_news_id_seq', 1, false);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 1, true);


--
-- Name: project_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_type_id_seq', 4, true);


--
-- Name: styles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.styles_id_seq', 1, false);


--
-- Name: tariffs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tariffs_id_seq', 1, false);


--
-- Name: user_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_type_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: work_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_status_id_seq', 1, false);


--
-- Name: works_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.works_id_seq', 4, true);


--
-- Name: additional_options additional_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.additional_options
    ADD CONSTRAINT additional_options_pkey PRIMARY KEY (id);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id);


--
-- Name: faqs faqs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faqs
    ADD CONSTRAINT faqs_pkey PRIMARY KEY (id);


--
-- Name: flat_additional_options flat_additional_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flat_additional_options
    ADD CONSTRAINT flat_additional_options_pkey PRIMARY KEY (flat_id, additional_option_id);


--
-- Name: flats flats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flats
    ADD CONSTRAINT flats_pkey PRIMARY KEY (id);


--
-- Name: notification_type notification_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_type
    ADD CONSTRAINT notification_type_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: paragraphs paragraphs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paragraphs
    ADD CONSTRAINT paragraphs_pkey PRIMARY KEY (id);


--
-- Name: platform_news platform_news_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.platform_news
    ADD CONSTRAINT platform_news_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: project_type project_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.project_type
    ADD CONSTRAINT project_type_pkey PRIMARY KEY (id);


--
-- Name: styles styles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.styles
    ADD CONSTRAINT styles_pkey PRIMARY KEY (id);


--
-- Name: tariffs tariffs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariffs
    ADD CONSTRAINT tariffs_pkey PRIMARY KEY (id);


--
-- Name: user_type user_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_type
    ADD CONSTRAINT user_type_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_user_referral_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_referral_code_key UNIQUE (user_referral_code);


--
-- Name: work_status work_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_status
    ADD CONSTRAINT work_status_pkey PRIMARY KEY (id);


--
-- Name: works works_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_pkey PRIMARY KEY (id);


--
-- Name: ix_additional_options_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_additional_options_id ON public.additional_options USING btree (id);


--
-- Name: ix_contracts_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_contracts_id ON public.contracts USING btree (id);


--
-- Name: ix_faqs_heading; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_faqs_heading ON public.faqs USING btree (heading);


--
-- Name: ix_faqs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_faqs_id ON public.faqs USING btree (id);


--
-- Name: ix_flats_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_flats_id ON public.flats USING btree (id);


--
-- Name: ix_notifications_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notifications_id ON public.notifications USING btree (id);


--
-- Name: ix_paragraphs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_paragraphs_id ON public.paragraphs USING btree (id);


--
-- Name: ix_paragraphs_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_paragraphs_title ON public.paragraphs USING btree (title);


--
-- Name: ix_platform_news_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_platform_news_id ON public.platform_news USING btree (id);


--
-- Name: ix_platform_news_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_platform_news_title ON public.platform_news USING btree (title);


--
-- Name: ix_posts_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_posts_id ON public.posts USING btree (id);


--
-- Name: ix_posts_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_posts_title ON public.posts USING btree (title);


--
-- Name: ix_styles_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_styles_id ON public.styles USING btree (id);


--
-- Name: ix_tariffs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_tariffs_id ON public.tariffs USING btree (id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_users_id ON public.users USING btree (id);


--
-- Name: ix_work_status_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_work_status_id ON public.work_status USING btree (id);


--
-- Name: ix_work_status_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_work_status_title ON public.work_status USING btree (title);


--
-- Name: ix_works_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_works_id ON public.works USING btree (id);


--
-- Name: ix_works_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_works_title ON public.works USING btree (title);


--
-- Name: contracts contracts_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- Name: flat_additional_options flat_additional_options_additional_option_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flat_additional_options
    ADD CONSTRAINT flat_additional_options_additional_option_id_fkey FOREIGN KEY (additional_option_id) REFERENCES public.additional_options(id);


--
-- Name: flat_additional_options flat_additional_options_flat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flat_additional_options
    ADD CONSTRAINT flat_additional_options_flat_id_fkey FOREIGN KEY (flat_id) REFERENCES public.flats(id);


--
-- Name: flats flats_style_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flats
    ADD CONSTRAINT flats_style_id_fkey FOREIGN KEY (style_id) REFERENCES public.styles(id);


--
-- Name: flats flats_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flats
    ADD CONSTRAINT flats_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariffs(id);


--
-- Name: notifications notifications_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.contracts(id);


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: paragraphs paragraphs_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paragraphs
    ADD CONSTRAINT paragraphs_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- Name: users users_notification_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_notification_status_id_fkey FOREIGN KEY (notification_status_id) REFERENCES public.notification_type(id);


--
-- Name: users users_user_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_type_id_fkey FOREIGN KEY (user_type_id) REFERENCES public.user_type(id);


--
-- Name: work_status work_status_contract_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.work_status
    ADD CONSTRAINT work_status_contract_id_fkey FOREIGN KEY (contract_id) REFERENCES public.contracts(id);


--
-- Name: works works_project_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_project_type_id_fkey FOREIGN KEY (project_type_id) REFERENCES public.project_type(id);


--
-- PostgreSQL database dump complete
--

