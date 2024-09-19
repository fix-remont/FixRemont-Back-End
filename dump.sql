--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

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
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id integer NOT NULL,
    object character varying NOT NULL,
    tariff character varying NOT NULL,
    location character varying NOT NULL,
    rate integer NOT NULL,
    current_stage character varying NOT NULL,
    user_id integer
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: contracts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contracts (
    id integer NOT NULL,
    object character varying NOT NULL,
    tariff character varying NOT NULL,
    location character varying NOT NULL,
    total_cost integer NOT NULL,
    current_stage character varying NOT NULL,
    user_id integer
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
-- Name: message_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_type (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.message_type OWNER TO postgres;

--
-- Name: message_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.message_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.message_type_id_seq OWNER TO postgres;

--
-- Name: message_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.message_type_id_seq OWNED BY public.message_type.id;


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
    message_type_id integer,
    content character varying NOT NULL,
    attachment bytea,
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
-- Name: post_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_type (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.post_type OWNER TO postgres;

--
-- Name: post_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.post_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.post_type_id_seq OWNER TO postgres;

--
-- Name: post_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.post_type_id_seq OWNED BY public.post_type.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id integer NOT NULL,
    title character varying,
    post_type_id integer,
    content character varying[],
    images character varying[]
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
    phone character varying,
    user_type_id integer,
    user_referral_code character varying,
    others_referral_code character varying,
    notification_status_id integer,
    is_active boolean,
    is_superuser boolean
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
-- Name: works; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.works (
    id integer NOT NULL,
    title character varying,
    project_type_id integer,
    deadline integer,
    cost integer,
    square integer,
    task character varying,
    description character varying[],
    images character varying[]
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
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: contracts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts ALTER COLUMN id SET DEFAULT nextval('public.contracts_id_seq'::regclass);


--
-- Name: flats id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flats ALTER COLUMN id SET DEFAULT nextval('public.flats_id_seq'::regclass);


--
-- Name: message_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_type ALTER COLUMN id SET DEFAULT nextval('public.message_type_id_seq'::regclass);


--
-- Name: notification_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_type ALTER COLUMN id SET DEFAULT nextval('public.notification_type_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: post_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_type ALTER COLUMN id SET DEFAULT nextval('public.post_type_id_seq'::regclass);


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
-- Name: works id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works ALTER COLUMN id SET DEFAULT nextval('public.works_id_seq'::regclass);


--
-- Data for Name: additional_options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.additional_options (id, name, description) FROM stdin;
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, object, tariff, location, rate, current_stage, user_id) FROM stdin;
\.


--
-- Data for Name: contracts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contracts (id, object, tariff, location, total_cost, current_stage, user_id) FROM stdin;
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
-- Data for Name: message_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_type (id, name) FROM stdin;
\.


--
-- Data for Name: notification_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_type (id, name) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, message_type_id, content, attachment, user_id) FROM stdin;
\.


--
-- Data for Name: post_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_type (id, name) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, title, post_type_id, content, images) FROM stdin;
\.


--
-- Data for Name: project_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_type (id, name) FROM stdin;
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

COPY public.users (id, email, hashed_password, name, surname, phone, user_type_id, user_referral_code, others_referral_code, notification_status_id, is_active, is_superuser) FROM stdin;
1	string	$2b$12$UGaVE/IJMfnwoxPsptwapupxMWrwB.I0ClM9keAGnlk7iK9XhfvhS	\N	\N	\N	\N	EROLWG98EOE96RV1	\N	\N	t	t
\.


--
-- Data for Name: works; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.works (id, title, project_type_id, deadline, cost, square, task, description, images) FROM stdin;
\.


--
-- Name: additional_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.additional_options_id_seq', 1, false);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 1, false);


--
-- Name: contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contracts_id_seq', 1, false);


--
-- Name: flats_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.flats_id_seq', 1, false);


--
-- Name: message_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.message_type_id_seq', 1, false);


--
-- Name: notification_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_type_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- Name: post_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_type_id_seq', 1, false);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 1, false);


--
-- Name: project_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_type_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.user_type_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: works_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.works_id_seq', 1, false);


--
-- Name: additional_options additional_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.additional_options
    ADD CONSTRAINT additional_options_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: contracts contracts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_pkey PRIMARY KEY (id);


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
-- Name: message_type message_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_type
    ADD CONSTRAINT message_type_pkey PRIMARY KEY (id);


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
-- Name: post_type post_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_type
    ADD CONSTRAINT post_type_pkey PRIMARY KEY (id);


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
-- Name: works works_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_pkey PRIMARY KEY (id);


--
-- Name: ix_additional_options_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_additional_options_id ON public.additional_options USING btree (id);


--
-- Name: ix_clients_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_clients_id ON public.clients USING btree (id);


--
-- Name: ix_contracts_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_contracts_id ON public.contracts USING btree (id);


--
-- Name: ix_flats_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_flats_id ON public.flats USING btree (id);


--
-- Name: ix_notifications_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_notifications_id ON public.notifications USING btree (id);


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
-- Name: ix_works_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_works_id ON public.works USING btree (id);


--
-- Name: ix_works_title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_works_title ON public.works USING btree (title);


--
-- Name: clients clients_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: contracts contracts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contracts
    ADD CONSTRAINT contracts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


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
-- Name: notifications notifications_message_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_message_type_id_fkey FOREIGN KEY (message_type_id) REFERENCES public.message_type(id);


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: posts posts_post_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_post_type_id_fkey FOREIGN KEY (post_type_id) REFERENCES public.post_type(id);


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
-- Name: works works_project_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_project_type_id_fkey FOREIGN KEY (project_type_id) REFERENCES public.project_type(id);


--
-- PostgreSQL database dump complete
--

