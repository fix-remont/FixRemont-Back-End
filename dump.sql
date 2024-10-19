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
5	Name	renovation	business	12	Pushkina kolotushkina	-	525000	3075000	2175000	32000	1	11.03.2024	\N
\.


--
-- Data for Name: faqs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faqs (id, heading, label, date, key_word) FROM stdin;
5	Не проходит оплата. Что делать?	Попробуйте снова	25 февраля 2024	Оплата
6	В каком формате скачанные файлы?	В .pdf	25 февраля 2024	Скачать документы
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
6	sign_act	Договор	10 февраля 2024	Договор	\\x255044462d312e350a25bff7a2fe0a372030206f626a0a3c3c202f4c696e656172697a65642031202f4c203537393031202f48205b203236323520313533205d202f4f203132202f45203438363039202f4e2032202f54203537363030203e3e0a656e646f626a0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200a382030206f626a0a3c3c202f54797065202f58526566202f4c656e677468203731202f46696c746572202f466c6174654465636f6465202f4465636f64655061726d73203c3c202f436f6c756d6e732034202f507265646963746f72203132203e3e202f57205b203120322031205d202f496e646578205b2037203433205d202f496e666f203520302052202f526f6f74203920302052202f53697a65203530202f5072657620353736303120202020202020202020202020202020202f4944205b3c36333535356363636563386262633030666566623566616465373166373231633e3c35623666316161303036386563663530623536303035363534623236396339303e5d203e3e0a73747265616d0a789c636264e067606260380924983340ac2c20c13e1dc49a092418f38104cb0f20a1570d24e4a580845d2c9010b700e9d007118c2042978189d1cd09a48d8171e009001527077e0a656e6473747265616d0a656e646f626a0a2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200a392030206f626a0a3c3c202f4e616d657320343920302052202f4f70656e416374696f6e20323520302052202f506167654d6f6465202f5573654f75746c696e6573202f506167657320333320302052202f54797065202f436174616c6f67203e3e0a656e646f626a0a31302030206f626a0a3c3c202f54797065202f4f626a53746d202f4c656e6774682031353832202f46696c746572202f466c6174654465636f6465202f4e203238202f466972737420323034203e3e0a73747265616d0a789cbd586d6f133910fe7ebfc21f41a8f17afd2ea14af425a540a1d7145a0ef5439a6e923dd26cd86cb8c2afbf67ec4db2499a520e745263cfda63cfcc3333f6b869ca12964a6658aa984859aa99162c35cc69965a96a68ed19fc59867120c32614a2b904c7bcb64caac499894cc279853cc6bc9a46642248e49835e63d66267876f87dea3f74c58a7984a9870605602bd420ff1a9462f2113cc8ac40892070110a80cb64ad043ae178629b08814df1e4bd3f48fe7cfd9eeeeb2e593417f520eaed927c64fbb55959563c60fb2af792f3b3bda635773b603300882e18cf1765e618277183f2ace8b39c77e312acacea4dbcb08a5c07878571d75aa6e8591f9d2625c31e26e1360be1e24d4929a06012b6a5a127644efee2ed58323c2f46959f43a5915343f68337e9edd55f72b7cf9f12fa64dcb30ef448b401ecf46a307582db1eaa4a5d618f7bad32c58c03f1e1ebf7a77f16cffe40c0b014839adf687dd9209156d3cc8a6bd329f5445498e093bbfe9ce790006efccaeab6f930c5aa315e88af7e3bc57dc00aa1a89f3301dc55de437d5704abe8f60ac6973f4e1f0f0fc1db4d9bb5c5507c1b0a18e5c5747d887d4116ebb3ae27e75ce2f2efedc7bf5acd33e3b116992200ec6d82a1f0f28a8eb085a0026ef51d1aeab484c0f2026b6ab986c51f1e0fdebf76f81d8c9f19a03f5a63a6a4d1d64e74380f9adda48d7d466bf98610ed25fe737d365084663aee61b9c7607d9f47fc931d0968ea35fc8b747a5dbd20bedb3b7c72ff7e085ce47d77482dcf48159f3817cc8056abb07ecdc039f9896a225d91528e935725da5b665715eca164e4be80f609401ad8dc4b8b6b08569e769163caee6d79ad6ea045702d6d0f9ac890f730e6b3c468c90e030921031892719da118fb5d8cb25aee5c37aa915468d12e0f65899ded3a636fe14f430bfa19def678d588c35692d0cb4b3b8b3ac924425092c7242329b2a58682421616d0a9d9d203c1550853d8ad072082e630c69af2ce6709fc162ab1c68033ed056633fab348d24694085e418033c6d82bd3de4d0de2969631cd6188ce31a7534db6c9b3829919016388e9530c1cb2146f37e3f2bb3712f0bf946a7ca354233ab96e9b638aa428810083a860814804ae657dbb84fdd2a32ca591d4231ad5bfa768ae45aef61960bbc0eab01a07400c32696f800a6047770260e1ded104c01080350513d2426c45760704a91f7809fae692729920d4a19eb82f78c0a7c24580893d6646c8db30bad494e138da6455a51b8d0a61ae77ee811fc94482185023f8dceed0fa39eda38e2a5ad3996bc715e69d24385156ac1459e712872e81742d907e73f18f214cc4aea055f44b319f42ea4b7f7e9221956d3ce09d3a0961ccd606ca652984b0d40fe3da93bd7a691b8865c18db3842561a2f17d162151d4831198d8ca1200397d492622f9161256691c6883a1f56c9f97e7165bd779a5032aac5dec4859f4812b3f8d0dead18bc4a2dbf689be88e25d574238d2e5d4be7910bdf047d58b1e08a73732798c519b19c8bea463ab6515e3c1d5e4c7b19ae0ae351c3ed77272fb37c30c4a7c32941570e5d7d4ff83e3fe66ff83b7ecacff839eff26bdee3373ce37d3ee0439ef3cf7cc46ff99817bc18677cc22759991737bce4533e1d75a7435ef1d953aab0a3b01d41d2daa3ee00b54abcabf6f68a3b9c4e3b7823eca478660841eec20be12aceb7f3514675e6e2ae7fdbbdcd366ac0e3aa3bca7b2fc60330a302eb54d9ed0738c8376fc5c6fdca2f6b7315c0aaefe96d78c8261e2f80c82550c826d37c548cc5e36c43f501dbf0b249f088dab04dafdbb656ad356ddba18a3b5a872be347c641eecf1ad786c34fd61cde4319360e6ecfee7aa3ee2dbcdfefe7bc9f7f452014b332c4c2f0db64988d11127f6f06451797d028eb57912a49f63c52beccb2699563fb2fb3a2ca6eae47719602a8e2d5b0cc325efd53f019ffcaeff837fe9d7fcfcae291a8ab18511e25d906e8661df4d527cebdf1f45f1027c1db1147790718a69f6fbbd5f09146256cc76bbab3f018b7d6af5825d78d5aad38b70412bd9a7ed6ac15a392a649b1c26818936cb1840cd89178fe0985c6e3b1b7e220bb9115ebcfac7b7d4470ffc898646ecc9bfc36afa8367a7250f476f0ac28a1f893099e20adf429a94392d7e7d3f8aa896c380052dbf8c632a9eb17cdfca580009fd2ff25ea4afc5ffdab4ec20a656e6473747265616d0a656e646f626a0a31312030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f53203530202f4c656e677468203735203e3e0a73747265616d0a789c636060606160e07264606660507cc120c0000560360b488e81e5c0447906060e65d7f44e10030970413103433e031f0383c5ec66b9d59f77e64cd8c03489eb87d602060600dc720e790a656e6473747265616d0a656e646f626a0a31322030206f626a0a3c3c202f436f6e74656e747320313320302052202f4d65646961426f78205b20302030203631322031303038205d202f506172656e7420333320302052202f5265736f757263657320323620302052202f54797065202f50616765203e3e0a656e646f626a0a31332030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e67746820393433203e3e0a73747265616d0a789cd5574b73db3610bef357a03e9107c2000810842f9da45367d269c64da25b92034dd1321b3e543e5227bfbe8b07695296658ddd64628f2c505890bbdfb78b0f4b823688a0571ed9195faebcd37396204ab11282a1d5151212c7484509e65ca0d51a7df0dfe5db2064d26fda3e082316fbcd951ea5ff57db6cdab4aa8a7a630dab20617eda7db6661a843c51d3eafe3ab7abb266683b777df2ba0eb4ad6d8c8bf590f545535b5bdfd81b2fb67d5115df526d39b1a6d00ee74142fdb42ced2f46180f3eadfef07e5f7914e01144351aa514528ce348499455de3f08d0bf4286028fc06c22d0bf484f6b0b964a12aa27088627c07f853c4109669c0969264ae4bd47de5bf3a9cdf72eaba3f3d0790f67ee2de36ace38930ac7b14049c271acd88cf4883ad2a50036011a0a196398c0e230523822b15dbc0a14f7f3b4b22b8bfaaa692b4317367c8c719d9e4764ee984a2c620893491c09e7f723a364e7a6657dc0a5241c4cce3364dc7a864c9579bacedb33c87b247c7cf72fa0cbd983d185ce53e8c87b7a78555e052cf12fa1d4123f6f6dd5d0fbc3fdb90265cf25d0e8b904ca9f4ba0e2d84077a525640ab35db5f8b3a83f5ba5300aab4723cd70b1d53a0caaa375f848ed00e0923f0ef878206c67ea6f59283a6b49f5e1f02510c24f8b32bd2cf3b3c328631c81c93c7d793801b632ad3743bac9bf3bae3bc7e2e8f9e1e0a3294379da4e2959e2800920a2faee30dea437d3b1ebcefdd666e74d5183924fc65f8fdb22118422d4a342b980ed20b8ff770eddc1175d12ae70ae86daf40b67c747103f2a80df9abaebdbb4b0cdcad2797738ad348e311db7deeb7a3bf46e79b29b2f20276431e6d07f2cf74761ee32d467900b10861e42e90ea3865685b02715c00bebdd129ef54dbbecfe32bb69f38f84c659915b6abaf91a1875e2c494b8c4264e4edc8ddd9c6104aa7fde15451278935306f6b106144753b80f2835130926d0d23e45aa1d23d05bb5c58d4532227d980d933ca822d83af3427264e80d65f990f7f0c1054838bd0d650f1f0996323e968f586099d0ff838ffb2aa42d36d7066778ad41d76b3bdd156b57d88685a1d2df9796beb63b5012544149c8a9242ef751c0b1ba5df1100534c289489e767a8f9b34ddea630c30806ace3433cdb2a14db3af7bf10882f5a57b14948edc0f49b225a43b6243e1d54170be38442e861e64e3f45dde0d2554e201d1a1fcf6656fc2d398db7fbcea4c01c0567127a8f44fa6d92aefaf5db7e0c4b1b34beaa69f125116996e167e3931ef4c04102acc997bc3812a9d47338ef0d2f81f8f8f7efd0a656e6473747265616d0a656e646f626a0a31342030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e677468312031373838202f4c656e67746832203130363634202f4c656e677468332030202f4c656e677468203131373834203e3e0a73747265616d0a789c8db705549bdb162d0cc5ddad4009eeee5ebcb8bb060810244070775a0a454a7128eeeeae6d712f5e9ce2c5dd1f3de7dc73cebdff3fc67b23632499cbf65c7bcfb5bf8496524d9355c2d2d11c24eb087165e564e3100248294bea7172013838b8d93838b8506969b5c0aef6a0ffd8516975405017b02344e85f11525010d0f5d9260d747d0e5476840014dcec019cdc004e3e214e7e210e0e00170787e07f021da1420069a03bd812a0cc06507084805c5069a51c9dbca0606b1bd7e775fef315c060c108e01414e467f9231d20e10082822d80108032d0d506e4f0bca205d01ea0e9680106b97afd570906111b5757272176760f0f0f36a0830b9b23d45a8c9105e00176b50168805c4050779025e077cb0015a003e8afd6d85069015a3660973f1d9a8e56ae1e402808f06cb0075b80202ecf296e104b1014f0bc3a40535e09a0ea0482fc19acf467000be0afcd0170b271fe5deeafecdf85c0903f928116168e0e4e40881718620db002db8300aab24a6cae9eae2c0020c4f27720d0dec5f1391fe80e04db03cd9f03fea00e04c84aa80380cf1dfed59f8b0514ece4eac2e602b6ffdd23fbef32cfdb2c03b19472747000415c5d507ff39306434116cffbeec5fed7e1da411c3d203eff41566088a5d5ef362cdd9cd8b52160673790bcf45f31cf26d47f6cd62057002f0707073f9f2000e40c00795ad8b0ff5e40cbcb09f48793f3b7f9b9073f1f27472780d5731b203fb015e8f903d5c705e80e02b842dd407e3eff76fc3742e5e40458822d5c01e6206b3004f59feacf6690d59ff8f9fca1604f8021c7b3fc38011cbf5f7f7f337e5698a523c4deeb9ff03f8e985d4e4746464b95f9af96ff764a4a3a7a027c5879b901ac5cbc9c004e4e6e41003f2f07c0efbfeba801c17ff1e0f827571e62e50810fc93eef33efd87b2fb5f1a60f86b401801ff5d4bc5f159b92000c33f4237e2e0e5b0787ee3fc7f96fb1f29ff7f2aff5de5ff2af4ff6524eb666fff879fe1cf80ff8f1fe800b6f7fa2be259b96eaecf53a0ecf83c0b90ff0dd505fd39ba928ef696ffeb9377053ecf8204c4dafeef6d04bbc8823d41966a60570b9b3fe5f2a75dfbf7a0d9832120354717f0efab05c0cac9c1f13fbee7e9b2b07bbe3e5c9e35f9870bf43c3cffbda40cc4c2d1f2f79471f1f201805028d00b95e3594a5cbcbc001fcee771b40479fea162003b1bc4d1f53905f0dc9c1fc0ca118afafb44f9f801ec52bf4d7f207e6e00bbfc3f880fc0aef40f1204b0abfe8d043800ec6aff202e00bbc63f8807c0aef537127c5e01f80f1200b09bff839e6b5afc8d7ef7cf6ef92fc8096007fd0b3e2f62f52ff8ccd5fa5ff079519b7f415e003bf85ff09984ddbfe0330bfb7fc1671a0eff40ce671a907fc1671a8e7f439ee7d8e71bfd5fee675a4effb89ff7cce959d68effea83f3991af45ff0999acb3f09cfcc5cec812effe2cef95cc3f55ff039c2ed0ff85f276fe106853edf7f7fcce6b32cfe83ffb86c41204f9005eafc8ca38570a86d4d68db759504a907ebe6a8e877da4ddd6446569f7968bbdb2d26520263657af00af4522261a0077b714386e1e2f502c583cf7e731dd2db9678f5d63bdf7bd3388d89cd56d4b971c2deb1bc7d89da6fe42864ac5aafb77c1f9c7d7582ece09a613b1568b39cdd0430d572f0ae3dbeca79d67e2bf9311c3eb3a9be55c9a788765f32c9fa413bca28a8708a36db3c639a980ad195951c9909f7d8136beae2f23b6ee6d81385421c33aadfaf0fdcf93e06ab5cd137d3de4b655a5c2e5d24342406c4e47017b8c313743e923b890a44b33e4505310ae1910556e426338d62ed5840679e6acace799192a1b1b521e25dd320a912ac8d89f0180bf5755ac9815d7bcdcc0e62dcac5afec2c9074ed35c5417f58eed0742efc8f2a974688878af9deb811ad7db942f1fed5f855e30882376ecbcdd499ce59b23c9e9fd26e83f495ff7f129e075dc1c9779b6ab61b70fd013e3a0e305fff589dfd8981c04f9b3e1b996fe8198d6380cd900357090d386325318d1ece0b36e7f6f05ee939d182c69f18789178ab6c3d52b0a9dde984f5f543eef5b84882f98886cddbc467fb13aebacb5e9163a675962089a884eb51552e886c00f29debda7e6d2cca932fcb4ff2d43d21c577cb84c1936d831b486bfb20808cc4b8cc8a17fd9f4d6fabcf04a8d5c68b46ea278f21ddaae65a5a4e547df09f992f1c3b037261eef94b12a4ac740d4d2d2479c19a5dcbaf1b95d116cc3e3679d0a6c847cb31553e422c95a24ca03bfa8eac542a1c40c24652ac17d049f13d1d743a8d3c41a0d6cbb2f6d7206ea9993b51f3d2a9f4e3650efeb68627f7e195f375ad3556193ca67d099343a52d9da22cb6aef69e2c6c1449892103fb537c576e92e560e576bbc2a41eb88f6b2d2f42a5a9be9345fc519f96226e846ee14dd7ba9b6de1f5ba5e2069d61541275b3298e9e0e9eec971e9dcf6ee9569b8a3429f4236e6ca240e8ea9a42fdc95a34eaadcd34f2e31577d9b6ffe5c69b7c0fa210ef4d75a117d30348ad1498336b236c9f26082c3c5b4a0873dd89934a5e32a406e38a1888bce79b4be555fc31955a0bfb9dd9fb1e47ae3d9b0396b12b00aa5f16ff5e68b6127fc02207965012a3389b5f5e673ae8016166334bf7a9394dc318a33e5df02b8281411ab983af059163e8dbead8a08160792387701598707f48caa7bdcd03f4cb2c120e2392072b25f43428fcdc0c7c425b90ead7277fe485a59183e8b4f22e2c583861d8508641fa852d8aa0a46eabea108c7bf67c0bdda410e9e4be07922201d890c15b8d5e0623aca2d09651bc1cf8aff3939da9f7344ec778f194e354e48b6782b5511a00517e8353bfe2f4c55863e67d6f5018b10e9261ca20ca4b44877ad60ea6958dae559e027c9af94f3ad206ac9589dd152953ba0b8a894ef595e887394d0dd9fe5a6e57f9c733aafbb59c04716594374164fec0343a7e9ebc906d84a8ddc5c9ce6f482ca22dcc43253ab244165bdcdfb8ab8648fa04ecbea1d9fc32453840b46f25d8968020c7ae005337eb831b2f55bafa30a63a858eb30b0d536846322d85c6c116043329b60f5277ca5c3fcd8679a1154a316742b9c43f6bf3fa6f57cb3b46fc571f2db2706795cd508a5623f028ad044dc5d4f62afd9065f38a2fcbc510e6b692f1121a9291369179e2dbc805bc412fb4919915880f106e48ec7048d045c458def8579894f6c36a8b55fae3e02efb33c20b1225ca65b2e29b86328f4dbd454ce2ba6e8b7548056fdd8c6670c240ab138a7f9d7f1333283d1c5e161f8b1e115857338075d88945a4760049ab9d4fa416bde36b218dfb742358e02e6a23d365aac7d0eb151bae729d8cc420f8b2709bc89277462467598fa704a195178f32e6185d4f2a0db14ae695c26574694723b6d1dc94b15e363e714be2abba8ab4fb797ba6a6a96152217db27a563132a701fecb8426a596bbbabe3983cf7d52feb57df617371765ef715b2d5338f34684d8836e01d6942cf87da8ed8b7e1fb231d547998f9104b9757c001d09ea1fec67f6e52aea1bd631f8612885295ec07a3933af6d959e604c2ad4250448ec2320a26cb95fd9b243c7a717d2430cc8d5b01979aaac6698559df44cdfb9fa0378130d63340c68446cb2a4963d92db294eee78d424f03e79d8987706bcb9e106cbf88506d71b62e53bfcf2be4ad020b8a621ff7e0f672893c5e38317f6d5c95b835df766179315a535a808682a8fb0551fef60135f02b23aa56f6b0adc36744e6b2c4466cb9891e27023d3ceb922ffd54e57b2f983456202c583958a99a79666395f6cb2392f5994ba02f45a9149f7459b4c44a52bbce900ab42fba73e3473f2d1dcb7b967069631c7c5366f13636b2263be8a79aa1c14e72c3b6dc4b8c0156434cb2905ceabe6db889d657e77fc70fe7d3fab28e36517cc8282f0b102b39103ea28059902c91d1ff1608f1d095ef48c43902015a20a3ac04c7ab2dbb0fd18b063c3e7e12381652122ba5ce1ee97368ca5062395bf823cc9f4ded7456236e99795622ff37939276550f987c2784dc84ddeb70d7fea0f01a6384ce1c6e49feb8dc0c79404370a23e0f441e7a164070580622dc0aa3deb9d1793e60d2ca6df6504584e87cf03d8084bb446e35013ee2e82ed6da04e6aa234bdcda1b2a7e19c7a49f983897fc04d49b56d54d43c60c4fff0de744901e5412a585e5c84f7241f014d0bdddba5b0eec0cf4dc92c51792eb0a4838affb362c77734b8c3abedd6d39fe14b025eaa80489fd3d3d83cdf2c7733c6573d6cd2e16464dcd9f35b098a340924f8b93b28296d0016ee809ad4c4c925972f19d244adabdf359e22e2f37bb4301a02872daa914ab97ec585d006dd7b491b29d7e1680abe993b56ffd0369d01b53a972b34b937e2e57d9b40bd31ef4e6018a63f56c748b04da8f85333df84acce1fd29c52aefc52ef8e45802e971f88d16b49f398b4948066e2caae8b1b34e735d619d0f995b810f9ac8ca7495dd187715e7404264c57bacd52acd5f125686fc120cd693ee12538941584f55aeda3d293798c6fd925b51302155fa7e2074c250a35bda1156f73cc824c83708bc92bbfa7a003465a22a539452b552eaca58aa0f5550083ca549d766c256b1de8a91d1a901975ea86ae51daec15a565674f28d642bf5af3e6e03bfab2e04430eb27c69bce3bb76ad42e37667cfb3acb8b9f3cf5bb4ddec5164a2e6fe309afb514100d8510cadc475fde876d4589eb46a85c472a1330b56054a920808f0e95acceac64a7d80bc5d17261863f39628f0e9b024728b31631d625f75c8d2fbc838dda89d210ca963f69b0a74079f2f677f609956f8b1209a761d266653d02fa8f40bcf4d1c6a70175065d6a23af9cfa61a367671b0aa095e2fd6ab1c0d001ac51a5787a5638d26fa86316043825918b57dc727ef95ab024dbf4a90bd931902eea7e13b11731935933f459ac694df081cb818bb2d71d1ecaaa5ab195d22e0ac943eaa42d75b7dd213e48287741ed5acb1d8de75c153a2471152a2e2b93d177a758011db492210b3651a73f68c86659d6cec432b7debe3c73dc554c5aa07a9331568939859505682ae51a95c42ed21ee1a757a86668386a25ef4b9b382db7e054935f8a5dbb62b3cf529f82b51d90a5b5cd2c52ab43e53c6cf536e71aa8a8d60d5c566676506c0c6deeedb362a15a64e7f6cffd5a297c7799c89fc3cedf5d2e3ae4c8baad411bf87e6b159248a620d940f61ab205fbc427c1b1db63d385af212b5895a93583ee13cb9043977c4cb312161b2034746ed3f9f2eae92246f9c9b66b1ba928137d8ef4176dacec0b229dd0a7857772ebfdee8dc188e2669a42abfb420a20278ddee18601aceb8075c1b45298a8aca12511fd2b43487f5243f979dff28be87d64fcefab1d6b3321027b34b79dd45420e47151dc693b7234f213ab65abd0ecc498a8cc21b40adce2e03a74350f52997ac1c28b311a95d6d005919c87a2a77754b67a08ad7a2e700fcad097737b329575bf32a695eea976287f31591133a751c26a4b44c48d0dbe406711e7c6eddaf0e44f3ce1a326ed7c02529ebd177db741dd8f77f780369030e0964f14699ed3c41ebf22d759bb480d78a37665546c6466beb6314d730915ed601c118f652f787925182d92e68827a98dbdb73fcf5fc196c55bbc412cd9b0a1210f48a9cd17045211eb50e26dd0917be2705a6f15ee973927db25882686ff8a62051870b6857fa86c5b7a63785491fa531608d7a2e9fe7a3217bcdbe0b13de945fd6099faf4a267e8281c9bd66570c53fcd080e741371fddd9821fa68015568f314c8d592273e81b7b8e81396b5b9219739f319f9758d506fb67dd9ed3717e096c0ce7c875ccba4ce7babd673059cb6ecc58efdfc61795811b3e6c36856f1c30b6361d6b37d4244393f4d9a57405ff4ab3547f4d9063b37fa238f34ec87ca24af2018d9bde4d065a72f755caff09be3bffac9332dd711494a8d897989a7aa9a0ec022b4f124e1de0bad27549bcb6c67e9188772364cea1cdf98b38450bd557494e5b0348f05be6cf945f2349cb96cc52367325c66f791c167fbcb88d0222a724afde3b2312b48a171cefc65c29045d0b4384175e6fdb0cdc0950b33ee684ec0fbdb5ed37a97b4cfbd9a3544193be42c40d7222f306cf5c9c430f4b199b6ee54969be4de1a3b3f337f39922e47d96fee47513f77a6b45dbf8dd907a34ca89ba5d8ca89f015b85982d4b4e3308200d551d67422c5c2ee42256d2af29a02629673eb3e4b30cdc8959af023e5e34f1aea030cbe9b099fc723e4fbd2edf58a062359f70bed5fbae4689d81f687a8b49e0886d67553d80761b67cfef9b8526853048b541f3f9ad8d94bd51c7961b52cd2923d52308ed3421a74a765d355d961f095b153bcca0306f0a7b6fdcf0c9cdb0f8a1728c0f239614134059952435a694c9e2125df8cef4ab61319cf29c099b0b0ae3c0669893a3053c60e9b11413adf61e21654efe283022b2eda18ad61c08fcda8a7b4ac2f14b47bb30cadaab4f4f8a7d8d95e8659bc258c0c42d6867fc77265c37f24a09cc333b64786e2bd2328b4315cbb66fbe80075bf48533b8fa6c610fb98856c1ee879daba617ad55a30a4f4a5e96b269a576978497c48d5f9182fd684c66b761fab7d75a913bf52cbc12ee4fed94bffb90d68ed2e65251c4feb43e644ec456b94955aae63e34160a7f27766137a9664cc433e53f61fba3e367323034703ec1113a97bc3b6dbb59a7e938f070a6fbdd1265cc2df4f37fc7cbf36634b8452b45cebef9da6e4e32c6104a3316943c31829e4ada2a9a0b4e445666bf2f9eba7be8fe4f5b0b1bd64af1827b5c6fdc7150de024086ed5381062821115d408fd19c4fc05d7e9bee42fbb77af9b3c512187207430b6bfd5e3dd2615b58153990c06aa60cfd514d37ee044589f7147e45cb47617df0ee4e1abe50f7a731947b84ff97856af72fed06d9bb3aeca435ed48e3fdf61bef4b499d7fc01d6355bf6d4eb74ab76f3e284eec8e7cc43dd90d9e0bdc2c71ce72654e6e6b5d768471b0e1096155b65888c953cba035a91861c79a5367c799d3e66a5404feab54a185151ee538622f67b2152e3af79929425df8854c4031508de1f6dd3cf4ab05dda75f988a8f5f724896fd2b09be76cd05a68d40585af41da28e19942364e53b305f1f105de532caa60b9996a65eca57236a053d01d322180f2544ce80adde47d2f6e42999f66388aeba9d084d060632d8934918ecb4b7bf82ab43d2e54a96466ef02c8c78f4ff7456563be88f45264614d1852857972e0c3e06c3ca0a55c18f8f8047ff872be4cc1164a8c7e2030d447df608052d73d620aa4b5b6c4f06f0d8835dfd851d49d2addd7cef20e3f85bdcc891c54c908cfb96491078c830ec128db2fecc51aeeb7cbd72c3672c3bb1098d9ed25b326fcf1e1bcc3ae58b7b2d03a5410d27509f0742d5aa131e378bb61114451e2013d3a2c9681b04634c20565ae645a1a5db4f8ca02ddd2bf029ac695325df47d22a4eba879d0ae43a47d80c546b6c28d34907c6ccbc14cfa91114519f4447aa7f84d74e0f757978ba6523844b09c33969898f783f7401919cc451eaace0211c3bd81323f04fe407edab99694ed403b762ef906bb08faf2420f38739161c904dc4bdf3e61fdf538b48a4efb2e599fb9121682cbf4ad7c41543c7a16b110fb7db25c0367e7d755668411c4f8529155872c987c240bbea7da243b35865c7dc53ed74dc39b5b3ee7a6b564ef9fc56d9fd166d8c57091bc2853b611169b4e57a748c9c6e1bacb58961f8b6d757c313d75c69f80186d3f014955f6d8d4134947f31dc0e8bcce6e3a5ef620e6a26e1d14f21d1a6fe35bce9ee5797353953f65073df1970f859189ce77389f3a49752f8fa83467e9314cf52c090e5aebc7d60f7bdd98bc0a2553226aeca2bfa5e01e1232cb97e0978af1d76336dd4aeed0a096fb29a1f3d5d5f8bdf4b22546471d25ca0c47e03a5390db0ac20fef73f39f4455c1c955a4fba550fd8983821a95f755990db4671324d6c830a7fd2fb5f5e86c46def1c5cea9766c9fddae4ee98e72559b2c105fc7c2627acb551edc03c02a5993a3a50f0f5e56eda69a4f54f362776cd666972f25f9e4b6511ffaf725135eddf75bea1dc6d6e35f4437ebc9f8c154a71f84856d8174715b4d7732ededd58bf1f81e10c18e45a1411f65456a635f724fa5dc1bc03d2eadabd0122eab239a788c122f85447ef149a393298f12cab113056045ec929ea49249165537cafbe627a066fa4f2fa4555a291683ed3cf3013187dedd0ef54d00b4efdcb7f3b5fe0e0776a81ab9acf9018d1bd0d637d5fb2e890b110bf706859b65256cf0c68fddc6443922940d04368cc3802fbe6956866f084aec17c3b97f040d1aaebcf5eec5fcc60e402c3c0ad17f286c4d64d9b19c786b74d6c9e7f821f9a0726aae6ba7f9a54c8f008cdcb421f6241ea6555da1d7eb407e3dc32c74ec4858a45d4b5c5d7abe560589a23bb90b05f623341a7f29f268caba75bf2c8c8d407865c55a34894603a1cb2c928e6e8cb838473ffce10a59f5ec65a148cd28c2f846351b4d24c2d1ad05f7e68754ed5c702dac4029f1c2511d9fb1c9d5a763f9e12f6d65f1216e58614ca91a22dd2ba7eb0d5447426c70fbfea329d7c874e577e1f3f55a289f60944855046be5fc459981a3edc06cf6dbd9f056863ad427d44eb8c1ef4f50c1129ba6b1fe2df2f55c48fb242d9aa2bfc8e29067f2ba9b175085fa44dd8248601c72439368685a10dc53def2e8111ea16dd8ad6cb97db0afde91f2b86c551781345eef21b4b4443d844967bca3dc229cc6d4c8177771bf6ea2dc33e9752767d97ca14456c8475943fb4a71d969358e257503e2d44df84ac95f579ad9d765d052578eafa2c68b13c9bc141f498f0741512ebf86faeb21ffc436f7342b94101b3b8e870a82312a91a870368f4b8a98b0464120cce60f1b23ad380d3bb4e8186c50302e9ceb61ee79d6b64f1842791fdaa3cbee90d033d8d94b9a24b3dac6e97a44882f45e46e8cca1da93c7dcc6cc27735377665f3f95b07659d6680fcaa9256530151f02d975730ab0d321e52c954255b2dfc3b63f30a77a870fb1a6fc479f57a8b774c2c69cbaeeacff4fa6607ecb6f17dee4c67066655722eb4a2f3a8d094d973c6fd3463fcbb08178cc448de6478582c462573fba0546513437b82a6c0918f615f803f093be0291073bffab16ffdd023421af0b8b1df60a7928ca8f0434063f8d4a0e9eeba9570facd4447c2a16407b8495b71645cd9ccca6aac12d68f3f73d4108ba12be864fdc5d841298beea1acee00267f2270cf2cd724935f9b3e432ac2e9ad5c90ffd58d4d0037e7ded0daf7633a0d5f4c2a38e1eea72ddf098a9342378aafcef8a14806e534122a418593de24506982d87ddaf3f927039d17c68b91f9c1d914347a59b489ca9156e146eca9c41fcb996a35a203c2c8dcac5a8208e5896dde0784ea1f1cc5f8697da6cce36c60549c5563c3181053c677d89f48867ac2b7119fac575fdd7487fad01eff72332509c776aa99863724c746ad6f23e0cdf537e3dee714735a3900ee97dbde593a6a8df6eda5d0cd19af76222b18f63f562d19ee04beeeeba4a39615006fa09808a63588c447c1867a4c208198b3590bed1bdb25b32dd3d3dcf18ec47e4a1623c57239adbd32a422223c23b69d05f65626d72c8c815cec421e793810f1cac583b1cecbcd66671d3fe7e24ec429994c83225270c2d15443c6e781957dd6db2f143690d4cfe45d0cedcf2fde79c907bfa3f0be1f5bf6fc3aaf56a66a40b8a122a34fe476638d8f28718f18b5ea9a644c36bd8d014fae2fe67e744c25da5c5680d4261c9aae2411705349cc7162d98e6415bcd416446c05a949c024bdc625632791a0d5993cccd25fc8533c99349d6df0eeca1f50c310b500d8eab37d94ebf6836f81360bcbf5b7ac412a4ffd357ba8e4f1181d5f7294d2d32600276b4799c998ed1060419fb05805091f65252f678216985f4cbc44e7643bd11e606334ed360b8aac120f9847500ab58ea59c43464a5854efe4f40ca108e235888283c75d31cb5050522295157bb8283e571936a40eed5ae563fc2412c5f9fe8b72bae1158ffc34900e8085a95efff3a7420597c6c778235d8247dd04c04783abf0bc110a3126ddbd388ccde37b0c50d0912b4a8d20f25e7c1ae4c63229efa64797a6cfed15926213e70d45e27406c3ab32a60b554cf5736aa09ed375dc6bb474898758fa714de30f29cd2b1b4c06171ef3cdb3d016c8156af686b8062554fc06cf94057df9e597cb40816e2c4f29a5f5e8117c8201aa1a12b3808c3ce0cb94326b8669a33a074fb94b5816a3ab37a8c48856700ffd063e2af0edb94c0af411d828f68c6fa553f9796ef6dc082234b135c78714741befaba394b1b3269f96e11fa32d7f2d36c1a047845cc3b9248d5534084d90be7fe38a51efa77015c82c4a6010f92298e5b5cb60651ea0700bdd662a57d9959fe5b5a20defb409b713f5be3d392c6a1611716c13f5c88f0d7afa78bae8dcd7252c7868bc7b14ccb3934a4f481cb95e97c2b9ce515b184640dbdda73dea9c7695ecc053940184742ae1d17aeef303ac32fbd9572b7b15bed530d533a7a3c5c900e452a436c2642020b4cc549ab63c6161167241e0d2fe08455be73b87c3ce53ccef8a916692d0bf50323e9570776de972c2294049e524a6e060b15e9eaf538519a09fcbca8deb6df8ce7f2581f4caafe3a5ea8905ff8fcd49b0173142ac090971e7abbe8b9ea4800a73b663184a05ade9c92e14d60a9894e3ed10689f6e1b4433c13fcdbdc5097f531af32895b686ef9d3e384247ab0bd5f4bd348c9e1d67aa9d5156dcbc5ec20562884af030f72ed9012abe266a35526cdf8cae2bafdc9dc6244918e6f74ad164ee0b156dcc9f8af06f782f9ea215298f630bb4a7735b06fc5a0dd20a6d8e86f2ef362aeb256aea5fa9200f0a12ecf42999a64d939dbcf62fe48924813f1ae185787b586e458d5f44adcd0c5b452bf496448ee32eb5fb245a3236d292971caf07d8f218e7444eef1ed2572617a8ac1f2d68d80752baa1098a10db9910e1735d1c48c142878a0e9356866fdae5710fc4481215c6154c384785c0a7e01fc377ae2da851e9d5c53dca9a6a771c022333dab412245ac2152c638ecda1f364116c22d4f57d32c963f1760cb16a120646f02c23d6f6d3c93c459aadf3e27eac09d9562276b7dc9109048e9ca95214be57c36c2961664a816252374fed6c79d5db072ff24de89736a6e5335e7d53a96c07dfc112f6c30e7c1959fc66387347193a8cd1dfa8936b7347609fe3a54d76a7ffd99dbfc56842a44ac3ada8f97a6be7a2b5dd871bfffb29223ede7ba75554db2bacd7e66e89bebcbfca715e458a8b876174973912759fc08e243e266fabbd63636c30313c00c6a0cb5b0f064ef738086e0c95ae7dad8e101635e6f8d2f1b6117fb41e4940544e5044ba142e32306cffabeae10a1c86eef20d3179bc5c3ef7104f153ffb93872db479bbffb4fee830724ca74ad298b91bd1aad8c57cbabd79b7bccdc8d0f0e160b4aa8b0c65afea9af52be78be5c38fce4c1d221b1edc7c854a238030985b38e620e79399bb32fc4ef21ff82ba54aaf6ccf5789d5ef9652e533e828f27fbe3d467f3ddc491727e0bb8c4a82822b0aa07ea2160ba419b68c2dd873a45053a82fb3c064ea6384e3329824682b5577c83dae5add6eeae044fcd2af724d1ca3ce55b37db496e5444ecda309bf2f2617643c95583a9bcaa002b2fcc14c53838f4ad5c1c48b6f23836e79b4de346ce9e5f6cb94c5999744f9f3f2d9a5bc5028e00cb3d91ea7327433ac930e094b2d8d4b36d1f03b227234364be89d07676d92f1b418df195246a7d3b1d74c0cb5bd62ce41778616f2d6da2f750cf7d03f9e3dc36c189c14048f7dece9b7ed2128d56722e50bf0be8ccd1b89cad18e6f70a40f52b989882868d96496ee4fdac5a5d80b99081db487648223bcbb6926aae8b2c5349f2aead9dddd198268c80f4e660aedf3c36ec33d1f8880adaf2962848b5e65c4ed107e6e2a5b7aab45d7f8ebfd69022d9f34a4679dbe2df311e1d68242fe2402d1d8e7854af035b4280a137b41b04ce0159ec875ad48ea1ccc8dbabbf799f8f303c9f8931afd2e42ae4c75966695e9ec0b87b95cc29de55f0f9973cd6a8a119b535b013f94d657cb3cfc0a25abb221869d328b25328d0f451bec8d3f52b8a2b9dce47bd697253b228413be004fa5c875ca8110e5a2631cf927d34a0a8d33a7f76aac2777caf98407bf8a74b5e60946e64ad02a52a4cd87215d9f4e168f4102db0725c372ad3bf489025929f2b5834a7872fe1fc94c8582f2380e76d27659fdbbc129c51b81530819a2c298bd89222d32ef62da81dbe7fad41870bcd81b22a99da79e9d9b03adb43f22f905b93e9c93564dbc71174daa7746c4908b24b1ded12a9ebc41a750588fd3bf8a0b9d7d612fffc1574717fca09022bdd7d8b3e0cf5f638067c87757949e585e25d57c96a01673131d9d1934ce9e269543e5db1e4f89e7ef711359d193fc51465692c83ac99cdde227bf107b815f49410acd26a997d7e7da35d2e22387799b76092a4e932c616c9add2162bea3cce52db92df98530d3a4dec3ac38b8d2882b9a41670036b25af2971670ba03e2d96eccc18f668325790492615dd7373fdd96c6d359df161a48ea2c61eae4ea6692b49e21ae230dd7dfbd46eaf82114ac2052df829dcd4221ee4e9ade54311ac6f07260031932be993aa71d8906d318220c0f6ee6b1af267686620b61cb8a8f15b15c09337e4512223989ca604cf01b6a290a2963a3b275dac15b7b818ccb653554d505c2a7e0637363898c6bc11b2acbd009db30ff31c53575a355d6d6edc9da592019efa24c83d92b373facbcdee51f4d74df5477a00b3941311110861cbd673ac4447d8aa649c60df1dd1a6bf712e8b9e38d5d883bedf9117f8a8a2903b5aa5948fc0e2d3f0eb8824cb06bae65c3c50f0902c4753ef72359f93f289fe6d9895a1a4e91ecf50e55e04f5f965437d187a9bc41be75b19263b074cb6761c93f48b2ef9ea5e15934a654e4276a578c7439929ded11d6236ebc16698c6c574cfe64f564b57952cdbf5408a6fcc2c9ebdf23d4d370fdf8ab710b2a0263dd5ffc43c79a5230467871c2968245e72944be83be76c63913b8f036b2e5731f1f0e2670f167cdf038addbfe93d354d516a6cf58808289eed1558296de255c8e7712b7863e99887815c36ee12fd957b7dfe14895a25d0d1e16fbf9eb3b25d0f7d8def6d10c8eca33243da0e0e84ffe0cd5d4d9d255406ebe6829f2304dbacd6190785a33b14c29349933f686192f85b9b23da8764d77f04777778f86fba47d746f521efe5311fb2d2d7b836475ffcff5a706a932a9c2e990e97b6ce33ca15369048937972664a708ca99c71f7787d8baa371b232c381b0691794640c4983c370994d89ad326faca831b8ccdcfd110384d4d186577dc794826b0bc61cbdd6591dcb2c08ba876a4cf4d8447789b62333a617818fce283e81cb78f9f9420da20ac9d28babd176bc0c93d7f1d916d18fa2ddd8895e4882531e5a6b1fac3f72a44cbd8d1a8eca17e8afd8623b219fe24bcdbeddcc2b85bbf64124bb690afa30f8cd1fce6ed5a83769a34b7bda79b02213123e5aef283846ae347f616ca7dc688a46d4e49b2a259e7bc06c596ba18ef6a36e4a9a2bd98aae7821e6d377a1449dce9806ac5b447edc9b4b373d8a60038a4e37ac59339c9beaf2bec018fb2ff3050b9e771ff91fb170b4eb94ca11f915c6e5c8d027dca7b99d7623d9972f3602c4338cf2940d067c3c1253b650589044b15f999b230871c9d09ed0f975f81f72c2079960a94d4cccc4b59c107b5d9ebc31d5f7cf54392ef92e11c3320408bbfd76b5d97e3e60de53e49bcba4dad4400ff67e2c645b0ace495548fb721434e29e82bdae19f8b1e73d14ccdacdaca926a6756feda6a0cb274ab616d6cb921a8f98e17b72c6c88cea1595777fc137c8046afab8bb77ef39b65d4f801348ee6bf7856e663475c2b1d2068214737fc146d222fcae9744bafa36f00d0d7512f286c119f2085b3d99c801bc55760943e608765261970b662d7308ed717b95bf6c2b8910a89b1d18870e0bfb893a230815f130c349c01b1131e28347a36264998d599ef43566f453f52c2168c5a8457d0c3bac33647c98b6f1ecee1cafb9baeb8882ffddd2cb0cf6ebccf2c02317fe69eaf761dbc8164945c77b060073d2415b41c70faf9b845d65e5115f535c6cca4b759a89c22c12caf46ae5273bb71f4e971e2be279e35f6bdd49e791d13764f07e7296a4edd90c76820bcfa175e4cf266af22b78d4b9935e79711336e584534676e78564f76e249657ae647fc579120ba0f2e1c10e4d9770d223fceb4c6ccf003d59b08536907a3a77b63ef39e01b146e2223c62105399d0bd72922fe33303eab9ca4db46ccfafba3ac7471ef9bcb9abd55398d8296459eec0a632dfea992dea89ce5b826b617ea3566383dc6e3f198b6b7982092d10a7524f62c2403ba556e9ad6f99745a6cbfd7c2e143768195eff7a60945b6efceab819a2ea6979aec73ee47b3c8ecd0348c5e167a64fbdea3390e4a8ea91bb7770e612d30606bb44c1cc4c65cb90b063a78e6ce581f9f5a3a33ba031963cbf3604198005ea2cff7431da395034bbb7d9c4055c54a87e7ffe8ece1417b37571704140c15192a6a181e678f5455c1bdd0920019ab1d98355c0a8f91d09075970884147952fa892fe891fdce3ea64f3f734d52b76f10af28b65004e45e147ee076574e2fa17713fa484af66a82f84ad531739d9cb57c07a4e3a4fd58ebfbc5a6ec45b5ae454d0b9dc45c917e4194ac987b34a804c72cd2c17c82b199638249b4701db1b867f6ac04c886b554a0c9565b67457ac040978f7bc5d40607565d51f3137ddc64ac86ca9be3d057bff2447293f29f382652ecf1c0b7e7247f175bf9d30b92ae95a4e72c20f5406b2e4341bd67b027a5fc5618117e3505e2516cca497c21a61fb9327eeaa6c11bf21265d1400927c85f63a99a8221223f367798f821a7dc5d655eb6e6186ab1e91bf6ee9a485bacf6b3441f9267390d322efef4557ba0edbd8ae0a8441d942e451f4d00f1b6fa3de5fa2f4f85776f003e24d0b789b387877ffce82c3da8f007c7167c5d9899e93f2c2812138d1f1392ab7ef87e8f65e9037bf1518509473f3ebcdf62d7ceb2449d5237528a8937074b0145f7494fba037f4f24ed93cc9993e8c8078c713c21895a1d395b05f4f1c9fa9af76156321ef6de4e91eb14c5657a517a441f5dc4535fabf96367b8e989ece30b781f3eeea8b8904d3264cc6ba48fc395ab944b7bde9f9637cf95e2af87d361a5ca8ac8fcd8f733bbe3add584375b7253b3da23dca9a8eaddcd532a8191d0ae1d8a47d857599aebeeaf78d8a83fcfc477f2fc54debc7d2209582e73f71d1ac04c6947def7859475c57dfb083f63967895f5c6863334c3d92f49d636aa9e7ed605d78c42c7179f6e32da93ff89e50138d3c094d10c76cbfc64d1ba90c3d8ff4bbaa82847f13a9cc294425dde809c8dd188c8281b18898cb3166ff992ce897975363d48dfef9760a73a21aa281f15112a3e1c157df6f7f0e3c20f3e3266526767c2072936a85527a80a41c23853af61b28f24a0b4d523a5a9a5d731344ec30d121571235fce6dbd9e6e75ccbc7274142572e733496f91b999f6352480a9fe3eeb4930e9a4510e5aca3353e91f4e748e6d42f62841ce933bbb9e65c71c434183b05dc257844127614d3f04f48dc9673224e6f322677f265ae40fba0cf27ca5119d75e3f854d2af1e2831934070c420f4d6c70d6e9ecf9051a5b510df51d76e655fe9f2c7936e0152a494fdd9e7b71a651f08f476babc2f9cbe85a3dd384a8570fcc017526e2ab9cbcfc96956ddd18b444f629f825d1e90a484111b0ea8b3f81005a44749d2b27c07640cf6f05cdf14d580dd02b884370e0e3867c276ccf9114e6eb644cc3491b1d2f21dede34a98cc311bb90283df70a3f0efae51a076bea360c5631531e1fe76ca37a7b848dd3760e3844284d95d877120b615fc062106a9e474f6aa3036cb7042f45080ad24abe8fd928c7e33ef07b6da63f5d9c763ad1fc2e4674138ab06feef417a6953c7895e92523392483e6d9e32ca5b42b62d8afec26cd07281c195978ab3d8af4f9dfbb42ba4b88eb48ec9dd53d02449fa1a4ad7e4bfdfc57e322e1bfc7818bba2312ac3fff423396ea82104e4ec86f2e8739696d51f1286c3819f8fad1927dec18a4b9a984b2f2831411b1294347ec1713a71584691e0f3b1213fdcbb1cc9ea305f9f90368eab4038992029dccd947a05511559d5f2dc90957b2cf3e14929d272838efe234a34e47a65a15cd54f3ab71855a854f0a7d25253f98652544e2aca57f8cfe48e5f5dfcb0fbd2cb83a4d2ba838c635a06be47e4e84aed2a38f9ad3cd52c6bbc3072c5fe39a8b857b24dd1d941e01a07e140faa9cf2f15f77f00a759d9f10a656e6473747265616d0a656e646f626a0a31352030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e677468312031343536202f4c656e677468322036383634202f4c656e677468332030202f4c656e6774682037383439203e3e0a73747265616d0a789c8d750554145ad736a0a4d248c7504ac3d0dd21ddd292030cc20ccc0c0dd225dddd29dd0a5282842008289dd2dd8884f08d7aef7dbffbfeff5affbf66ad99b3f77ef63e7b9ff33c6798e9b57439656ca05620452804c109e4e21105c8a9ab2b0379013c3c7c5c3c3cbc38cccc7a608423e86f3f0ef333100c0e864244ff17420e06b244207df2960824501d0a01a8b83a02807c00a0a0285048948707c0cbc323f237100a1305c85bba816d00ea5c0015280404c76196833a7bc2c076f608e43e7f2f012cd6ac00a0888810c7ef74808c130806b6b68400d42d11f62027e48ed6968e005da8351884f0fc570916717b04c259949bdbdddd9dcbd209ce0585d949b27200dcc1087b800e080e82b9816c00bf460668583a81fe1a8d0b8719a0670f86ff09e8426d11ee96301000e970045b832070648a2bc4060403207707e82aab01349d41903f60b53f000ec05f8703007201ff29f757f6af4260c8ef644b6b6ba893b325c4130cb103d8821d41004d45352e840782036009b1f905b474844391f9966e9660474b2b24e077eb960045196d802572c2bfe6835bc3c0ce0838171cecf86b46ee5f6590c7ac00b191833a3981200838ceaffee4c1309035f2dc3db9ffbadc1710a83bc4fb6fcb160cb1b1fd35868dab33b73e04ece20a5296ff0b8374e1fcc76707420004788485f8840501201700c8c3da9efbd7067a9ecea0df41e02f3772065f6f67a833c0163906c8176c0b42fee078c32ddd400004cc15e4ebfdbf03ffb6708040800dd81a01b002d9812138ffa98e74836cffd8c8fb87813d00263c48fa01013cbf3effaccc900cb381421c3dff03ff7dc5dc7af2faaafa1aec7f8dfc4f505616ea01f0e6e403023879057800401e5e41801072e1fbef3a5a96e0bffae0f94fae32c4168accf8d32ff2a0feeed9ed2f12b0fca51056c0bf8b694091d4050158fec374531e011e6be417f0ff9befbf53fe6f34ff55e5ffc9f4ffee48d1d5d1f1779ce50fe0ff885b3a811d3dff4220a9eb8a40ca401d8a1403e4bfa106a03fda5507d9805d9dfe3baa8cb044ca41066287a43427909f8b87ff8f1f0c57047b806cb4c0086bfb3fb4f9e3d7ff2538473004a40585837f3d31c82c1e9eff8a215566fd02f98cc091dcfc13b284232587f87d91bf6c105254ffee4301620db5f9a53e5e014180250c66e98983bc7ca42500f00622656a03f2f8cd6e003717048a40a6009033fb026ca1309c5f172d2800e096f9e5fa630901b8e5feb1848501dc86ff582248cbea1f0b88cc033923d50a85007f3bffd595b52b0c866cfb379d902dff6dff7e2040200f9035cecc24d45a2cd8a13eb8ed47ad0c953be7fa8838fa61da0f435ece91a2e758885e8571f36f09bad959b3aae58a331f808acf1d3a35645d7ee42c4e9d7aaf35d0357af27fe7a453dcb2a3b38a9bbcfb8efa35d1fb829a6112ff2d4abe418a2cad6829ac17458b2692a00b5bcac6ae579719dfe7497dcf74a2fb63923245219590368d8eaedab22c35526a91677b2b3a8816ab01bd758133f227b92b4eb141ab51a611a91a190caae21d973809ee3504cbfd8303f3841f68de4706a8b805ae1f3185220815c406a8e5f9316b9ecd17e0dde496baed6610795b2911cb91eaaae7d3eb90e30cc81524b51c929bde30621a3a6445d827e2ec92e3b717646c16db43fd532ff904ba83845373bf3284d9bdf2b6115f50d4f1ef68990a1b1c27bb98415f1e5c737cd035fa8e258bd1c7beb2ecc4efe5908c6ea4435ab5b5312797411e689238ff03119bbb35cf838b162560aab8474e6fd1495a4788a83e787c26518ca9eb4d6d0fd5d61a4e5b7bc3a1f6b4e581d757d386061d409c2591e38bfe541c3bfd75699757a2231542efe022499849c949642b07b13edccf9ba51263edb173b21e608dc129c27f6cec9c08b9b821081eca7a6e2ead6d1a34ad8d8fe2da2eaf3d7a1052ef358a487dd931da331c63b2fb235db89548ef5c269cdfb6662380b825a768789c62903cf7644e35d24482298c5f015badb5e4f1cef5845dfac47a70f06321c1478f254f6e9baee45932b07d1384698c6cb60638f20d6e9265e1056f1866dbc6a4203322b58acf96825be82f1f8d1a367b6fd03fb7f3a9723b5b047a07b679f02510d67c48349777a66bbd2f5aa95a048ec9764741cbe8cf4de7b67a6a116d6b6dc990d33194cc6ffddc9d124b44a1090eb850c0d7df1dc59af18bae416bd7dd4b2d5155e0ee5a22d93e24524e15ebb6d15b9c4e112f34bb3df711ac5e57b804f6cd142a4b6bdeab07b32a97b4cb08ce45bc945af70bbc9d23171e4fa75623669b5e5ef7794b6df9015b7a01cc65fcf8902a617638aa104c65adcff98a79d46f42d887cf97deeca574b2984411a51dc2b95953666afa292544fa8471daa3a88216ae57e7e25151a21ee8828389d5d814b32d5cd1ba131c8f434e5482e39091662bd4a0c10e48a8c53d6dc3e3eba9488a695716d61de5889cdbc833867710a69129e86daa5fbdeb55d144894ddf718bd83ad2da9c95a74a0eea5526a2294e1d3d42d55f9811fefe80888ebda1cbcb3c9a799087db7e709dbafb7ade4167888421922019e4036cd2d114d467798639a19336fd749cf764a7509ea6e66ed6a19035f2fe04c9f540b5430907654e80f0da7af776dfb565218bb46f61bd53da3d40e9c8970efeb1ad12ac93115436ab98fb3623760825f2dcf7d7a7ebbd8b7676d9225897bc1363bc1178c1066f92ac9cd44738ee096731d770057ba693f82f8e49d57a4dd04a973011768b1bca25eccc079d00a8b5538a601a061d4a96292bb8141bca5b184ca3452c91ddfd0cd9a14465b5acb794b765b3e1e9b5a6f7cb31f58c5f9f26ac6ead52e55e77dc24b73d9e85da344bba4d54485748504c6b88f6ec331e892ddd9084634ecfdbccc4a6abfd58e9cec513c150750a18c676575aa5d8d3fb8ad55a964173a470a08441354859c53eaf947382cdb37c707a8ab3e08e069bb5a6132aaff1795d9736083aa0fbd84784ce5f29b7460df1d1648878e0f4f9d9d66066bdfcc359999f0e395783db58b4b8c785e79925f3226dd39d01b3c52f8edf191d1155b1dfc3c2689084c1a33fb0d82ecccfd7fb88e002eaec6dd8980565e65acc23baa0ccac55c64ae36499cbaf6ae5123fec3a3c18a1c4f6bdaa8053663aedcc05b05f4fb0ac421340f05459e3315843025f601d5d12ce832fd01c6249aca419bbcfe4762fb85f606974083cd53259e31936704e43505762faafeb8cb9dfb10b5abd3deca6eead3df61bfe98336c52c9f991b9d94cc27eb4b4fdb32a7d6d49a74d5964779aee92c148c38dcb9d4c68fd085f58223199fc3ed610b874dcfe46fe3bde9156c0b180334aa8a8d8e2c7888e5113f527a1ae64889c6bf55bed683fea1b2159baab899da8f6f6a6a35b2d6fcf7a2a2ea5b74da44ae664247a719fca0d4e3d3c187dfcbf10f53a744c4b825c8138856f337763f9addfea17d5669edaabf7b141fbcfe6b275b2baf7344ca445f3793715c829fd16197c84b682d1713b0ecc7aed4f0c617cda716a92b27765ccb2d7f28276d9f3862fde656cdb17b3b5ea8135c31da627e6e3f33e646b80c4ea57ca89c8d2fc50cc47ea43cb131759e3320f48362e5e9a11b5355f3e2d08ded23c5a9b56e4dfa9606e3929c1f8b1741f1d22ad915c527161da5ca6db63dfdf616d39b7feb462e7fdaa905de0cfe33ef3d0bd8d663722e0d3b506bd9344fb4c3b48de5dd35ec1482b0df342f00b0d30c778c80b02a0e0c9578b090594add339c9ac9aae59cfcb7792630ff560f7f0f9f01f59e43099f69217c74e0ef6d59d35a9ece185f8a2050ddae1bbac604a3ffb6095bdf24a19cacaf1ad567935c7fb0adb489a5792ae3240de3d2c1dd2483754771d7f6e6d246c2e11affc846d61d12e61effb42aa718b694b70db27c4f6476ac53efadec1d5148cfb64147333822ac2657e630d6714ee13c94e148c01732a0829af09cfe139a90250eec9ceed64b308c3ca0fe787618c3f14563c75bce874a6ba8596c812a9cecb3ca33992f849d7bbb183fa0cf80f4767451d5e6b25781867c772517f4eb8945d7953dbe5d4892d07d7e945f55d32de0ebbb0262bcd8f20a45ad46f4b3bbe9e94262d214a7f8da1e8f88dfbcc29e521891aaec01c56532773cf4849e223f1b3e55d07a5943b3555b5fa4bb7b33923dfe84f0dfe558ad70a14c393464613d8a71f9e71f880476ed7be04f6ebcd02f3fc292df5addd2a99ee7df2083a74d948e0dab7a0ab558eeed14fbbde082168c56049300c32317629f65955132de94f68a9ca7efbc4bb24582f324959f5070bbea647026eb89da044a62b3607c666e1d58cff9e93b60e8f74df8ab4959e2a55ad637aeb46c8d0e4ebe41b2acf7368831daae85195c2a13dcf64edb20214ffd53ec7aed047fa42f356d66a9e19c75937067dde98073b42cbb75641045ce7a22f4f5939d56dba61579b7138efed4ac74fd0269f3f0636af17c9137b92a95d7f61277d05392966bb2f906bba848dc83fa0574d3c279e0ccede2ccae58867ee283f02376a8e51b3c6febce5c8979601b54bcbebba0a0d187f2e8f1aeba37f648688a03d6ced99d496ae6b0be7ac33b570442d14dd085965b22af9de887344eb83aa65f25e5b7496f2a89d7b951bd74086a2bf4e20b62cb827a746945f43f1798f82d134f157f8385888e2f95acc847e11ad5974c981ffd72846b221dea6265d97be588ead17edb17d1355ddcfd776cfe589ad6e548b04721799c6d372accb7832b72824cfedf3d03af2e0419db80c2df9d0a876fa9bcddb0f3358348486605bf941cd64f466860041bd22a9ef2565688698dad23aef1d5dad5055ef3f1c15229068fd88e93d8ee6fa680d77561beb7cc48c28265cce71188761d2b7aa5048756227039019ca926e32e1971ac6b4a89f1eaaa942718e3b498b3be8baf7d303b1e1450407b53d0ae8ce376a52a4d1c43faa42642a48da882ecf2f26c4f7b161daeae4258bab5009122a9657d7371d5f5d4d11440d533e6472fbc92fc08ba9eafbee80fd3c2978dda32caf897d70566692207ba5080563fa6ca624c9e1bec64f67bc4045469d9e964faa3c83145bd625183207676b4f492d67bdc088c3542d6b03659296a9b69144547bd99121fbfeeec06a22d2a73fbc07c4de0e91e52baabff20771b85f1fd61a4b795ca1118b6c0dfffcc1a2f6a58e20f93ea1a5f6139c134316aee89da4479077e3f092e5fe8f62106a685df551bd9c765048b47b6af1c3aeda562abf856fee1f8b9523388cd7c8bb3bd71108308f041944d47074ab82c1ca4c35c7a966687c7936e2704cfe6a66bdcea310f2797aebc0d9b4291038068724f574da03e913dca8f28a16b7058ab8e2abe2d8d6130b8f4dfbf7d13dbe00b3e64dbbf1bc768be814bee389f8721f1e8607e30e44c20274c02149b5f75d3fec7c9055d219a423ed1c9b2a266f24d3dbab84f9df3a8c1d9ef77e369af2de339e8d41d9f2c288a10b107d328f915972513553e1e04ce583f723ba804a9a5a9f9140c4a8a7ffb5149bc611d8f74db92f1f33e8d32dc9ccb07f9525e3e34b7205c6120b6187c7dd8bc7b4c6059141523a461f0932ef04b387b6186b638ebf6f731c734b16294de19a5d100ad485b78a598c2f7b1298129d8b6c8926946f779f1c96307d1ae6241c919e388d4960826d1d5ed5ad7c4a4b2b9f3f39d4dfeb3f1e032f575fb3c0faa20f72d56fa267368ade9632ad9e45c9e92cfd9c29af8463c1cd941fa70faab0efdd99053c6de1bacdeafff29a8d2fb0a1dd7664ce826ab76b51962a3f3c4e719fd96f9678024779eafce71bcb3e20ab144e9982f7daf6f42286ed298b23ad6724ef998a7cea89d3bbf1599e8359513b9e0147fead2e7598ba0cdc35ce42fce1f3ea721adbeafac178e2e8399da7d4f3d2e126fecd66668d1ecfd88242cb3ee176dfdf67087d851bb4207aac241844ab3dbc7cebde3561c0fb05df5802a701e49d699db5585650ea7573a1a3d15448646f411288ea4395b0c8fbe0024d2daca8fc4ccd5d938adcbdeb6d48e60f6783f1dc608b06e2d0e860611801ee0b5f4c0b4e8df23347c99be1c862aa38f44dd2999438fbd978159e628d11cdacbade4ff75099cd5182423edc26612916bc5cbc70988e5f7f7e44a04176b20ea8a0b5bd725fb59f4ce2cd4667e2d7b23ea8bd56f658c9c220b5bf89566183e0a0efc8e89a25db07b78f2ff299d7562c6795f6ee24c608b85f1225cb797d9cacf4db10a573b9559c1d33da6663a28bfa396f77e7d01c520c51ad55a64ade33336800f5939de796063052d30f35a5b23324aef93bfad90b556f84e25d1d0a3c3fa02f465d90d31f6fc1ae3447ef6648a09a46b872bb5bad0ba9657e5b74f82cc01630ec3e38d3c452e825433b9cdc663ca2907fd6ebd16b49f9648d56fe64ebad9af55a594b8081f3926f39c1f34e99d6a92f01574739190d25143a9269d8fb70c42e6dbb75d71732b6bab7b69e5f5fcb161705f763c96caf0bc7f1c99830a4d8392475dafb53ccd87d984d2d5a1d3df728b00c1386e0f911ee152f84080a5538060455271c61625cb27082b9bf9913dac0704496fa075639d705f79cb8144c967c02e2133f12eb067bb4da3709bcd3bba11a6ec36a23bbe5cf1a17ffa615dbf0e0d1237b0ffadbb1aa571e2fa57e326829916866a328f8787ac5a98ecae65ca7dcd7de674a8dd19d5ef62ed93be915097d4c58be1c512a29a8fc36ef82f56e5bcbe16a2e67f710432742b685355096719a7a76f43d1e74325ce2f9cf259aec634b20ee217e89d24660565a2581f69303bc85572a84e0521bb872731a9e9d5535e5eb410f5bea4b42c9230437e57741b1888ffa7a2811f94efa9c33c32cf7c61cefa4bf925286e68487e4bc576f30a2ea2b1cef4fc609a6b937d1a7fc6ee3fc24275ab7867637c9c48f4578f5c5e3b456798e0b8c4bb05556504010d8152c8965910b4d73d99e677a1dcb5cd17946101d7e4b108f4b6db7236c3deb3008ccaaeb4f35df439f9013364da9d5072895a6d63475fbd4f2668b2bbabcfa02e2137d0fb43e4159c76831302b7ff8bcea685bd9bf7413b56cef53dd3ce9e9b60fd62595259ca4ec81d3f84b787795e03e0d8aa63d7f7737498ee36927705ab5a1797180ef70a5bd1cb76b741fa7b0e1b564b7387a98c7ee8c01e754d82e23736da5ea764915454d05762926f889dba19ece80acb7f77b94522de76f5853ead2212f7a70aff43b8ec58fdc0abe1fdef3bc3a4044c5e4ec794dbec6e47acc49cb9e36c78cff554910cc9ab73fc7185280c260e90c3518af0c5b66544b3408c5a20d3c8d513ee1aee93b772f39cc78f7d822645630f3aa8fcc373c52441b4e253e63aaa470161566b8addf6b8476d2f611781d4f1e2bfa7e816658a3ae2ab46ab776ea2c450b536771a3359283969fd801a1ceae62b544d5be2b34ba6c37a168c7a4bb66ebe89a2a8f3e5ade78c4958e37d1819231ed1ffeee95b52f2a098afb85e8e9bd8dae7aa593ca62e689764e5a317eed1dfdd18742d86dab449c5aa617b74b3da3f5f0cda92713f262dfbe9c648043eb5ccb376113283f392f18838219e96ddb4f3108a29751be4f95edb7dd9b3b2c17c631f9fc192b4c9a783cd091308a82c5cce1fe824b3161cf1ee51d2440815cfa63089a94906d57c2974dd3d8bee36442943b6676a2ecbc9a65928c0494b0198570d01b546f3c57007f06ada18e05c609f7d603e19cfe06f6948989d9e5d2e6819d390ec326f5b587552d1d74fe943563be6cec5620f9797f9e6f11f58cfb6e5f2bef28058ebddf1189ebcc183c1fa15a6bc7c8043dbb7f56e24e8bea4b3aad0f88ea6e06650a28a4d87ca9fd49df2212d8fed98042fa45684a9df3941feb5eda06cbca4b1a4f862febc5d39459473e7df08eeec2e2720e83c68e35832474e3e8378aabef08ed1d9984a0843ea8cd3d3145c16b5acfebca8222670d4dd9659fe441dcfb187ca5c539fd67c8c17e1c3be5ebd5f73d421b65528ef8fa6d5865e6950abbf2adf7beb4fb1e6c1874aa73ce75aa6c6778d798c97c2a0a75cf2d1813f7af485d51b0be4738537bf3054868f6a844802f21e5f9ddc63b600ed1f29dc15eb2c996f2780063b84cf1b62c3a72767d8c05cea7d186033aa79bd1657e5b713140c0570c7cc71bbbbb4c75cbd70647574a3d6f07e4a5a3280ceef00ac56b3038e60dd82897a11b5d62530ab5b12302783487b03ad497299f646d4b328cce85621f7ed5678042f7f201a2fa815a7d63a47b3d9784ca66b552c42e424c170c497d7bf4f5c9779f6d7f5c5016b62d7c0de45ae54d484791dace6e30dc4f857516a756a763a0196909bf3339dbba797234abac1e5c1451b2e2b4798f99ac33699390c153fed6dcf6eb2dbbe7364d63912b8d4473deedd602dab94487a16fc5855a84cdabe549ef34ef2e17c9be96cfda151b638ccc660126bb1c4ea6f08d1cd7202f175f6e8f49c1d114a6be42725a022cc60e358664e021cd2b4fdb2a357c532fbe582a30c5761ef937c38945a7f1333eed90d83abe542bfa01939b69c3bbfddcbcbda4c06e9a03f2217d94786f0cab6a670f4e16b6bea7f4cf2ee6036c9ae99bfdc56cf8f3b44b668d99fd075f2749fcb47624285b9813d2c8793bb070878f58f67b4f79236e85fae83a9e15b4975975f99a1e2fef7e688a7433586ee7c54b9361887e3aeea3be7ca674e2b75038a94fe371658711f70022b2638ffbe4adb979a104d9339fb802a6d67a0dd12f44bb476f34236a366fc2f0dcda2fbfddea0e2e5278539fce7142a658a33b5a0a92d752fa7c3a53664f2c62023556884bd8e3931992dbdcde8bbd349e2f7dac859d55294faf4b1d1493aec9338e3f04ebc5f0c3b6612f58f01da1229f5c0c78371def92271c285a7e0a1de56dd4d3154d1354b359564cb88d7dd1fa79315f8591fce0c8346a0dd567f172842db8e96355be442968e1a6c4a63b2c654b413d87236bb2888c969c35605fc4c6cb7dd5857ff61e965dfef234808a4bc4966d60ec6790bd9baf083a0b85923fa9660543fb58a4f01546a590f36541d9558ad3bd9b91b0ca6d61b1a6a56217e3155e9bbb10c2463410964fd3f1e995587f34e5c176b6923a4af7c83eb67af5339170586c9eb2eddd73b70490de6713b500b1fec12106e1783ddb0c38f84c7bedfe6b06e43f1c81bdd76e4403da33562cee6710f8879e5e94a70fdec776c925e27e16998e976ae023e600c5a7192417bedca9510fde85399a662d156a0876bcb5b090d937ef7f746fe7953a621ec193f50a569b3b04c147c5322e587d6950cf2c65cdbdedb150f31cc7b99b585b7582b7464d8a3d7151a2189ba8124aec208192bb1bda226b227957373d2f565af5d4a039ac1b20c4d91ea056359853189b986d8e12fa4d2a8aef2387903e99efe81a6d91e716aa9c8a343521699561d005a13c89cb7e2a20ae9435cccb79f55b814e435cdd3e48a7b501b7f1ec188ccd6b487cc580f3a95f4b8a0c50acfd8430e69cd97c0f24bcdbfec0bbb64b3b444c075d63eedcb12ebe62f19b48bd6d8b958662985600e8da28fe47244daac473ce484e2b91d8f73aefd7e858b857cf95de79e081143cb9391ec63d33c5319ac35dfabadf292d7fb4f26db38e600db7c47becbeefa62d99c6777a938107aae9c98119ae035c5f43c557fd352feeaed163e76b4dbcd8a4d80e89cf3cd13fe56e4b3cfa6e13422677c084991c870129c1e06bb99951b5a099190abb781667a76f3592f4da73b4fe9ba69bacda5b7ec7f28f01644f0fcc4e713ae1e53b9df29bb727e6c4b1fa4fef6c6fe8d3ecc7168e49cd76a72dc814615714e3a6d78a21417efd3fbfc39f4cb34b33f2bc66d97928c307c528ec97327dac314b7a423ad9b74ad99a03ca5bc50f63b2bfa1987262995f1e8d4117eec01d7aca708f00a84b27db13c3d4616ca43579b5cfc04eeea233c45f0856b2e15ff27fe21b6ba5c06cb05c72ab878300f5879e9ccd56ce482b2edddaa154f7c7e3cb7c666ea416d040bd3ece2133f324512c2d27f70a6f7b342e008a32a84f0072f375eb626bba75f9faf92bc9a8bc7866e4541f4d893ad1a6651328ed9b2586ef031d5b0cee1b16ff8a65f52857fa41321ec3fa5526ffccb9c4d59126fbfdaf9fb0a631d042462647c5752e13a43c4dd682590409dbd1be4f112ced966251d8c1606286b832f8eab26c9285ae8a387d5588c78481e350cede08d0d46ca49872fefc2d94e1f5686e4eda1a1664fd30505edfd5a480dba9fa3242c6e22e51dc1c52449e9e0f2bcc7c705e53fcace4bdcac34b4f0d0b26b54a9a37122f103cc72eab55772d5417d9c518aa09041615362a32a1d1f2d5ecee7eae56bdc31891c7ec0998fbc681b3b3e826c50e0cc429034feea1474c628d5e28d6772e4c0f296a0f05e682d428d3a3e7d48b0d0bf48c27c6f8624778253e457f9a96119496555e883f4c1026c214d9f1cb34ec7573e0b56211509c610f47597f69f3737596c42d05d53a46454a13e3e441c4a812ee232f3f485bfbdbc6e8122f523efd0c7e09f9b5b947883e2bb010ee76dcee5578635db009f102912f6669ff9e85487390496ca08a70359aa848ea7a4c156538dd93bcf47468f9264d16679b6d6f22f6ab31dd20cfdcb81f50c12ac10cda8e08b412c062e0fdc804c2b7089ba90e49b4d22f6b318fcddee87cdfd00a6fe8a0dc491e91df539e2071904fd3edc770b889e288daa8b7fb41c6a3ca78f8c36192bf028f764896d139fdab3c90a35357396fdc254f5d3a6a86fd9eea42231700b66c1f5f5e39ebf191b676fce1c545e717954783a719c7dfdf9c5ccb35763532035cf5cc73af64579da0d46f643be113a82619335a24dc8af8148db7ee6bd4f55f2b8d7f8a4809db8805553fe05ca62a7bdcd3f20420172b0b69c73f31111c39fe598996a3c7160572387feacdaac22813d07890779a00ec0d528bea168ec5976a18bc8db2775bc8d4ec5e2ee8ed0bd94c3690621e53aa1eb0a76d5df2f81f287f4fed0a656e6473747265616d0a656e646f626a0a31362030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e677468312032313135202f4c656e67746832203134333031202f4c656e677468332030202f4c656e677468203135353934203e3e0a73747265616d0a789c8db705509c59d72d8cbbbbd3b8bbbb7b70876081c6dd35b8bbbb437087e0eeeeee0e092e4103979979bf9979bfffafbab7a86a7a6d5967eff5ec7dba9b8244499541c4c4ee0b50d2ced69981859199172026afc2c20a6066666364666685a3a050b370b606fec70c47a1017474b2b0b3e5fd57809823d0c8f9c3266ee4fc11276f670b9075b106b0b00158387959b878999901accccc3cff1368e7c80b103772b53001c8330264ed6c814e70146276f61e8e1666e6ce1fc7fccf5b00b5310d808587878bfecf7480880dd0d1c2d8c816206fe46c0eb4f938d1d8c81aa06a676c0174f6f82f0a6a7e7367677b5e262637373746231b27463b4733411a7a809b85b3394005e8047474059a00fe6818a0606403fcab3346380a809ab985d35f76553b536737234720e0c3606d610cb475fac870b135013a023e0e07a8ca7c0228da036dff0afef457003de03fda00581859fea6fb4ff61f4416b67f261b191bdbd9d81bd97a58d89a014c2dac810045c94f8cceeecef400235b933f028dac9dec3ef28d5c8d2cac8dbe7c04fc59b9114052441960f4d1e07fda733276b4b077766274b2b0fea345a63f683e5496b03511b3b3b101da3a3bc1fd519fb88523d0f843760fa6bf9eac95ad9d9badd77f80a985ad89e91f4d98b8d833a9db5a38b80065c4ff13f26182fbc7660674067030333373f1b003800e00a0bbb139d31ff46a1ef6c03f9d2c7f983f3af0f1b2b7b307987e3401f4b130057efc83f372327205029c1d5d803e5eff76fc37826361019858183b03be00cd2c6ce1fe61ff30034dffc21f0fdfd1c21da0cbfc317b2c00e63ffefe7ea7f7315e2676b6d61eff84fff97c99b42564641535e9feeaf86f9fa8a89d3bc08b818d1dc0c0cac102e0e1e606707130037cfe9b45c9c8e23f5530ff932a636b6a07e0f9abd80f95fea760d7ff3c7feaffec060de0bfb914ec3e861608a0fe67c63f3373301b7fbcb0fc3f4ffa9f29ff7f03fe07cbff6dc6ff7741922ed6d67fbaa9fff4ff7fdc463616d61eff09f8985917e78ff997b7fbd802dbff1daa09fc6b67e58126162e36ffdb2be36cf4b10722b666d67fcb68e12469e10e3451b2703636ff6b58feb2abffb164d616b640253b278b3f6e1500030b33f3fff27d6c96b1d5c7cde1f431917fba801f8bf3df474ad81adb99fcb161ac1c9c00234747230f38e68f4162e5e00078b17caca209d0fdcf19063031dada397fa4003edaf30198da39c2fdf1443939004c227f98fe425c0026b1bf1117338049f21fc4066092f9077d44caff8378004c8a7f23ee8f3ca57f102b8049e51fc40e6052fb1bf17cb018fd83b8014c5ffe411f9cc67f238e0f9fb19df5874cff63f9432d26937f41160013f06fc8f651ed47dbd64636ff8af8a8c4f41ff85189a9a9c53f277c64985ab8fe43c1f147b89d8be3bf083e42ccfe053f18ccff86ec1f4a9a7bd89b03ff5de287cde25f9013c064f92ff8d1bdd5bfe0478bd6ff821ffdffab78968f6effc5fc718530d9fd73f647ecc727ccbfdc1fb5dbffe3fec8b5ffb8e56dad81a6ceff5859fe63fd6b45ff367f1469ffb19876ff68cbf9d1f7c7e5e8f4e798fead30fb1f463b67a0c917ebff6660f943da7fc9c6f2a182d3bfe0c701ff047f5c094ccee68ec07fe9fe51adb39bddbf123e7472f917fcd0c9f51fc8fa11eefe2ff8c1e7f12ff82184e73fbd7da47a021dffe2feaf3d327671fc50c2f9cf9bee63c9fe07fff9b10504ba038de15697ec8cf9822ceb833a1e6b45f0dd180ea704e6290e35d36818bc561d3b5d9e91a093696ab202b61d7f89248ff6a16cec4b50df0baf11fff6fad9da081dda96a8dcfee2fd6a10af327bd80eb7328335345df453a46190109680414df8c8fbb783b786bf15782b68b72c459e830b37925201faa3db80947bc360f9fa44c8d2a1f2510da71cfc6bf91c43b47ad467ff92058afc2fd98b38a450ce0c8430b46857eec80bf7bfe6d172a7df8965e3e9e07ccea2d98abd747658639e163d372bd5589d7a70c971757008c1efd1266629bd444f5264b197bd4a8bb71d275217b13a27776d9258ac4fa83d0f15541e1d4f6ff42929a679a9717198c0316422a3b6dba4136c4a4812a0d8b3af3664b7dd656eb85abf38d12b2658bc2b5a733570a8c0f31cf63ee736789e405363d66bd186aa9863263710dbf673841282e636502285151e9a0dbf46636f7d1e36de1cdbc4686ae1413294206cedf4db33cbaa77f33fdd542319dd701f9159b896f59c0b733ddda7b5c6b8ba33ceb41bea3e9a7432b1c1d5074da6686a0a1038a96d4bce1587a7c38fc46ac82674f9c5d38a0f89174d969c9591d7cad6a4043f6ca0577ff8139e26b3e6a47dd00dee316cf0c73e46b97af9bb484d551e77166a11ac34746ccc533358e8eea40b96d4cc2eaff8165ae8ae6c58cc1b7548c1ad6655dfed64d7eda55e2103333f63b999aa283282827512ba4e8e62dca7cbf9fc180e7c7d9ec67e8c37de12b9365a48ef0b49b880a077affe70c05aa85ff99204fd366ece8b430718b660a725b37eaafbcf947ae5c1372aadfed373dfd3e0f00e0b5c84513e5c0f9d51a57be71688fd02302cc1f7ba950dfb6322167f558d5a509fd861de6f3d5be546b726cce603cb5ebebefc36508bac6ee713b929cf2198c1661c435fc10352462e41e09e0209f079a402ccfda2be4e9fdf2ed0f0b3a9cee220069b745780c9f6832c617f2272a08dbcefa6c00fdee777a362c973f2bfd55710772dfc1e958392c52835d0a86adbe1ae7379519480e5399ff9c298ad1a99287f474c13b2ce3fda1c75e1fa5b69dedc8f8c9f45864cd1e0d069b3a87d6044f2c1cca5b67fff1cebcb8ee53a9d3354c8e37b6242fed50b62ae8d52058d3bd5f37e2c252ba797a1bde992397238f6c3f42b0a74b405c46fb36b42f98ae9cfed0ad095b748d74475421a19a573d8ee73995ac00b637c7b8b6f637208bde9c8a7a95c1b7d42ca69945899ec60033a030b34a96f457478e136ca0354e83c9cbb2b325c500546dc8754e25960b3a4c45acc85d7632d194f743fa64d36f5444f5330e610858613cc4a8c3cbe5f8a7cab9fd53f682e37848abde7c1cae0603cb548a60b8cea928574af41e0ed2d3cda98bed4f651399e361b3ee4f95a3373ea7c6aadfe8ce94952ae4715ea28f422446b4abcfde81db7f86b96ba40e24eaa77a85b18b21d01d5d62af3abe709f07c2d62b050f19760ffd6be6c4e5483482e4dce545a45a8ee002c547b254606a17a78bfc06f488fcb681c8e7b4cfba4ab16955cf587961b74ca61e68eb652f4b800aa14869dccb27a6ef4e4596799771177da8942f25d920d336215701c693f5510820a3e955e0d9073f51dbf332112eb6fd1f2ab95b3ac66e88a27eb8c18c16a035c8938cfdfdda6137d69845ac18bc560b6f35234be6070e9ef5965e694ddcbf2551a23c229f424d1de22ae464b11f47c2bda59f5ce4c58e8270a532f7a379eacde2e38411a2db55ef0dd4de49c33cfe084d485655ddd6e9ac98d2322d6d97155bfcbd8b3ee50f2a6a0d1186e41b2b96a5baec826444313a0ec30823baec4ba938de9774a0b32202c9ca84f4887f488f15dc5f3f652092888e61c68cc194b154d8de5b29479c083f6c70ef51b49634dc5fbdd608411fe5a4281f09e26ccc50e2ffc0e82f9839d3a81a0835100f40230496c9833674e655f39b74fe79eec3aa9e513522f1439812ab5c4862a4ec89b1aa0ff3db6297f3e378e96b295fdda7ec571cf3dfa759703084e9417ab6f8e9c69257cad6a301173482c66adaf0f35e1b3f69dc18147b86d761bf8be052b5cd7fef60d3aafd93bc24d3ec231d11883675b0993fa2087df8abb1dba862fb99c6b589a29b1b0993d55654d1aa79da3ab6ade0f6ae950bd0973995e92c07b927623302a081cbd32c288f8d03e1c092750411561469784b20a123d8ee07090dcd77bf1c186024c50ad73daaa7617e6d4d125b8565b58de36a2d9654ad39042080f59999bf0ce4d8acd8cd0ef8daf03dea418aa65c37acc0e7612af95f53742a2faeeedbd4b0fe75e9ad8522405dea0b6da3d95ca5dd4309ee51c48aedd120ba17cb9adcfa7b7583a90ab445ec5b726a609c307e1c0e3f9dcf998434c10cc51f69698c60a5938a4205184c88911f20a6da3c55a694c5891785f33662c19e524dc5bfe2d3ea8d417576ffe734ee805a9d50361e76807ad9028c1ddd1587b19ec2a8a5a6a22ad3bd7e4b1232e1f96461e50eb0a911ab9b56a3f5062ce6254989414bdc45e14ba8ce79d3aebf83b034ecc5baa14dc9f336c1b8656b46a08dfa9abcbf472fa913939545618747ba925aace446449d89c782181b422053f360a27102075deca47249c1a1566a36c1a8d67caaf1919d79f041142fbc2e66fb20495bb43295bf15386ddab0f7f4eb47adaa621758785588995d69a3a6832ac26ff0ee47408b783a64db3a763fc656669ad93e74864ee8c1f3b25c4c6cb5aecbc7abdea41892f994ee2c6ffcb81f812e9bcb65d92517e1ec90ba76c972f4384d9f6f94b42b590eb00bab6c2149d6cead07e0dfa2027651ef959e64b1c3fbc07da0f327be487e95a705bbcc03bcb5a46b583647890fb509c13ca0ad450eec3855ccfbac16c29bb309e9e8905527decaa273f15942274f7506f1d12fd41e42e3709a365d3bab98bd1660b9bf7ac6876767ca62fd50aef675478e9bfc0e5d6fbd80e3b51af6f4eebfc2b14cda7654586d3331a3a04f54bd0785c73e7e33c68f1a1a9646c9c5be6ab794d14c82e53030a933ecde31f19a9b8e7f59304bf9a9074aac0832665fa866534d15ee741f9771ff01ce561ab560f8a9ba05badf4e3257c21af7dd6b81e0e29d7774e61f731e700c66f492b84390e4857c914d32b36437352ed14e3ee4ea35a1734108764c205bd872828fec05923733702811d5354cb81d1386468a76e26916d6ad6e9f2d0da86ed2c25d1abf15cde105e66fcee57f68489c0711e0e32cd109b28fea991c3c07155faf0b4cac12ca0a48689c8f1b82400e5c46cb246892231d21d5069f2a33ba5c73d6f41e4b7f1cfc1b4b1b6e9fc82576d934dea205ade9c47bb6813c3b0820211f967a52f4151210cb645f1a1a735ce10097a644dc5e143d66694a3f3c0d2d42ae493942f1c26e8b3b48a12b01c718875ea6ae6cfb89bd6aedd3cedf80634a04f0bb813e4f6629919433f0951e826a85be46360173bd6945e34221314edf3c7869d8dc50cdb16f3f698336306eafdaab9392ab545a807a94e13c2586433e06910f06ad093e605c66c8524ec6362768d1c500b223ed73cfda0a21937605f25ecf291d3ceafa16b325912d437ded288e41c426396d01972a61ff98d818e4b5369f10b1ce80b50246ea89acfe5b045fd866fc12dcaf1467b341494eabe63db294cdc2bf10226aef42ed8960724c790b95f3fd36fb15ded3182d72e17c47ccc2fb022dba97613eab5efdf6d7c9f4cecffbdebdc948d45b8de4362c002e8981f3071acf72a7e354148d8a74f9c13bed1a35bf91edf1921b68eecd97a6f8bea0571caac72a65edd2d771d45404fb9e8bf768a4f5cfb196fa82a6ee360a680e593686dc5341a99ec413d68d355cfed5bff750ba13d363633e6240003644a2b58160d355e8e4be79338a95161f29de9910c4b2981d082a5733fd528372f1375944c8e547eee1a3414c8581367c430046e681a227f205d7e7d99e32fc063967bce8aa5ffb84058a36f4d3b4ff7a167bf4c1709c4b7a1ef8ea84029856e2d057b91f01476287527bd2f7c66f1a044d10c9f788fa31e98302bd7aa27ecd18d5652609079f76758dc9f86936e460e0ce3a1347a92af292524c072fd85be1ba3e0202d3d622088ada70ea77371d533180eaf9243d454c9bb6e43ff20fc81e5dd104ce93410358550cda945326046666b321daa9be8867a10e46f4b1d64b21a936ab76047fc5062107c9664c78ab4cfbfd95e0e0b165647308cd88b0c4614ea2e1f27d3ad0fd77957a54b6e22aef6436709e50961aedf72a0792720d1c25b91f15882c7ed8b2a589bd3a028b467dcee52c64823495306abd91558d1d22b066729cacefae4176863c734e2d69bf5784d3c16245f11d26d5bad82896b9626d076f660db787f39c25e4531062c0591b25d011e6c330e81734d7df7c9096a4877ffc681f7b51c095fa2dade35676e6c141f85dcbb259918f1b1a0a484b4f0ee8a8c62e26e12ff389c51b02d483f523d1fd0ef9218dd833df1ab126ae8ac23362a16fcb0dffa1cd98cb098877f0e921099ee250c9f40b647a866516a627a69e02f815443ad1bbc239623ed0c943431a5a66b1ac3f9231eb224ae70e47ac47337e03321b42d4169b4edd794dcad96b4f6dff80764a3d0ea4bfae01193092128e11fc5b4f83140bd5e7e4dc1b3e9ff6a799594950023e94aa03104200e97bb5a614481fe4ca55df06b28e64e272022173d9a303c6cc9fb088d87123aab731069cbd4910b79f7bb9f72c757db6606c0278e7065b4c37326dd08b04e021cddc4003f4515176009f6abe0a1d4c0347cb127c8738da5d2780dbda5e6b17f1296ca5ab50b57a303e259fba3a58d355c4844065b2ec9c6152e8f6342d04fbc680bd853144397016e927a0e72bc066388d22775f5f457c531beaf3eeba5c82da88f26824111237830634813294f88c4666d5dd090a0d6eaaf76aec5bf2372e9501b4895293c0506c84bd541405df89b31653955a4527f8d356e4c84bada6c1d346053dc3ff5b7e736cc61e8550a2889f904bd6e18b06e0c2f58fdbec740a7fc3904067fca07ac93e25a4e802c9649798cea645636ed656a8bff051bf1428cbb7d9999032451ddf3668d49949ce18b5e8ab3c5f463e3bd97b28c0b7da0f96a959c31b12a4f251259b2ae222846d0b62dafeff3ac1762f249d4a585da2d6d649012b028254b8b7cb9d0a51acdec8d7122e63e64d75d6ca110e52727ac209c16f51323edc1b466e060f3299075abb6a8cf62c9319f6b16328482a000dd3d627692bd982bf29c7bbcf93cc8af2e74a480c3eaeb22ef5b67b6b89b3d69059fe575ad08c47315ec94a1aacae7efda1048758c736e0a3bd8bfc5eae2ad0e3dd02bbe6eb948939d5273234d2b7035005c91b79964b089e0cdf84e1299e54df1bc56125e24d9086113a30355dda46ded7dc4eb98cfa19f7fde79dc1f18991605fa956689b00949fc8a615441c9154502dd863cf44f85349e56f756bc29a56b5527246f749c15580d0d8fabc6b78dfbdd78cc6138915c48bfb3cbb470a5efc8c72184c733b672852ca89ca5b02ca563011d58b9fd90156f961a622fe015326f803c92cebc203d29483ddee8a2d9395fece99da936d1b8af2123bf5f634abb5d18c4d987093d617c5cbda6cf9f9aa5c231e9cae0564d7b288fbc121bf6749bc212a051f00dc12254e8a0204056d434380f37fb27a1ca3730680baf0369b246767378ea60d03c7cb3c1af1d70dc5d0c4b31cb3f823b2731841fa97dce32715ec38fb0d4b2a0d4e0e553b38294aaea020c2fed17c2f20d3da3bcdea832b3c2dc11c22f31e93212e0c6b1f92ff89d9713781432567b27b6ad65a409f3369db2fb052e9d80c8b5137b1310d8bf7c8b5864a7cacb68a3976bbbcb3ee9a6370f443bd11a9bdd0baf7cb5b132752d15e3de1c1b460f0a4144e451b3d7118ed5470d9c18022f09cab3e0b26fae60fd9e1ca0fca9a281abbec8be07b119cb44f8984645aff7dd5c684dd726d85e88ecccbd3095991ec2ed48c8ceb3e126b379034666cf4541541a99ea0cb4e12a067b5043b31c338a448b730198a1d57ecbe4ebe3f4e831999d714ebdeec3c3127edec9dc73e0b49a163600f5e002197e74877d5ceb345c2885e811f6b9085bec4616248fc69f72bbc7463e9c021f623f6fa21b3ae333844877efccc40d97bd58655ee1a712b46259d156e6fb5fa8f7992a5f9f0a6dde39f90263aa605d95f668d0a56a5ef70f95702890eb4df52862159dfd7d635b0ff771ac4d3b44aca0f7f2d10447977283779b887dbe0b87194c37d7efbf4396dd6a62501e97d240923d4d2dfbd566442dbdd0e563938fc6b11e5918a49789667bba425c1a12e8899d0eeb19d39df8f9cf46b5053542d2068e3d35551fcae333b776843ce42f7f9e1c7983b21b225ebf8db9b569d3802ba32f56d3edb8852a5c5d320abaa41a748c59eb5a6d9e12a0cb633c7536689aa3a7f2fbd6a744b3763b5392e3483b8fbacbae196cbf4c9e074fa0ee45c810f5bd743640341cff16901b1582e7b096975e006764a838e1edb01f6e920699bfb53bc5768a073edfdf46befb83e9d67b4e5ee5b999c1300a7fa706a18c8ff348fed97b30b7dfeceb8ddf8336c0a55cb7cefa86daae63f51d6ac1df0c2fdd5a02f9cc2db1b9a5772988ce2fcad7fece64ad41cb1a23565ccb8518a320470abe95e80bab3c18b00af1309c16b8bcfcb86da1b2aee5cedd2a72922a61ab8a96fc5905331f2acf2355627e17d93fb30f3cbd2f10df72fa558d8705e75229b1c4b1e6fbea9d9e9af7c0ac0b73bae78ea67c84eab1406d5c22f8ad2d3ee8265ee09c55e653e6db40340c70219afe247a60f19158a47049327bc5aa91e9cbe7fbfd937a5799cd87a351b06678f07c65b42db4db6c50f1ba851fb72f568f4e2905e682df330c83e3738da2cb946aa9bf5a52285587b48c8c0a22c33549695a277ff29f15024bcf0e3d68ba7afaf60b6233be8cb237c2dce51e84b293480434841c252a207a81e23986c7f8b31202a91435e916c2e05ef9d3effba690dd33c8d19e5e8ce4391410cf600882a8dc543ad2c4033ffc168cb596c0728d3de988f484fb35dca66816a9b5dc0769f7883d6de48e53b5fac9b98a5150a738867e7bd528a88a5eb186fa3c075eb800701e1e77a031949ecabc97a7581d78689b9087629bea12e311dd8e1a99e1ab21e90ac01f76c82a3ecb8a552453f090922050bf7ef30457c57356c01435fc3485e6d1cc52643391ca3df48ba892097fcd7eb1fe5c0cfd3c09727fbeebe2a1cd0abc2c497c1d2d7f751d936a3dd8481f9880fc048f8f16a1eeba0adbeeb3082b9d42a0c94fd23d5710494e5889fb04dd4b46e4fca9791d058500717cc2fdbe6362731ccca8426f62b42bb963418eb948460e6ab9dd67cc79413ae890403af6768f45e152cc2dc8ec9819d1c50b5d6de2968ea47bd84a4206c357d4a8e4f0a4f8ebc97892e21206efb27b150d79474e58137254cbe8870ab76a205e6e5b55f4393505a321e3af1b44e79e4438439ceb11dfb09c935f8db1b62c87e600645bcfd975a04af68e1f99ed93cd01c696622dd8db6a088e5b9f9ba20badc2f023921588bb714476fabb46e1422f4fa5749f03772deb68d1342adb75c1d4cdcdb2ef62e65d4120a3bf6a0614dd08b63025726744fce78159bd9eec2f9adbf924050a5bc5f6ab9846fd17cc09a6b11dd6b19bb6edf37012e2d1088df6d027628ebcd7b5b784a8870b67ca281002850720f127187b13d99a4df8e058dc5e44f13662ea2bcd7ccdcace6ff8fbd9bad5113adbe568a89643198ddedae0caecc4234762fc983ac0e9950b6cbb83c367f160a7db256ed069e98ae7ec758831f93be9d493d6abbc633690f374cbcbf62aefe07e7beeabe02501e2770754a1b98e60f46601090924e00cb8e01e678e9cbf8f29ebb59b51bc9e91a0a0a5e468735df01b5c6a4e6af96fa78ee0ef33202d37b0110923d05daf1a71911c89609d2fe345037cb4b6935fc86f54ab5dcfcd5fc719fcb83d26c7e3ea76bebf5d10095c5938adf744113b526733215e029141b8a934c25a9f75c23f317371a77fc2441ca60e4b0a955f252def4d4c0d68fb64a931d5d86d3b99fe12d7a00159ebdc95f824e3f8e32b75974a516aa734c97ef3770e4c6f0efaed7c146ff9711f2881132d46d239128c0a29fbb7e0167a3023b93e9b713530c90b7c295dedefe32cf5f1e61d3ff315ca63a165ed96e875bdef09bd850d469e04be1c6c3b71eb572a3966a8c655a923e14ba3021b28a8bb5961d7101fd02fa5945fbae40540946c356bad48e841f2272a2f542ea9812168cf53e7603fbfe90b20309b6a31470c40014bf214cc2edce26642af4c75db7fbf379887be0c43f4f9050e3937094daf36e2c95d2f633883d05a559aad493cf7d4b1e518176cc3a855ac6d229323ab0242d72f51eb7ed75113a65a9200be0d582a0697c4a3128d5f91d05c44ab5a3af6f112214c29b141a3a12f68dff358b2e99f475e6955a8354d729a582d27148db782ca8d85041f967137478f4a0a9ca38a24d226a444322fb6d59ac7c21470ed4556034c5f7210d4fc1abd7687344014d89785e93af391c45512f24dcd7a4b9f3c59bff05ea2f934b1059633a97191ec04f870243eaaed76a4603a6cf539612df9cd2b99e1589216276854d0f3553e8cffe443669d4d047d33a3f4e23da56e24e6d2d558d4a2faa1966ce325adca8f873a1d663fdd3506412d0b29f64ebf8c7f2af269fc914ca6370c08cfa8f9f10de07aec8d0e76ccd63d5cbe9324df2f66ed67fb5a89a63c9e6485e70a9cb60226aec10387a645a7bc92621573d060d84182503a4a653fde9c2906928e31d59439d50e1b77f76fc49672ffdf4a52cc6c3d325050f130d7717b3a7cda0cb3ed67d6fef4a703c71e13a4d8fbdf3ccd269d36863204e784edca0727f8023d07cfb62f21bbbe0bd46e35d82ea1eecd6e501fad7fbb450bfb5ce018f1fbe612fb3948c2d14052cd02d5e4873ed5f3be116b74f7fa02824ac6bd0e11117cc8774243c1fea168ac4fcdd24ddd6c213ffcc676c54a42f32e5588d7b1e310a6a2efce5603a4c0b311603e05726277b783794105aec6d872262c36cdf55365e4e124f27fae24dcfefde84cd97d3806f9e4c9c2162233328616453cddb5e8d6353a76cddad54c02a5d5ac7c5bd0ddc2a820e6746cfee26f24dac9ad7606d81372c035b61846b8f2315fbd5d3281c2108d182f102b08ff21a8bbe2c5d651866a44002cf21af6eeb39d9dc445a6f333689875e1fefaf04ebd4ea56c2f3d50b7485e72b751963c4493208fbe1e0abeee45c3533a15912297c634a2059359fdd5f39092d9977da7388dedc768ab7e95099691cbaf4fdf4d34408a7298ab52d77ce4580db272ec153a65913008a9b9e9ece55ebe21f731a67c8286cea8e22fff7954c66a043140925dea172474f80b3aedcc9b2859edfa3be49e59838bb31bde602a768ed943546dc90979f4f4434166c664a1f2f53282dd409bfe42a5d4d7d96a5362f7aab933f7a513621014986812043f9ea986f7802d50783c31f235e5a10b769c6bca39278d59de3ab1a05d5b4b2c748202da36c1a7c2cf30a42dd8375eddab03a4853364b9930afd4c5bf156afe02eeb567dced4fb5dae8cc6df3c903c51a8ca273535b7cf791f104190456cbc2924c2058272849d43d92fcc081bbfa98dad35bdc85a2019ce21efab9a772205335271ad2b67e2fcce697629884ca03f7fce39d6d939aef4e7ca47c4ba9c87343b6ad6380b6b2dae14a37c1b6f6fda0c3011f60fef1c306de36d5eab19345de74a40fd6ed28db9199e37c0b5f93345e189f311c6d0763ecaca07afec3d31f9f78a33da6af7b812c1acd3dd4bbecd05e127615396b02c343fe192fee297d86e098178252cced402ff2ee34c6875f45973f81f705694d7035372548143215eb30cf25ec1e262a73eb36cdf6c2e28b07e67881ee92f37a1d4b3e7c5d89b34c7b4ba8e8e8c0fa6d084e91ef58aae2540fc867ad0431aa46dfb464ebef2033744cf81e71edca5bafc54be86b76f4753b43a0de9bc29e5c0620b24292ff873999844c14213e63e9f370ba6e95bf39da94a4a6eb319b1c0380671575bb8204e4f96a11a54d21dea0461ace2d5a82662d2067b6a8c4aaf7a8107ff3ea11785c3e72cf68df79a922fa533b9ac08bf821da885be71638028e2edf5652d9cd35a0b5508cde0c2545c1e984c9fabf165de9a08439db82e363f93b17f89882dd1eac390a5790de2ae7c2977c753f8ecaa71fd7a3c61e34a62b7940cfad6d63f20658e8bd50eadb06b9f9c96597975b093329cb225d9bfece4b2f8aeb149eb25bce2efb55f748038201ae34d99c7fb8a66a2e692bc11d2f6fa34283528fda205761e2ea450d17e9ca419009cda61fcd63fa3ca3113dea5e8ca612cf1889a8764b90ea5043c1ba3d876fbfcea584bc3df9c8f605f7482d93d065ca95a67c1b1317ac383e1dbe38350c89898a4fcadbd89a627d7c8bdb159f254c012c58a36844a2652e78825f87c6e790310ec5948e8b8591d1548b6dd5e549b43bef33edb118990c908dc80a2428c645582874ed6b48f127b80981dcd95dd5784451c2f5f3aefdfc2e520d108c4a7f864af8d1b0b2cda32ec2c2352a8f59b5e366113f6a7632aecf6b076917cf587f0e93e9f298ec341002c34b9476475a310cffc82050d2a5536429015e7b3d2958fadb00555faac7bbe6875c547c608c3c6e21e65190016cf5a5494432a793d3f118d94a40d1be68f55020f7541c2449be702bbfa6a31b3d2e5fcd406e690fc2a82473b744770196139691c452644235d00e032ecaceed782a7f6958f30cf3720ab78e02915e6bf931b21ea0a50da383551abcbadd3ebad85e5d347cc31a02b509b6da9fe244e50557b65d8e10ccd7116e4825cda8dbbd49a8e524ece8916a9f084286079f33c004b83b1786d6dfc1e8c23931ad3bf55c58ec16be02d48e9973595c3d00e06d8f8d1c4401550573c89dbfdd06153fbb5e7b928f111ad07ba5e39fb18b3df8fd88654988f67f8e3c7cbc1486dcf94c05622d7b35c5ecdc219925e335c86b4a3880afc3228b76c152ee95e4011b93e35eedcaadcc555fc8af3c3fb4fdb2d0f815209e96bb9055454682fbaf48e3dbd6cf8ac31d084ac3b840cb08a1a128f539fe3f1a41baf95023a2c347883d721996918eb4a89d8e7748cd8a211d24fa2805408dfebb48665ddeba1ae70051c2a7345ee1cddab2413b00032f5fcd4fe780173ee043f0ed59e116f1609c8d88e585a46a3f8f91b4636037c573490f0ed914393e79cb45d660f457e31de30a534ac386a5a10ea1a95a6151f1a0f4596326ac9f7afed796e8714260837a80c5391d72477cbbca995ccedc6a4d0245d0dd69345874181c9e976fc902488205ecc0a7377c20922bf91cd65185505b85a68e03b02b13c02255909925d44d2403449022b87da6646f3497c77c876236b59fc756662c9f23a7f1687c5dd2f10fac85611dc4ab5ef94f3ee8fb004c0b9356cf43f4d2e7de189e38ffca4eb5c89f896a5a2d50776963805d31bbdc6db3f2a94244457b957f90b2927e2a0de18dd0c614fca2f8038df6520e6e45d3e25899d99789dc09ac107f8d99faaf806baa5491682c3ce9b05dc054a847094d09db75b5300417790e14726752e8ab6cb308cc82898fcd95da3775c5f69f60f2bc1432915ca441722724aa34b1a91268bdb7e684e916c2f2d1cbb55c219528e3e2d3c72269e1896a000110c6bba8b9ab95f9a78829ad7868a2c02e0273ea50a251219ddbf1210b2703524ef38e937203ac2110d93527e80cf4cd072367544b2d33470440ad5dc89d1f52a8c80f20a94a82deb089115cd1424fa59bdf55a7f764bdeb469792a1f0a63cc07c378df1810bc3c3326a423a68c33d439e2ff1a2538096a874158fea5f75870186658d86bc3cbaaddadc77bedf9d01e03a1d65c13947d4cfcb2a1f4b925ae5fa48b87e1cd1545ea9247fb5c71c24717cd8621b79581a1f2acaf4d5a02fa0e05513e4e6fa05c071530d8bc7fc6225f214b8057ebdb5a460f15821b00426ad30ea68d77b4eafa88127a2a76ec407b6f8ecd0907a2b3450637e3d4802a64f9f229831f1e13856b57f8f3be8d3e4b4351d1313d90fe15807b3782a06c274967d049e666e61d6242430dd3bdf43a18394f54bd135ad37f9d5aa185d8543a3d765ec7d186806a6cf09949f71038ef51be0bab41bfa4fd75a33dc7a79f787d2ae6920af957b7d3065aa06c66ee8fdf04f81bd002373a39da2ac12c1cdf20a3b98c6105fd0360e1cd5bf0a8c946b11fbe60056b1288b8b8a370c76ebb60a8df6a95a73b11deee4c8748cf893b81b3160f60f599c38b48b27bc70aa9bda19efa89c570742057050e4d08a604c2156ee5481695e3c447a8cebced22d46830f6335a19119b9132d951beaccdf29d843c06ea8619d962bb5d59667c3503fbdd717f546624c4898d041312856c8ca0cbb436da4a447c03cafed0731fe72b15b9df57886e86a3eab833b49d887ab469a32b30a0efbb24034dba06617909b1a1c93178a7f433aea7aa7805e74a5f753b2dbf883a984632125f276ff2993ce867ee0e6ef6d1b4760d9fedf7fb7287f15146ad9f1a24691eb5f78dbac60f07e43775fe69a624db988f3a2a2de39c599cbd87a30d21c63c9636efa9ece0d68edeac3781032bbbe7e9c290bb44d8014be34470fce3d328f83528d54e93fe632212eb7447591567d15c4953e028c74d2894fe3e594b5be003c7990efba66812b66d9c0d47ce94e39c7d4cdbf24891e899ee3a831b797ab963cd4bb2ce5023c5fe6dbb15b7e99b829d81b652422ea84a86f60dbf9baf2e24882df99b926d103318789673a336a764fadf983a33eaa388dc576dd01d6dc832b0085ed7c577040c1fa987d19cc122c50672dfa9e41408caf4828eadb7f5e885450f269defd5b7d8d3b97723f7d55712429d047f9cbe3f95e675bea49fd8c7f1be46add8f6dd045c95785919b729a51535109a2897ed663092844e635fb416a0168ae292ffccc3573084bde28575de43bdb22cb00048715f8bda76c198a58c87fc9a10250c4a26e7a077f05f4bbdfc3a1d2a418533604655b1a8b9eb90f214a40019b67024ada05d5c12fe0395824562eb6155713968eee640502333bcc0c25e6f9f3cc1303dee5430556287d9dfd3db4a2aac0f2cb9486d3e62437809607172a4675dc00af58b6d4c86f6b1fc22e43b0ae5389d7ef3d1b01b27d5d3fb9d6a76d3c9a7acb9c7afcda7d2ed5a0a2177bd7e6acd2c304689e1ae6d8ea4aa9ee5bdc6670d7eacd986412f9fe70c7f59638a6764c19cfff29f03d48f19691052bc4651aa882439de8b3392d9151bd75e9a6b9c385606bc850c3e1b7c4dd1df12df08d1ece42df55e63a029b321ab9e0e2f4bdb39c4ef414cd3afe195f5e83d25bd4f8ed002ebe01b14f0bcb2e212590591bfc3a33c9e2957af52dbfe55c73669c81397a266a9e56880bd83d110d9bac969650686c1404454649b5eb428e217a2ea34682e1abb813041bca9d295e9b43baf025a9121d3e5db55e0afd3a0e51787e76e9d643be134e7fc43a80d49beeb1759a49eb98c0c7b6c69f05ab395f64d2cc11ba136f21a722058d5162c110795df9c6c72e7e24b754e47f516c1786ef4cfb97698d8270435a3ebcdc6e247d7a5f97a14a45cc2de5ea178ae5fc5c958709df698560c5b2724038185e240be2b6961d5027e98e6664f6261e66284930de243eeddf1cc82af603a0fbbc7a80903d3273aa4ae96dc0e050ee9d96191dcce0b7ab8c215d0292958a3321ef01c5c07e9237c7b451635cdfbb207891e92e8e931226006df8415549cb02a8e671238e2317d6bcbf47a2939aa1a554cbd90f3985dc6a4d71aaa5b996216b401f2562561f58b72ea6b124d7852cef82e9de1e09eba1a5357a2a253c82860d9e1fef78de0715a2489341a24f10fb20fd91adebc432614f53fc525166afc4c77781a1083ad5da613bed2d4d88de7220e973409e24ccd7ba6b842c9dd3332652514f948af9670e2121de94ce4c9bb55309c3f32afc3db80763a7acd73e2b2335d2fc0fc0ec0deffad9335f06c155e6d3405447f2ac5e36888f07d69549bd81ca9b0362315615809698f52ad8f39f80ca597f3e4ad72589d09799f7530eb05a3ea1b6f7ebcc847b5ea69123a13ee65d51a3678705a1f8b3a68d5e345a0d6059c58911f9a0fbbcc2bb0aafbe905eecf2bbe47fe998210eff3f8d98ca95864810f9caf46d0161293f75695924da96ad58e84a1b64f639acddd25918b6f661052dd77e9f76abd71eda65d322ee9d13a4af51b0ccc48cdb8b40b4249c9c57bfad8abdf9f6cde25c47d4d9f930de1d1a1a1790a2596babe9a611589392f490d0b35580b2428df60995a20c8d12885cec3c0c2f0051cefb9c3c5bcad7d1d77b9294ebb92cb7d853e64f53d4c4321fae48bc9c71a8c5c3647c44bf12a3c3c657a870ab5361e77a14e413fcc47d3a6df34ee85fc84ce6e75e15fa5a5f8b3a561f72bc2a1779f52e8a03491df8ded52577340d10cd3a87d755912022f2508b47364334918b2dc0a0cee5214a9ee7e698bb8bfb38ab5a0dbb08580d646501dfcf5cf126b5bb23eb9421b7d3fc954eee2dbb49df2b981a50e5fedf8de4b8adb5a03918482c410fce57a417712f4dbd521e761f1195095e59597246908e69341c27b3e6c42c390674f6bbdc98b65f6cfde3c9f71a7d028538db12963d4b35299c8f183fb0f0eab3ba3b36bc0cd479c061f7cb3d75dd14ca56bc4fd014fcb8145571a97aab41996cb2e5e985133928ff03507978d8e236c0301529f97c585a826df8d46d5cd617729f55ed0c662b2d91d3124b58e32ea71a737de82b7bf4714ea122f7d1584d0a8385e71ffee91682e95bc083209f3fcb32c8848a0bcac51e45e2422c51bc76ba224603f9c124f450d642c6c70cd4fc532b0c3638bb1f5b8f96b410e1d95ec3efb9b87036c786ef5252f6f686572f27e85fbabaf7543140281c983cf6604171dd13cb9272815d28a4612c688560a3ac4378f17753055a95af18e2c4469068522bb8a015497c687ced306669675d0aefaf1d52b7e922acc59cbd2bec1759d42b429f56ad1ee8b457996a73dfee0779bef6a3d698a81860627e3138c2166e40992d97223efccdbd3e87403f4adfd83c2158586e13e9283bf1a8568287f44a4f8a46b97a76d17fbf8453ebef20cbefa30cfcca9f4ce32e3ed0e56f65f8a7c39af30c5a2d259192b6fe8c778366e391513a5e422131d22cd4415711787a6779456ee7be4f56e7bef401472920b8b1dc6ab9fb3818e08103943c5483cbd76fce140272fce8a67568a84ab5351af3e7afdeccb32aff11469dd2278428de792f69598a4a8879234f6b68a820e26a5d100c61ebe845b64dd8dfdb0011b669facfde2c5226eee8700066353c822dd34f1395f7a0cc29dcd8fd1448c8137673fec4a0107c963a113b1949372a45fad3c4669d56afd19e97b4c95a9d18d922a13c373e32ba098f8e1d975c3f04a38287d7ef421825aef014255ca850c62b948939efd9817b20fe8fd5b7acb8fd3966fe02470646d831966c73f849e352fa8880ae17fc139525f35a2fb8d1d73186a8013ac14e2cdfad6776255c649c2eceb4c88fc6ced353f2b61fc51fa5a19d595c95e28292d2a8d877a32540771226ded6229b91a88196ff9dda178488d7a0e9680b0cf8377efd57b1b925eb18f4e958235ff14f6d2b630a3d22cd3547490f27acd154d7f0fb2362b23314d0a33526814c6a4e365e310c62e5b932d91e5f0891a17835803ec7cc3a987804c990e57b052062c39521d1b4e92713e1bf9e83b73b579e3a957cb4291d90237bf443d6a1e18c537e86245cf8609c824b4cd25ac447e5c1130cd600ad5937309f0ebe580c5cab1c322c68748db64e0b76213d9db7e7751dd5fc6abc55c1ad3b1354b650b7447f87a454a25b68b06c1f402818d6bd252ee78d6530a5f1144604206c636b0479ddead1464973eb9399e807222a8346a0d19c8e7257b891725a53aceed776d04f1763a12dfa4e265f434f79fdcbbf90bfc02ddb995f05740a305e5bf6b7918ed60c639b52d7c6d349fc84505c4143e3d8eeef3f3891d0b3d2120db9b963d56e516d201837dbfdacad75b4614ca220b6ef5123be9a4bdf3f454b98096dc51b5a7277ea50aa54763de4dd7110665dcd69e2051ab073943c96866de6da4b1c43c7568df2fb6dd8de1a82766f778bb307ce179a2a53876a98b7357034e5fcc3a5e1dec2289c9c447ed739d1946a692c859c4f819254ae87e6b027badd3b334514d3c70bc97bb1d887d4c5428f9699d3fa74df944a384a9535ea323aadfd1dff18dfb69f2fac50f696370295e536b6c7939b9d39dde6c0ead82abdcd7b794bcb22d06838adbac120b7f20f7e7607a24d89bcc92c6e5014a3a6b8c38049e0e6f27136871409071d47035bd950c18aee76744b6566f3254ec88e4001ff57a0bbfbe0580f0394a1246e14231f735e272e66ebc70c1b420a9f1e4b14e6cd08451f68333dc7a6b66e8a5d397153e1cb2b16946a4633b84b190366fcddd1b146a9a366918afd1d06db6f073501c945c7826e3880cd638afa18ad1eba09f8b88bd12b4de8ad53c70965c6fec07f0e6d12b2fa27b9ae5125d4b98ae1b10f77d8e9fc1e7887f5def063e3b9dce42bc2061f9b7af34d104303166723f08b2dfa816b948bdd2501384068dd92f81b3817e9573e93b5f558c6ae255786aab7135b1926c1d4df20d242b6e083295f02ecc1ab1d15a0eeb782459e3161b46e744a48ebbc3acc1a86996f86c043b520373fcf928b44d1e031630193eaf1ab68508e373ea93d31e100e9ca9c27969f3ad1cd18e903aad6aa1ed1b02ea674c6605777728bc8380072c94edd19944ec7a1d3a88227e8a0f497d7d1447a0a86589242532fc5410a8717ebae141c413b44fab3d664bc2632ca266b03a915ba93dbecfbfb8f424353d4682364a09fb96f0a378b145a68c7826ad69ae74ac05b30b8c4259ecec5e34d3ac4b13898e9dd1e0d8096753b1014eb1c2009235e10acf57d2a6295ebe1edc6ebdb83d80107af6d3ef6fd2fdaea64d2a04ca6b51538e646e394b2fb142eef29b4813f9646eea3d3cc870d32028e61c5c34f3e40eef29fc20beb52c36d0317e3117a9f5859b54a24823e1e0cbe72004499d2a083050ab3bc6588d005b7384d32af51003ac5c6803be8ef6255504543d4a1f8c6924144fe6413b9309eff6fd9ada8837f1d337eacc901111010f624269f3aae93c3308411ed62164bbbae28b8932defb42cc4d67ded3a51ff7494217d5bceb7035dbfdd63a980dbd4082453c91ee871bb614bba3a496e22fd0767bc3fbecd3b1bbaa6c02e381100bbf8f22bd8457f6f57107ab1802f51307afbfb7e8e26cb4e064b15eec313c38cfb1bc1523b9298a1ab6fa59f2624617d8e2c068ea0cf54d661e59558ec38e914bbb8a041e5336b2f655c5fab568f43445a42697907dba22ce9aae7b6f76f59297b52e19d68b2b9b3ebb24479fb58e1c0268b698114a0912e068ddfb98b132454a85f8ca950bdb81473998f52856bc04afbf96462416331c6382be341bb9c00a2e734f957e1eee31fa55290c6d2c3cfb13373d26ed6288856eee4ba4bd29d3539f6c9b889145218a6c4948a446047c9b172042874252d188d250ae01865e18ce47950f1802fe6af08d0ab241507c42b3d8a812c82cad341045baa92cc7fdea764cb3a1747dc6cfeb5569f020d8342049117337c1b0bf5da414949b776c15c2a49699d5de9f9fdfef01a9261ec84f9cb17841ab152aa9ca77d2512515fc2d51eb3e3a2b7d382db463ebbc95a16e01ff8bba42a5e3e02f38bbbed57539349c8146736251ebd85f0b6694f95c9785eea9936c5cd9196eade2892974461515e81126eb503bbb4317d185c5712bdfc49b07f1d8dc8e60ad9188d976747db951df88419648f112d99013e0de4aa8f22c22f27ec08d5670baa84befed9dbe1deddd2c4f3815891620226499ea4b1994f2f716ca90c6278c994026833cae2d77e0aaf908545bd1417636a9542f0b162614d018229172a9c91eb0039b4f3ac6abb7236476c000591015469b96c48784a2df0266d8dc1d3a451cc6c262f3d9172a97e7bbf4f7906c3f05547d63231480dd059b89799f884e9c6c4913e9c947d06b471bcbd7d7f14cee28c11a93db814c360a4fef75fe82db680fc57e3b4bf702eceb59f0e5aaf5c16166837321731f0461d8ba023f87a45a907bbdc2fcec871d3e105a2be744cf498089cc488ccfcd9a0982bcab7b319ea64146cea9afd164d7eff6106048bdd46641c6d895935f8b81eb9cce17b18808a1937a9966cae722732db17e17972f5c5602c3de17ade3a99bc07a66aacb4e20952533bcc36deade9b61dda1a7c9662fddef245fdd2774e3c3807db2abbafb194481aa72ac39e52a0ae7b04ae7cdb54184e746ffaaef78137c85120b8de0eeeac7b7755f298111d238ba089288a36d53114e88895842dc65470a8788443fd5dee287b84f789663cafd3ccbd0b06c82693e160ac583329870e4eee0387512f7a167e85081d53e1dc2a0e144af2f8212e70af16019c2a6e0c7673b4b8da85f68dbdd76a878b7ee41d4e076d0781d940eba9bcf795b747cb3987de5715b51c955e89166c564c79dea7f37b855fafc3cdc2d2fba0e6e91035af6937616ac0b7d236bd3a48ee0ac6d1d028bdf31c2a1597918959cf000e3e69d302fab52a8f069145973fe2e59bfac3666bc7f760c790070430ba10cb6865c3f6544c83eea09fd96ba774b7ea645f908cb43a01b79b18abc16651af5802e039a1cb060bd059206d73648bdb2f52970c31e56f2558b75cbc44c5def4c27e9681f520271f9343837d5b32104085177a316228e75505faf3883f5be68aa487b59478b6ed45ffb53f9079f1b7e3769b08a66948a9d304b5dc2a340655825baafb001f4d6710a044a2f7b3bcf504efae9276991e4a48b5cfa98440cbb5d467a9a87e4c148225fdcf35fc674faa096a80d817be3a90b6a3dd5373bc491209f45b329130878612443a0b91ad67d339d3b3941468966e50d43682b9868b9462e27bfdca8aef142c98637d1c8b6644d5b83be2f29b3408ffa77d7fde45ede2290d5a66a39d2c7ee2d0a8b3497c3a7d19d7b5e0af8d1d967dae8bf0215c4be5a3a3621c06531d5910df5f41c514cfe0df541385967e7f4f700bbcb890eb14b63ecf8319d7981409ae87d1dd0379cbad25c0b02dcfb7e854379d828407ca3372e1b42f0c73e0884acb4a22900d1955529024256ffc805239acb3d0e883d894a15bdd18b6324ef0525d36ac3ca0efa85243de85340dfd2773bcea7a1a513623fd9fb7edf45e9696d5cec2823f254803cc3d5b81a0e78f782c0f934ec70245fcc4b1d057e9b504c47b5cc980377c4697db90ff390f894ba83cf235c4a2e56755489404a524a82f0f3d420fdc2cacb226f6fc9e9e655aab2725748584835a43263e48bba0a81310c5ad574d6e7baf13811931dc558ce9a12e9fa7b75a5cadf3e22100b735f062587ac7c2b8dcb37e8a8f7742d528f19218a3aa23549f0de47337b8c0caaa894a5f518f0492478ae9709d7cf7ddea6f277a2ac4412348f7be28252d6b51fa6250feacaeb3ccfc0607f376d7abd0a52fbab342f5c521761a0257f36267194430e8cd18715db6e64b6aea8c0d76c8afe061538b0e0c1143249f81a098d6450031a7e2329d3f05bd8e4c0333ecd73b8d9c32e2af49132657cb89ab17ad0ea713e475e3e97955c7bcd6c3f9b17ed580b1beb3c4cc4f32d12cbc764c6c928a39fced2d449bfd809f67bac0774959ad2843eef9cbdd779d02a552629964a64a2b15380efad45d89e41bddd640705070b15d1fa76e9968901507bd157db02d27951e9477f0474ece94ccfc38a881973cdd197523b3afb2d58b7a172beeca324fd31f1752068a0b3b5141fd9c678799453c0d05e68d4a5c40bd4b7f9798cc5e2a759cd58d3a31474617b2218d4f8ef1af665913f35188a147e790eb5c98d753437e022678d81ca8649e5fb2a21b21a9e10a29a05e393a704f7cc87ea5603f575627fbf60429f6de665f67a6c7b03249455a79a46bbb80dc85942dffadf434f50751dc5db04cb52937c3b09d3f4801b5f9e2636329bfb462b6379ae73bae9f6356b9993fe0ff8e5411a0a656e6473747265616d0a656e646f626a0a31372030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e6774683120373231202f4c656e677468322035323433202f4c656e677468332030202f4c656e6774682035383332203e3e0a73747265616d0a789c6d7205501b5ad035d6e2502a50ac042b04b7a2c582bb052d52420204428204a74881e2524a7177284e91e2ee5aa4c55d0bc55dfaf1defbdefbe69ff9e7cedc39bb7b76eed97397995e1e854483dded61bc9cbc5c3ca2001d796d355e3e1e1e000f173f0133b38c23cc1c0d472165cdd13051803e0c0ad081d90378f900f7145e0266800ccadedd116e658d06b05a00ff4e02f410e650b81ddc11a08742a05ce016d680d72e2e2e522e4ece5c8ece125cf74d3a3018006d0d0358c21130808c86a6a192ba028055415d17a00043c21ccd11004d6708026e0150855bc0904e3020c012e50840fc13002c504828fc2f4d4e5c7f0b40bac01cd1f7c22c1d5176003539b0b4bc863a182027c30d96019823a10055c5fb7624da49f49e0db370b4fb6b3a0e00fa3f8430ff0f41fe43ff551dddfe415c04bcbc0028dc020d80c0ace04802eebf7c53425aa20082ffa4a1cef6ff96ee0539ddeb03b0de7b0804406196f76c670442dddc0e06609541d9d93ba3618e00351414e6880468a3eccc91ffb2ccede008f7ff2fef7f194a68f37b1fa49156f7cef1fc93823bc9c3dd60504d38fade6a4b73c4bd457fe7f561fffc8b1a0c0a77b6fba71f76efc7fd8f42514884fbff3e793fc6df0f7283f5f5b540caecff2dc0df6539a4050a0a475a0174d0f75e9a3b42ff4bfc5dd63487ffb33dff8af9779b00bcff17ab99a31de16e80373c5c7fad07cf5fe75f64f27f2c1008e5e6c9c92bfc0ac0c9cfc703e015b8bf4404f8defd3f722d9c1d1d6148f4df86dfcff26ffcf722c1606e300b82e929948558804d7ccd87426fb9ecd1a207eca3c36f75d9a778317f0c35efbf2183775a43cdd6f6a88ec05419ae44b4237e10f1a5dd45a5a36a06f32818d1c6c060387db0c914d5452e63919577e9fc9556e66545b0e96f1c3d4a3b0b759cfd904374e2ccf47b4db64181e4b49d5265877c713205def0b705f56d0f1e2d44ff1c3f412a004d581e2719dd11c156d84b1e8d5a0766fd86485e2c4f630565f82f11ed33539a596715fad9af05191ebf62ad13599cf8c679a0746457ef7a05a8d112677db31e1c1d2e5662437d444a2f61e0f3c4d155fd98d6b252a8e4ad03e7dbc62b7f7dd5ae8b505b799757368d9c83f54a5120470538a35b9c617fb0e0d16da19a300b5d567f98eb0ffcf8076fb97f49e39959a26b8b88bb82fbbe0c367d7cf6966ee87ac823f2f54dd80b87487d08f8f4c0ec0bf31cf3eb6af35d411c748c4ce9a44b48645ff22cc5dbf27ee7e152c98d3f87f6a4d0d3c0e618abe226b36766bc0c4e2c31cbf60c476274f277d70fe3d6db6b239614d2f16bb400afbe7506e3b04312b495574bed10552a314f9a68cd682ed405903b2f767e4615a7706c1eef60edbe4ad4a4300a72fec480a31f383b172eea2cb6ed88c0bdd05734bb9914095c7675f7de16c5bd388b98aa94007d6c30e681ec72fb7c1f96dd0335f455cd977c3e9d79ce93fae4ab9753a96a5cd25d5728dee22feb8268efc7814078942a0a2862412c6e0bf4877fd2a3b789f14a63b76f4e3cee4a5d506f633cb09d7e98adb32af65214fbd9adeb100690fa7668072e06f6ad2f96f942794027b18df55a4ce699c9e48f04de8a816f8131afaae1ad038c67e3ec662f2a2a006eccb6c18783bc8f7ddc42e5e7e234d27d249cb1c43e85b68c3a16565752b4f5dcc9d8b49f99bab44024baef74ff6c3ddfe0d26d838930b1d265b05df38cad894e10741829209f6f18da2695e9d6c6b4a9c57ce6c56ecd21b4336997346d5d17a109a9b07c2978a2198bb5af5a42b5b0668a463f616f76f09c1331ece00bf99d50fff1481e3f2fb0d74233983c10f753905e8c3536d18f9d74062ed93b2e9bb0177acd6cfee412caf13120599a0f3f363f4ecce447591df6c342e29efd34e8e764bbfc26026489c2226b7fa0db06acd6c103945802c66b48a908098af35d5304a946dde5bfd2683663819c886f29bae7b388146a9a268925fa175bf7085350efc66e1e325e68393e01ab8767981a0795cb263c983cee70deeb0a77bca30c8dae32e6d837afcb9b64c8514a081c8a057136f8e80a37ad04b64a1d45e6a29548f2cc6f023a3fa6d38c1f63c5cf557c9faeaa35d444951877b4af3727c7a3facfa85329f7c45ccc094531d21d775aba685238a56d600fd7baf25666f837135dcdac41227b925e68735b84ebfb16b211410a3f82ee37ab04fdaeb414c08f37947a9bc40c0975cfc82b9fb48adcd539cfee7900b36d2a1f5d7e37637cd96124f65ca833a296ee4403aa5176ec33312135a4e505c221fb5e0e5179ea4ac3c24c057e737b45fd1ec075fec2edce2c06f2157ace4d7eb2d2ef24e3eb6caf54e419c8fc67cf9b23ba774508ef38f392884ee37c31b287f9a956b7daccf3263e3d378dcf6fa27013af1c9b18dc89bbd628f2ca8eb4542f28c10cb9c75176080cd3e2956c280f791ef2e2092e4577f972df395f14baa91bbf67522e55a3328d2e048a9d921dfb08231ef317f54fab741ca13729177397f8bede5a43858316c2cba92ff34133f35306a5afc2af50fed4b64ca4c42fd821c6b0cb0c8754d9fec8cdf42f54f39e07acc690a12df472c8089d5ba7bd80211c2bd48765a2173693c7d53e116fe6943b56424dace8e5e9298fdfee69dee1f169915dbb6632d3c0743b7d2295f0ec34b4da969fd5a665ee79a329eb58c0ce9215f5c1ebf560fa6cdfee2bc9b7a6bf77f9e7a74e0e79b8b312c5afa55ca59ee9eda936dfd92bea14f2bc37f020710bb3356d7dbc3ae98db7b577025c78822867cd94f275babe023292f830462b0a7f6f7d0949d833de28b11858e26d4414599562fc88442623434cfd3de236c1e09ad73160047597034efc363f4ebd90415b6daff7baefd4bad8a508a7ace2448986912d10572e5d251d23af2ca86e7bfd40f076e0a8f0dda3661df1fe9facf8b5f4ef683af6d28d1ac549a55ec59d88a280085a8392e85c450e2e59953bbcbe711a3c468e99b0ecbb2f95be0c6424fc960df1fe474edcd70aeaef8f17b968dd27509ecd3ab462d4ded27015ece9cfc920ab8c34b6a080a9573f2fcb869ce31396f86c6ae9b75a6e5fe723559fb2b5e8a9c41a7548adecbbfd4ae14cac696f8693cf263bc8674118bfb42795fb5884231a556d61d72547677f680aea160c0586b9ce9e388ac4b6c9e04e3d5dc1d11006b337644c074c2d3f6d015a6a5059625bbb62140a95c47cf576216ce6b63f389aba6d210effba8d73a7387dbccf245a9959084497083c75ea62e8f6c75615227ac9daef4a3879baec4fc9904f0174caccc9539e62ce08289d8afa160a01e36650b1d55f6a42d397f0f4cfb98c03b9425d7224580b38c4816755de3ad7fb5b86272fc6b253851092b8267145c579bde43d0a9a93ef0c2c221e761e35c7aceaf94ae49f2c76ea557dd786aeab483f8ecb2da8d4c7c5c42caf2cd738d23212d5e660c717979dc5774e383339468dd6ddd4bceadc2373dd5ffb25d4609b987a9817bdd82e472ff20e4390605d16fdfea228a28c79366592eff7032f746b58c04abeefd13474e831edbc7b022bb4a95fb115de77f0055e4725c8ca4220fee944cd6708c3800f19eb7bc84d9b5756dc2d4a24bc1adea635bbb79b992e09bb9e77148bb40ce62c223594fdfe76a0d7a6168fa9ce4b6173248df4721459475040445975a5f2a1f0ccb6a9a53e41a77ae8dc0491436644d8156c4bd72aa9e186ec99f08c5f018b91a4a594ebe72e54e60e5f7c2759f8695707fe9cf1309a3c0eab6364916c92cbefeaf454ece599f98372119cf12dad0c3b719750cf258f88aed0c3930b3d9d9264d970fb66a58665874bbb0e3b1a4acca90789e43cc27c15703714273afd91426a1655f51eddb6cc5e852fe3491514249647d236980183a0a98cafbb4cd6a43f58619bac4886941886fcae3f4fa8e5025fe793eefad3eb5f7248f9312aa9c9efcd31290ca64efbb0797ed08e39e01f934772606e59f0cfcaa8287f7e37fdd36f9dc0b3ec672fa671dd2ea7cc159430f0038b14e5f098844303073186f5779e1b49b271fd08d1c11c57a7c72dd73a83b67cd363899f67c8c864add816799b0a589f60ca1dc57d11adc84a450b776670ec6060d86593e96793bf74ba1942404a671227f8aeec2aebdc444389d4ad544e1147a90f976e7f6937bc163eba79943d7d30cb7478f93373064c1c7c74bd18da9d3723b06b956530fca5cbbd60ac90fc0c12e81a2ec131d160419be23868415224a2a3316f273d9c5a1333aa64541584abd0ec293f81b530f1a97d1972f7556302f89ecc0a25a41f73d4e56a14e3c3b53e04b77756222d38af3c3e8fffe97f13046a50592cf556c9c6219b7d7a6a2e3e430462e0c24e890aaf971e989d1a93a2062fefd95ccd63de2cb4f28d0d49c2e41e3226ee690e8c4fedf65ca42db2620cea09409ccd55af04fcf41ee3d03aa7752bf397ff1ed13fd2c63ef938d4571136c0c7f4d1315980d94e45ac43484327f307c1e2e091569fa9b650ddd772a6c896ee948d42671671f25fdd2463dccddd4665e3ec9c4fee90310eae34e3825140eb54e85581cf11ded2307fccd37ded30d5be4fee7da6ee957e2fa473f91795dc4eca35297a074a09fb07630f2d4994363c45e5751555712513689f159781cbb6b38af24e723f532ad4afb1fb6ce3972ec10f75094b52539019ab186ca1af3d9dd7940209d0051d8580e9ddb777d55793e18f6987895778f2fddaf8eff0774945c46971c7b8fd3d041ee459ff890bd3897e1acb48395c29a3d57f28942ae1965f19af1aef77dc3132e0ee2f3306e362fd235c41f6b3e02e608e0864b83cd1a4b3625110e4ef76d8cd1679e6f330b5d19c4aba3ab7a95a345e3bb32dfa1410fbd54b92139f3d25394f312d95618a5abb018cdde90fd9199d18b57b3b5d36c51980ea61c11eb35e6fc1c272feda57e3265ff1f03633854aec214ed651f7829369ca4e4f1aa2c3b8d56bc5add0e1a438d19e8c4de6cf77d1601486ba6261d06ffb34279019986622fa02233b2032ec0fb17ccb36b8e216bfa89a1212ac0c9ef7988a41435031ca52901f293bbf706d8f1cbeae894fdbe8a2065d9dbd396bc47db431e8d2d734d5fb0efae14b5d590ea51c6611dcba88ef9c1c5e93cda84e22f71e5ff33a096c63678c6d54f4f49c70f159e128a949ae22c1eed7b2fe424a697663f772c3b9a5e9aba9c3c59894cec930e0be640efbed027e848d017dbd3bad435a604173cab87f16de075ea18732eb3ade153acd77d3d582b7144e9924a080eb058bb6f7357bdb4a3fcff9ce159a31a4b0e8dbd85223f3b3aa9da54e9adef72ba89140d1d6fb81a35573b71b1f1b2314c507147b724c4e599c470e079a6bddb66b36170fcc8f67aee9b845565a3c4b2e64aea65ed7317635462d9b8ce4e759fbe2adf4127b1d3e6378a33fc2656bc2c4d3fb2b5c8c5879ff60823c87cfa43e2771acab8124e6d584cd99f0eecc48f7d696c80616dca1ef6969a828f2d9333f744f5083ec1be9b6218663ebc6ae1886f3aa428f93cff94755ea961a517ef03f5fde44f04f416696886b1eedacf6f2bb4b05f22b24a2b51c5957d7c037914406b0a7db367577124e723471cecdbdcc443475321f41105d696ad34f8c76f3576d9a23934040aafdac7b502f5e0b491cdcc3e9ae70acd400177337af34c060ec216df4645830f26cd3a9698f719658f45be5396db5a9dbe98b8b3db6aa6ae1567aa6f54338ec3aef83d2e3ee056528f3444f316b1390b27c31876bae87cb097352ddcf683cba9c95bb0234d56034b7291d37c24cfb051868dae4d24864f9522f037752838d9a912b754bc3360c4395e21b63f5b70ab9661b6b89f189c09034c3a4658717c5ccdcd6a88324291f52306172d8a515737b90ec036d2b413d7f9f51d01f9def72627b9fd12b563f2569fdebe835ec2b70f07df7df9fbce6b062462832c4490ad52f0f5f3ca259f3dcf7f7376920cc4e30db6eebf62d33daef146d7de1ffcec3b556a781a4743828c9b78eae674e6566735ebc75803aa7f93c74923d6bee95eacb03b5e47221b14711ead945f38a59e5512e61dc7846ae4942ba2ca932c1dfda18f2ba987e1f27d17b7bf78e8da55d38cf2f40219884348a594b86120aecfa93891f54492ae9726b70d90823c0a2acb720a759b34c14d51d5f8e4ac9702f2536a0beee722603465e02a84e33524be34899aaa79ecdf45dc13635c1feea1e7e9c6703b8c4167fd2de227b1499846cec54bced344afa819510b6c8b849eaf06171bd76637f46b567d8fd5550c4461539a3ebb3b7ab045a89b8c2306d2bdf3b3ae567bff7b4f4180af6727ae6b679ccb395eddbd11d434a5c6b73b114fd000e48a2ee9f5db9eba11d9101cca050b2d8f65f3ec76baa4cd9e7ca2cf2dbdabbcac65e7f4cd9244cd511de2f1f2747f21d9460dc322602f57c7f846c6e3d423db5fc1d22930aa9b2323fc8f5e62cb84d5e715334977ddfbcd1675738caea9dc244df0e970b9554d679923e1c74a820d2f5548e7bfd93d308304afc28408d5364f2cc92348fe10110bca2846bb11c7d15b5ad05ec60ae648f2dcc3fcc89c34fa73358d350006781167b6508682ff0e81e06b7eabbed2095a4dad35379ba8daf2dc7940154ee32818aac21fdf9efaa40534a3d06eeb33109a957c5ac49788a2efec9be9ed5dca9b7ef8993c5271325371cfa92b9d937e05cbfd8f0456abb1d32695c2d3ed65dc90a6fb3fd3e6861b4b49f48c2d5c44cfa3538f7a136baf275cf8b629c6f83fa3e3420a6b3d3538e9082ce0e4448b8efbcfc3ef4f02506f5f2ad6a962d590d8e0d83ae7cd9ce755138272dd8486d9a778b6a6c8dd24a1a49b7d5a1b85c78703c8a555afaccc1f91b130192e2d86c2c8c7f9a3ad10d73a00cb567930fc3ff34b51256f02181d3cee4e70584641d6e98fa7b757714d765ff73fcceeb4766bb112d2c404fe559f26c59517b512de6c120a5726fa028715a950099a283ac9f58e85cbf66a2fc39686195759b01c1a3674cc9e2dc06241eb8c108d40a09193f322aaa2affea0a6adcbef28898faf87608e18575c029e1c9171ab29a6720a3b7e547493d9222793259f2237a6585301eeca9278f21fe85f0005e6a4fe550a27125316730512b600ddd28b3fa5e1417abecff490abb14d93d94904973f2caba0a4253554411f0d6e1f31996b50b6bf1ad03cde33ce2d6e4d67c5312b5e9cf639b7379df9c6c23d06c734ae589ae59a05cfc4b69d583abe70cef52c31be4be98b9c82445abb3552e8b317890a303a3dd8c05056d8f9746cee65b414cfef3e594b842e81ed782430fc079e43061c6875aef46f3255d1b823f0ea4b33ce86d43418be20f2f4cbd4f3507883f8ba5305f969f24743960403029198cb88dd6436f95f9a1392ebe5b9cc496fad3b1a7927c95adf2c3bc188d7873163d36ec9e742d63cfd5b85d5d212acca45ef6601b1fc5b4522b1e0e366ff2471e3e1600663efb3434e872e36070fa65904dfc17599fc58c8941ce48bcf28de5392c127df7d0f92dd5e13a82511c6bc6a468f779ee1be0b93641ee8b0f1345af2bbbda86051d3edacb50a8261bc8d7820ace2c36485f3811158d59ad515ef7d32fea044c9dcc6ea81f31eb71623ec7aac4b3d7332398ab1fe4a873a5a62c5150ebc80096296df28781fe64b4048b3a613354b850bec9547dd2de6b25e399f70655efbba5e5c1f0343fc5af3a37b4aa333657c480718cadd4527f297656af697ecea07c81b2937c54125f935414e690216e416bc8057dbe2760afc6271db2571511f126810993b02f92c499ef4f8a80697b074ffc6405633703b13ce5b71cd7202747ada810bfc98f57cd11c473298f092a666ec86b209f325c9acdeb7fe1519c0658ca0e4ec4f30ced08897a15abc157f7de1a12e2dc6d5ac04b5895ee94e54c473ec593f4ab0014dd9e6352a8b4e1ebd3692b2e7c77b565cfdb6f08917da08c91cb17ebb511b8d9547cb2f0fed36ecde27c8b407f663a83ba4bd03ecb6bcc05ecb1c5260dc5e941b8f67ebdfd18e5055e66a37d736db8e6b85605290a5f84a9318b17064c2f534d770f3dbc10296348058d97a84f083a49f9ddadcecca85c11b69b8ebc832de50b4379416e04fe37bf09450ffc57c741097ca7e92f9c6ced019f1ffb5405da204c9f61d72976b7a751a748b5af0df6c549fafd0fb683319e0a656e6473747265616d0a656e646f626a0a31382030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e67746820373432203e3e0a73747265616d0a789c6d55c16ee23014bce72bbc874aed81623b24810a21d90991386c5b15b4da2b24a61b09121482b4fdfbf5f825b86c7b008d9fc7cf33f660ee7ebcae47aa6c7666143e72f666cecda52dcc28fdb93d05777759535c8ea6ee9e8d294d39cc9e9fd86bdb146bd3b1fb7495adeaaa7bb0e4555d1c2ea51958df93b479af6a4fc13eec7e637e8f8ae3eeaf90a3dda53a74553de2206faaee6049dfce335b64b745e616fd32edb96aea27261e39e7b6b0accbb439c2c63918f752d87810b7afeab2edf5b01dd40542b2b22aba7ee4be8ba33d0f2c5e7f9c3b735cd5fb2698cfd9f8cd4e9ebbf6c3697c08c62f6d69daaa7e67f7b7d2ecd4fa723a1d0c64301e2c16ac347bdbd1fa7fde1e0d1b7febf1cad97c9c0c936e2c4857d194e67cda16a6ddd6ef269873be60f33c5f04a62eff9b4b68c56e3f50134be5537c852a5a0473195a2c6314b8c5b680c95053616a0b616e7144058b83792c2c4e942b581ccc134c26291a71811e0a3dd4ecba8bd5352848a683a2e2cfb6edb5f37086651c8da5e431b0a43a14f090b0069e105e0247b403078e09bb3efdce6e2d744a215d4f3211c7f8609cfaf10ce3cc8f538c979ff80327bfad81279c0711e22c043cd8934c802571a14f380f5c4f809d07993a8ef320336815740d0a872c12aa2be029ad751ce78d678e4377b08417e1bc8908fe05f9ca1d9f3ca58eb3248e04261f6e5f29e8b6a15f4abac60c38210cdf21f554e084d4330427a433d2d013f511c09944c489c08996e4171aa29c7ca167cc890f0d494675f013e267e893904e77978a934e9ca7123e374afadca8d0e7464d7c6e54e473a3629f1b95f8dc28e573a3282b0a7a54efddf1339f27f5391f187fca06fc697e9b272dbee649cbaf79d2a1cf939ef83ce9c8e749c73e4f3af179d2539f273df379d2cae7496b9f279dfa3ce9cce7492f7d9e74eef394729fa754f83ca5d2e7299d5cefccfdf2dd2f1d6f135ed2ebb3575cdad6be88eeb9750f1d9eb8aa36d717f9d49cb0ca7ddc533efc7760f49207ff007a6eaa620a656e6473747265616d0a656e646f626a0a31392030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e67746820363936203e3e0a73747265616d0a789c6d544d6fe23010bde757780f95da03c51f24810a21d90991386c5b956ab557484c371249500887fefbf51b13ac563d104d9edfccbcf10b73f7eb753bd155b7b713f5c8d99b3d7797beb493ecf7ee14dddde55d79696c3b3c5b5bd96a3c3d3fb1d7be2bb77660f7d926dfb4f5f0e0c89bb63c5e2a3bb27e2619fb51b781823eecfeddfe9d944d530b39d95feae350b7130ef27b3d1c1de9c773e640f6156494f4c7f6e7ba6b9f9878e49c3b60dd5659d7608c7334bd4a61d351dca16eabfeaa87eda12e12925575395cdfe85936ee3e90bcfd3c0fb6d9b4872e5a2ed9f4cd1d9e87fe93343e44d397beb27ddd7eb0fbafd2dcd1f6723a1d2d64301ead56acb20757d1cdffbc6b2c9bfe38e38df3fe79b24cd2bbf0bacaaeb2e7d3aeb4fdaefdb0d192f3155b16c52ab26df5ed4c729fb23f8cdcd471f91c0fa5e395030ce23501463840a09a883d9000408af0292607b000a009c83800d410b9071480c2c5527820758044ba5c106a320048978600aaa1d05681c1b90230437a4c5df80cc262b063749149021d0918a96724606874d18b309cc65c4684e18c02300fc319a41b138673ea1c9087e10c6a643c0c974900ea369cbbf5f17a67f3f1bacb7fbbfeea0c570ba471c89092a32b971e9f23f6951606f1ccc76bc4de020d0d2e8962aa739d8f72e91685a49a05e105e616c4e78662ef6d8e58fabe844bdf37c7b548df37471de9fb1684fbbe6e6217a73e260e6acad890b5e4759c81afbc1912fa95f131dc5699f795e2dce305e2b5c7894f7524d59f717f57e81b532f25317b5cf81878421c2180a7d44b286848a99754d096e69e83bb4aa90ecf81cfaf7602d7dcebc13d6b11fcd232f8a555f04bcf825f3a0e7ee924f8a5d3e097d6c12f9d07bf8c0c7e9945f02b1337bfe8cba22f09ff6ceca1dbd2282f7deff6092d2b5a135810756b6ffbecd49d90453f5a84e3e6c5db4b11fd07a3fb83ce0a656e6473747265616d0a656e646f626a0a32302030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e67746820373430203e3e0a73747265616d0a789c6d55c16ee23014bce72bbc874aed81623b24810a21d9099138ecb62ad56aaf90986e2448a2241cfaf7ebf123b86c7b008d9fc7cf33f660ee7ebc6c27aa6cf666123e72f66afae6dc156692fedcb5c1dd5dd614e793a9875fc694a61c67fb27f6d235c5d60cec3edd649bba1a1e2c795317c7736946d6f7246ddeabda53b00fbb7f337f26c5a91372b23f57c7a1aa271cdcb76a385ace77d3ccd6d84d8db925bf4dd7574dfdc4c423e7dc16d67599362778e883e945079b8eca0e555d7617316c0f698190acac8ae13272dfc5c91e06166f3ffac19c36f5a109964b367db593fdd07d38850fc1f4b92b4d57d5efecfe46999dd99edbf668a082f160b562a539d886d6fbafddc9b0e97706af94b78fd630e9c68254154d69fa7657986e57bf9b60c9f98a2df37c1598bafc6f2ea115fbc3484d2c95cff115aa68152c6568b18c51e016db0226434d85b92d84b9c511152c0e96b1b03851ae6071b04c3099a468c4057a28f4508beb2e56d7a820998f8a8abfbbeea29d870b2ce3682c258f8125d5a180878435f08cf01a38a21d38704cd8f5b9ececd642a714d2f52413718c0fc6a91f2f30cefc38c578fd893f72f2db1a78c2791021ce42c0833dc904581217fa84f3c0f50cd87990a9e3380f32835641d7a070c822a1ba029ed35ac771de78e63874076b7811ce9b88e05f90afdcf1c953ea386be24860f2e1f695826e1bfaa5a46bcc8013c2f01d524f054e483d4370423a230d3dd12502389388381138d19afc424394932ff48c39f1a121c9a80e7e42fc0c7d12d2e9ee5271d289f354c2e746499f1b15fadca899cf8d8a7c6e54ec73a3129f1ba57c6e146545418fba7877fccce7497dce07c69fb2017f9adfe6498baf79d2f26b9e74e8f3a4673e4f3af279d2b1cf934e7c9ef4dce7492f7c9eb4f279d2dae749a73e4f3af379d26b9f279dfb3ca5dce729153e4fa9f4794a67d73b73bf7cf74bc7db8477f4faea15e7aeb30fa27b6cdd438727aeaacdf53d6e9b16abdcc73de4e3df0646cf79f00f2b90a85a0a656e6473747265616d0a656e646f626a0a32312030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e67746820373230203e3e0a73747265616d0a789c7d544d6fa33010bdf32bbc874aed81c63684982a8ac4a794c3b65553adf69a82d3456a000139f4dfafdf0c4956abaa07d063fc66fce6d9cccd8fe79d9fd4dd9bf5837b295eecd89d86cafad9cf7defdddce45d753ada767ab4b6b6f579757c10cf4357edec246eb36dbe6d9be9ce91b76df571aaed99f53529b5ef4d7ba5601f71fb6a7ffb53351c9596d2af8efe78eaede04fa3f225725e9be9c371bfa309b726be5c1354e2971dc6a66b1f84ba9752ba40d1d65977446fa3b798f589c559f1a169eb611629de20d9535ad44d35cd5ff4ae8ece2424ef3ec7c91eb7eda1f3d66bb178718be3347c92e23b6ff134d47668da7771fba542c7d89dfafec3428d90de66236a7b70859d378ffba3158bef1abf505f3f7b2b347d2b565975b51dfb7d65877dfb6ebdb5941bb12ecb8d67dbfabfb51567bc1d666a006a10bb97940e7b6b133a6c96eea5a54620012351140897086804124a71d8050a87d315070a1748512f6586c32e9021507020235d670551745654fdd90fb37629236c2d156784c021d737c09027759e03d3be3a5b01731f49099c722ef133e6a7c03975a2128795660ccd2a8267514e78457197e6b0015631f4a898319a56e595a3a159871a71cd3a35346bf644439b861d5a2bc219c729975dd1d85773cd10b901383ad0b02fc83917f58382e3d01f525c51fd907297197a5cae381e01c38780fb5de68c8953702f0ab8641c381cfde37f449c2842ae91ec21fc34eaeab9d1d7b33001fb8fab84333011fb0b1d863de53b66f87aa11fc39e4aec6d92ab7726bd5e30437eb1ef86cf2f816e5330864786bd4bb057cce79aa04e1cf2bed017b39e04fdc7b347a819b39e003563be4329d5213d45805ee294f8d44b3cfb8e338b49c3b2a038fbc8bf0d9f7182334e984f679fce7b41439af2b9c2df74d60f7e1e516e0e7ec9b85ccd7f0dfd25f8af31932e93a33a0d831b2a34b86848603c34adbdccb6beeb91450f0dc5f368c6d753e9fd05217c8cbc0a656e6473747265616d0a656e646f626a0a312030206f626a0a3c3c202f436f6e74656e7473203220302052202f4d65646961426f78205b20302030203631322031303038205d202f506172656e7420333320302052202f5265736f757263657320333420302052202f54797065202f50616765203e3e0a656e646f626a0a322030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e67746820343037203e3e0a73747265616d0a789c9d92c94ec3301086ef798a39a6071befcb1110454242029103127008256d839a04ba50faf68cedb44a1027a42476c6ff6c9f87c102185c67ecd77a51646753c98073eab51650ccc16aca0d072f1d554a43f1064ff9b3e06cf252dc9cfccea6c20d9d706b99c2a3283f9f10294cfe351136af66db6e9dfebb79586dfe56cdea4dddb547955679b9aecbd755b549261272615d7294c2600e79caf1d86b2c58ea2de351c2a8d11a1495d2f585332693705cafc25002c840497ff5378642b873d4090d4428aa98ff1796dbf2bb6e02935d93fa7c669a35757b34e22f1f3259edaa2138936f975522d8bd4e082ade116e9d2827c17cd7a2a56b53335745c6313736021a21790fce33ca848159937d02567d0db1f48c51e99d863d047338a13632dd872d46c0b7814c235fa184b6d1b082ec01b2fbf8b4f17b4c46fa6c64902e0e9af04338a832e034a7c28a04e8b2c33638cec75f57c62dd51a8372bc00658e0e1fa1fb03f92837db9ec12158ba5d3f73330c19472e815b56eb6a7cd320b8a42614cb3d3556a5c0772148b9e8438a910762fd01aa60bf130a656e6473747265616d0a656e646f626a0a332030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e677468312031333738202f4c656e677468322036303630202f4c656e677468332030202f4c656e6774682037303038203e3e0a73747265616d0a789c8d750554d37ffb362d4e90060965748f4e91ee900661808e6dc0880db6d120dd29d2204a2821292022252d82b484480848888474f39ff13ccffff7bcef39ef7b76cef6fddcf775d7e7beaeefb8d80c4d849461283bb8060a8915120589c80155f54d2c65802222e2201111310017972902eb02ff6b067099c3d118040a29f7bf00aa6838048bb3a941b0389c3e0a09d4f170018a8a0345a5e444a5e5444480622222b2ff02a2d072403588270206d407017550483806c0a58a72f341231c1cb1b832ff7a04f242f980a2b2b2d282bfc381caae7034020a4102f5215847b82bae2214e2023441411170accf3f52f0ca3b62b16e72c2c25e5e5e20882b0684423b28f00902bd105847a0311c03477bc261c05f0303ef425ce17f260301b880a68e08cc1fbb09ca1eeb0541c38138830b020a476270111e48181c0dc415079a68eb010ddce0c83f60bd3f0041e0dfbb018a8244ff9dee6ff4af4408e4ef6008148a727583207d104807a03dc2050e34d0d00361bdb182400812f60b0871c1a070f1104f08c205628703fcee1c02d4503602427003fe1d0f034523dcb0181006e1f26b44e15f6970b7ac8e84a9a25c5de1482c06f0ab3f35041a0ec55dbb8ff09fcd3a23515e48bfbf077b041266ff6b0898879bb01912e1ee01d756fb0bc19900ffb139c0b1404911592929095920dc1d08f7863a0aff4a6feae306ffed14fd65c64d10e0e7867203dae386800720ece1b81f801f06e2090762d11ef000bfffedf8e709202a0a8421a058a01ddc018104fc273bce0cb7ff73c62d1f8df006824570dc13058afcfafcfbc906472f180ae9e2f31ff8effd0a6b18dfd5d65211f833f1bf7d2a2a286fa09f90b8085048565212282a2a23099496960506fc338d2104f1b70d91ffc46a23ed5140d93fdde2aee95f1d7bfe2500ef5f71f001ff99eb2e0ac75a3890f73f24b716911481e2be44ffbfa9fe3be4ffc6f05f59fe5f24ffef86343c5c5c7ebb797ffbff0f37c415e1e2f3178023ad071627007d144e06c8ff865ac0ff88561f0e4378b8feb7571b0bc1094119e98023b390a8044844e28f1d81d14078c36186082cd4f10f65fed8cd7e49cd0581841ba230885fef165c9488c87ff970fa823ae3de1f181c2f7fbbe038f9fcb3ae3a128a82fdd29998a414108246437c0022383a89e1f6ed278a13240ceefd9bc94061101285c5850071330600ed5168c0afb58a03852118dccc088c336e0b8ebf9c807f14807aa0d138a1fde601aefabfcebf550d877bc3a180a97114f47698d3abb0a6a32a65662fa16f1f49e6beb644275976454962b9279ef939ea5dc9d21c715779002bbfd1976e385912313ceecfccbf7934e06ddd96133c9ba6f5148ba7deb5a8b22d94d77bbcdbe600bf054331390c4aa7472f526d3d32ba49f1004c04e6796c317e162edd2ebe52b15c78de8259b1925d07ba025f1c50b2a53163e395735bd609622dd938bf623f585a532650a3c1191ea6da6683e704b188844395a638c6639f457042e6879999f739dd5de9e23bf9ba1d9552e511348cb4be3a6cb97dc93d8c748f7274ea3178dc2a9207aa25a949ec8ccf5d23b86709215d1d5360d986776b580863ce95f8ad477b1af51a6c444acce096c9111d215880dd76d7ab1983abcec1d4a24d1b5179d0e493992d9d35de3a926f4a8016a904ff5e09fdc284a6dd79097b7396470a3daa14a4e4794cb73ff7377837b63919372b3bc0a2948438024be55ef6967f49c88e66f155ee38f4f4aede27a1a8a289885534be07378da8cca7e2666efc0499482f9b6a75aaee6724b9ee737bdf0a7477cfbbee25559a79a49ebc9bbb2bcb3ed42b6eb5036e44e4c3be10dd71d22bbe3ecd8ab79c4064102089e43009b26e17a54fd82e715173ea63120d3d282a6b4bee5e6de67ef6ed637791f59db806cf19a7ece709f53f61ce137d9b7dd7d2ee740b7f1d65b7aae5cb4f95bc48a7bff5b98930a083c1f6e37caa50a0e277dfa18ec96b618f77d0be95eb5beef8f78585a1d3f2e40d134702b3cfe3283edef7845c2859c6ce7f16135c337b1344dc51ed13e8d0ae4c5dd412c9ab42927317eb1b4ff0ea51d14161b7c830d077212c5fabddf12397242bf7e6cfeee0b2c018e210c724b12e0579994d618272b1fd910f6fb59eedaaf655cff5de67ad395c63ae89f856b409fa60d62b4034802c1a0de7c8c652254c1d2fd22512a8af5397803db691cff3903be6438e3a04b21239e401e7110499846ec9dcc99abc3f5c6396a573a688c121ae6cb67752e214d6a1b53100f6903becd73e7f72eb0eaa985cd1ba7576ae885604da3e4c8a4dbd0fae646c6ea5ca0c55f3cd6ef30464379b6c98b1dad48620a9cc057968cd21bd7922a13f1d930bbbc46d6e373ad678ed5f24b2c2569be38f5db324a37d8ba29c0d0728990a25e4bea630501d480f4648ed834843b654a49ae98cc6a21807cea68882e54fddbfb2b451c6f0241cd27c750d7c15e422ed23e2c059f33df8b696d97bd0b14b2f153f579a88c48840b6289847c5cb9240c6419cccc6f6c118d9403a55d0072652372d454e9fd09a7d23c3a04e71568733183a37ec4792e12d39a92cfdcbacd62bb2e19f543bcd590355e7ac021344408ee81b4eda9234281795a0a769efe988fd801407218f3b5dc7b296fcf319caa2a4d7debb43fc7c60f0d1215bc7437dc943a426065acb615af41af498f185ff2e9831cd70663774a5d15c73b11b9f3a245fe73355b5bcd74af04fa46c0ebf937e1086082c7ffdc68d4e1b1bec1aa68030cfc8e3d8ef894e40e963d28779d465534fd88a57dc5eae84e99792489a7df410c453884674e0831d82cd941cfb25e120eb8679c023dd633ca3226329f435ab2f311c673d7debbedd27a61d7b6cf291fc3ef4362a9379afbd4ffb448aefdd6a2274e7b46af978c49a0bdd239d2e2aae2d4cfc5ae279552b284b943f91a02d09fded3c72368c27e42ba16db3d4f8a045df406b2af506b9b5a5eb4f4b63c5e73e8d596c9a404918575e32d50fdde97dbbf1cba2fdba5760422d02b9014da6da87409bb34e82a0d640bc723dc6ac6b7ba5d0dcbba375712be456c185be4364a2e0c3db124bc16eb6ab7577b7dc4e4bdd55d480d4143c93d147d3743cf191b31fb303a9ee251f77c63bd7fa172e6be21119a5761bd606ad7d3eafea546796886ab54da4685e6d18ce889dbf73e9cf356335caf7204601da115de89fa1b3dacc77dfc52b9213ccfa6d2bcffc912955e591d4cd287b1ac09bae3b5f9e3e213a235c5ce44f5cf84686702bd75347033a8d154396dc533cb1cd43dbf129d7d026d70fb34c7739421b27a8cb8e9b459652fb99ce1d0a6bf56dbe71f9dd74a06929ceb07ccaf829a21422be40984d6391f3a6af676e47ed59c98420f72b47b6eea9d092e8b8c921a60df74b5b60353180b94ef7945c79f139f14369f3beb1b1ae349554ef43d290915e227d3531a96196d3a542269f2a54e61bb9dcf001b6c8382a76b545e06d1a578e9dddac761ebcc64c0b550083b50f86fbe690737f805569a0b2e6ee622c4383d397e3e0a51f4bf311e9c607c1ac9515db6f5cb7b9135fbdeab6598f7c81b4080db9d1032d587a2ec9dd745d8afdfc72e2d1da81da44c5c1a9c88bc3c9e16acb9f4fa939bb277ba72b7277d4e815bca68ccf827b82ac22216f7369bfc9742eb619628aa7e5f88ee2d89fa94b7d94e278e3d55eecd0f4f0289733605aea4c1bc35c4ceeda2563fa4e37ac9393842f797ea43d94f7e29ae536b197d242478bb823b8d32ca5bba1f92a4744eb5ed80159921d34b31ec0d7c2069abfd9c8b4fa69d822bcfec1d7180ae800496fbaf26c7b0827a15791e28dcdaa687a65164001e74949590255b9413b499dd20a546124495decfaf4b876b6cd6be3a59e5681f7491d7a19f67257f3453157990d5a24111640bd995ec2735a7b792b8a94932c8d1422788e560423cf8111e50d2759eb762ff789a74f67a89e0e1d2c1db8c3bd92c3599621995b712aa029ea5b8bec647cc61d9ca2ef721725be463fad087f5e912ed77ecfe37c64e965d5f2bb37be751aec2cd38decf4cf7986cdc585bebb214c0e5b850433872e047fd6d8848530a7457de45d245210f534bcc52de652c812b3e3462fa64d7f53f73c4f8567da4b33b49b29f2413d3a453b75798f3671087cba59baabe7f4897775d38780c48e0e5e9166d83eecdacdbbf5aa31fd36bce9890d56266799cd8c33722daa0d8252a5f73f0d451347283a49363bba8a0dca18780cd5c15eba7a56df4fff59cc302bdafdba06a29ef98ad66ee25a3546f0d521543a25c267d2908966f2302913726fbec528cde029efadd8be0b8a3cef8358e7367718b391f431d4f327a0f811c31ea94d93df9be472f9e54172ff9b0eab8cebbaf7866ea18addc23726620aaa02c7a0bed9537ed41d16246460b9e721c6456ca93af97b22dd046e50d17ce813954e735d4273b66c52d3f2f66597d0ce70cbd72f28b509a84e63a35c5e7ff7e18f16bb3afa7a5827f80b3c02d6b42ea53a34cb9b5c617578f2554f76f4be1215a3a5bbc2b34046ef4ea29bc2b9a9abf9e9065f64722a4b6f91b02b642d9cec0595959ad80bbd3208e2a1b9c1adcf60996d7cf60166715651b3cfc69cfb6348e94078939a2d8ae061b7fb438ee27b5d422d1e9a4f1ae247b0734fb7103f8904db10dc78a87bb5b23f05200a186bd103a308605c5ed2e8dd998def129de103f05411adba85236cf6fbf91fb1c9ad0f6857b400448907b72b071f5ce6949745a84313d94ed329cbe61e491952ad4f1d7ca4d3e7a8c89361ca7c3868d186ae6d7d4773e4e041efa1aa0eeb18acd834e51d5250cf3801492dad3b5e49a09f159f29d3437180791a6817dbece213eface29b2894ba4d86a82f16c6dca29248fe3cd6749f831f7cfbc9c2cab6d647a9993387f2b317a62785b702968637227dfa935de65950b1cf9393e41762eb9bf1b4e70ba6ef641aa10606224bfc61c5ea27ed3f78e216f993cb6c1c1ef405283d3314214e0c2a350dbd42965a5e2ce390744e2007dc4f185aaa1b7f25a436239d7f3cf291a07a4a97e73adbf7f1073b41adc7fae991d62bf50532a8b5b07826e1b68b267bcd7dc789c596a8a4ea5ca3a0bc0472ea4422ba8b2fbe850a677daf07c2b45a93b30a0fc0c81092c78d8416353d44d3e5050f31aaa0914ca52ab393a66a7d679afe4f02cf1c76e7220f9c6a961d8cf054f1eadc9056d391d673c5be55b62882c17ac96179b3960586e1f261f95be4c6b6f966b83fbcf33ec46e39b9aee6715dca07bff428f635f090fa7e768aad2381e0c69936bc208e9b9a0dc9c0197cbe6bae60e3b5dd72c596bd7c91bb235fcd373f66d2a574fc9c331c06e5ece48177cf0506059741347d2c95efb84795dc23cd95d6358d52fcca673bf5d2dfe0907749428c750279cf59d6eda7faab3b068879e13a1f490199951c295d0bdb2829cfd26d65ccc232d3f8509af0cb8e86f74519b5ccc6debde186ce4a9b6a720f3fe912b3dc074ae5ea85c1a7a2c712298cc8f3547c7b39f5a24adc0334cd62d21d1691efcf005feb4f57f7e7d44d37e4b7fa3c4fefa83c454eeea18b02d8010411cb86f2a46f6733bf1ee6782886cdf4eef219d21dd8f4adbeb0cb7e53d18cfc1af58de1e6f384917d7ce6b989aeaed23d7a5315b7d11f00b16014c6c7585a92518d6a785fd740e6a4826b43dfdaae7b76b5e973578b6056fd117cf51a9b87e74b4c9a5f290de690352db662caf25e775b8980e672105e810395a35afa00575d8db2065ef26331f64f022237eb6873aeb51c872964164e1c911aaf2cc953788d343df567f7ecc1333e37dd18045c5ca6d3b85e345e61d0b892feb4e16343a516f3d9f861764d3cb59ada979a2ec5371945b5cf3c39591b17093b19f6c145934b735a2396434cd6be86971120447d68326f7dea69c893b1a431485396346df5bdae1f0b73e297a7e2d579f1cad4a6e390eb95b63ee972f6281f3301af0fb7872912975f5c8b6843479886804f1a3325e80e6958ee3370204ece3d2d556edebb3dfee3ae53ae679733995cb8e9e2745f21c1f54bfa183923ebf7fed3e48b519fcd42c52bfbf38d10f8fee411f33a51f98beada3d751082598706c2f061085f2b1535d7baf0eef237b5ebcf150306ad88afd61e2874a579e4dd0f69927ae3207875b1a141dfccadab8f49a81af4b928dcb540c6b5e0d58598acdc2964d36fb4ba2c70cf6b70cb522baf6a3ebc363964362d2f499c43b2512f0c45eb6cc661913008a549a16b0e513278c449807e4af2a5fa49656baf1087db5677ff8f8a749d525a20f58a3a1b69cda9c0e4a58465c6e7411e21096b5b45fc19fbb4b835f24327528e47298d2e5e7ea92586833416a83adf9cbc50c22770ee7da56ec10272f6f683f368324aea41f4068009f616ad8dd66dfcc698d2fd535cf874e05131987bb1595c069441c8adde9d56d5f4d0ea22c82408146c17fca3a17a4309a02235e62d137ca78efd2c2f397932a8df5f5646c2fc6dc78edecbf8e8c224770ad6708fe3d3fafdfb62c617677d0f108dd3b781f3a7224aed0e47bc22fc9d43514c2fd65af39f9fc4849d1f58632c246c43cd3ec84d5c4f14a2cd540e84c6447454a5ad7fcd55667a48a14b947c97d8043e60b006a57d1202e657ca580b2de39b0fa8f5b4f5cbba410428e86a6fcd7d52ff0032ecbd42a100875b86afe74490fbb5711998ab1f2e4624adbaed0ba2e89152517d0a2dd7b7290388895ed2d9eebab750b999bf3e3763a10550f75c4de8796fa23ed4878f7e47baf9dd04554148162199a5d3b5c7879f46a27b241d9b28ab2dd45dc7ef72d6c9996f5a127701a91964c03a73fcdca3e4da957455d187d10e4ca59e24ca96494179d2cdd76e0b5d968ff5a41e0b21e8e56ddb57ec280db47aaa421699920ade807b064d968bad16a2d6999490cea5b082e71a3b8a9d67cc12782da913b9720e3f498f9214a2a936ef545d64fd709dcf672de8ef4bde2c0fef0d14927a29cd089bad3ee5aed785e47482bb0cb82457231c07225ac7fb8d370474e440e4d3368789b1fc30f5d2f9a890f7b5c9e254c239aa0e077e4c898aced8a3b24733c9b15b24dfb06d7b8f9b3e734abdf97c68b515abd22c6b89189bd815bda637701dc33d3efaaefebc65e976a4cfd887381b16c67796ac113c57a5f7df0b51bff37433b86274c80eb086f8bcfc3cb0d163b3fa58a5bc3ffdb646f439a3cae24155cbdbfb169f62f2256c39d7676f94b0576f6497ab34a918b38d42c9193218a1212b539aee7d79879e05a10c576cc61ed6743ed6e2ef9705a4b5daf490a846778de70ba57fb93556623ce004fe74c339d8f9215d195b8a303bf1da58f211be68941b33595cdcf95ef493ed5e732efc1daa9780e38996fb06e2244bfb13225afc6a8f48178af63e80a4287c3948304efc43d36cbcef4702cae3829a38b49a4e3d1342767d03122a89a9470baab49ea49a7fdcbb085ac13b26c676ddfc302c0862137099cc311e7eff050842099bca04a5af451a5d9ec2157cc16cd68f1f642cca389baabe480efa61fbf039a8b3a926efe0c761111a54058de45c4d8d5ed4cee37a7ff664bcd8e95cb9232ecb6c3bb591b3804d4930c0983d98a2c2af7586ce4fd0b93b5caf43acb1764be7c05cdf428c981c5f674939d1deffa6dc0bed4e6a15ba7efe1b93c49a1d18e23c46b59119414256eb87a09d60d909b56795e04e1ac634e86bce772cc402fcc7bbdce3c0875efdfca4f7417a1e56ef2af147b44705f346d47ae84be9727e344585c9cf024227b2ebda8973fb1123f75ee40d2d4756b60bdb1ccff7f94f186136eaf902512901994b7906025fbc6c28eb1968a6ae7954963d2bae15ce07c82b05135895bd9fd9505619dcd2f858db8fc1b216ae280f0490d2bfffde92225b2877344b7e099b2dad3cc189a6fddc7c67624bc94b0cda011a796dae6bc2ec4d756fc0acbaeeea1040aff1d2ab738a6e2ee02d847623eb03ead3966ec607c7770c4782270d637aa6eb6452576c3faabeeddde35d8187f764da716053093f6caf9528f2b8e607f3c0b12ec4eae25e5dad7a19b1d2e2a130bd565d671e8fa4dd7182053acf9f0d52a4c57b277a36f8b58429ceb20f15d9039ab898aba401f89507b2ca10093cc6e123c282c990009f3ba71677cae63d182fbf9d90dcca9fa03aeee77058c99966e06ef5788229b6d4c64425b607c64ba2794d363984a1a6b7485417cba75fb30ef6ded99769c3af32b81f956ee91d3aeac92099c25944b69701f0508e123e5b53e82feeaa80a011f4105bbd59abfcbb7bda94750a45b6dd65416b1902519417a411d564fb82c4fe852f15f84897db06ecccdbdfd67ed7d6ebf4d0fc21d79eec03ca975010008c5fd0747d0ac84ec1f3addb6cd2dbbe73411ab3e99542166438b3b576c54eb969b7ae88042ff39a52e8bd6676945f75edab77a7dde2268616f393fbb2e64eed3394e079f53d968c1a8a8a4088cc3bcb938ec7f1c3d75edc90a125aa0fd491ffe9d77e72a35b3cefd6bce939bbe48f3028e5e4b6f2771afbeb16759d5730863ef9c9456d7633544305a32a0e7c142cc9ba03a01039ed95611ba3b88adb3ca1df3023ec051c5515cedbde2fe55f3fab9b9e30b8fff913ff8ce76b58edc6f287cd8f3d856bc10b3d9bd18cfc9ca222d2847703d41f1cabe029714a8d5b1c8cbe097bbdb0fc13ad71dbea9b9cb13a55f92d4f98e8cbfc00ed378611a4defeeff31d8eb1aeafdad71aba7a8ccdbe98bdab7be709d2237d51794837962769a5f2f8863dc1fe0e79736fe424ea7b1d392787ee0cecaa0a815b5cc28b9aba47c1589a9699eb61988bebb9ee4713507204f915c6d98c7c15d7dbf4921348e97aca7b470dfe4cd169a8ce99c54ce7933de80b0f354a3a2317fc9bfbcdbce6a13b417583813c5f0c1f93051f87690c6be9d1079cf65b2b335178bcdc4e2295bf6d1dbe2d947de6cb072b8ff21da9222dd7a4e6f3f6fe9cfb28ce0cdc2148e7131b3c1456c1cc036e3e5d72edea6b98ae22acf69fbb67a81ee967578432f2160f7d97dc336379a07af3287f65876ce78e94a9ebb77e37bbd1747dad903ceff02aff1d9d72a786f8d1d51dfcd6dc8a1562f25570e5711999c7ee4b9687b623856c2b14897372e47745f62e9cac28b7856fbebf26a29f3161ed86e1255458a3a405cf0f19f69b5468341dbcd0042b271bb4be90d8bdf4e6b48805ea2f69441c392c942a52764c5cd9e58b69488bf31a2c3564a5e5e779d1483a06e468d0b325ad29c6eb993ea2297115f7922b1bc3e369dd3152ee8e77306dd99e6b941caa64a1abf0d41400155e6ab5b899ead3aa6dda6ebb1ac5885be9c7b2bde62a206b2680531de77d18694206f3467c5d0f1fb6ca14eaa3fd907d83c8966a4e63b33cfaa6b8c13197daf48affe0656e8e41ba44477236576b0d654970c753fbaf6a79cccf272886c9f44cc84d3a4afa1bc6674feba7e9d37e0668ffb8f0528f59df990b1e99be0c8c510e2ac2cf3cae261c58b8b2df4e9c4ad76eab11df3eae9236277d4116e69fc2ce357e1d7eeae4d2b16a7f08e98777cab28c52b8b4351acba14db49ff19b15933c836ba6db1f2e5c6f97bdd4a1cffaf43d364d68c26e43d1a5b3508a41d3ea49e1e31bd4802af9dc08ce2f752ebe98f132c6d2de89c6d96c81bb170b601116a31d8bebc010f063390d77d04f21c00aad4d8bb76cc84baf0c49152bf8e332f957dc2606f6df6daf944f3ceb77b0241913d629e17015a3488fc740fdc72a497a4f4059138569b363cd98cf21f871d7d221b3dfa5461f9206e719dae92bbfcd7a36d4244c1a4ffe3fc4fe99a40a656e6473747265616d0a656e646f626a0a342030206f626a0a3c3c202f46696c746572202f466c6174654465636f6465202f4c656e67746820393030203e3e0a73747265616d0a789c6d554d6fdb3a10bceb57b08700e9c1353f24522e0c03a4640339f4034df0f0ae8ec4e409886543b60ff9f78fb36b9b6d91438cd570b93b3b1c86779f7e3ece7cbf7f8e33f3458a5ff1b83f4f5d9c35dfb687e2eeaedd77e75d1c4fdf63ec637f5d3d7e153fa77df7184fe2be79681fc6e1f439253f8cdddbb98fd7ac8f93427c1dc69c823ee2fe29fe3beb76c7f77af67c1ede4ec33893c87d1a4e6f29e7a3659130f1072668cb3f713a0efbf1ab505fa49409588f7db3df61866331bff010f32bb39761eca70b19f10c6a85d2a21fbad3e58b7ebb5d12039b1fdf8fa7b87b185ff6c57229e6bfd2e2f134bd13c3cfc5fcc7d4c769185fc5fd1fccd2cae3f970788b602164b15a893ebea48269f6efdb5d14f38f06bca53cbd1fa2d0f4ad9855b7efe3f1b0ede2b41d5f63b1947225969bcdaa8863ffd79a76bce5f9e59a5ba75cd9a41fad17d5aa582a9d626508a82d80124045802d0158000e80f71b001e40e02d1a00eaa996b778006b001b021c004d0d5059ab8501400d2c030e00d52362aa4586410dc3353c78942ac5157a4b99e2625921a3e20c8d1a164258c55b40cc62384bbd8d040f0b0ab662a006003dec02805b0370e0e41c0b842e0e8b0e6db5d432011e80f759428fc93df3a059021a049b350da817eaac69408de0b3a60135c23a6b1a50af9159d3067335faa6693aeceba9d6ea7acadd7fdbe96208ad15ea48458205f0929ae296623e72457149f886623ef9062ca5e5bd9041b2240a4723e9a865db2226ced51a63ca0dab449e600e2572141f89451dc52a9806f18273a0bb96ec0528ac15c7a8a335c7d8ab99434906aad92a94bfe098f23dc794dff25e70d36b8e1788f9ac14b819ea2b0df61ae699dc9b62569a4c62582b19109389ab4016ad38a63aa4953194cf334a70333ca3a47c36afc7ec86ef8f84810cdb5e11ce9c15f897ac89414ec5f91a56a8f8fe6acc52f1b5abc1d9f27939f0b48e6370b3dcd7a1bebdd4414dcb7dc9c496fbb614af29bfa27cd6aac42ceee22b7070a4953730afbb6805ff38d64a83832bf94ec04b8e7d4597dfd5ac03e507f618cec8111f6b29a7e518e7e2d61cd375dc700c3ef56f9ef192eaf00d55d9ff5e67ff7b93fdefcbec7f5f65ff7b9bfdef5df6bfafb3ff83ccfe0f2afb3fe8ecff60b2ff4399fd1f42f67f68b2ff1b936769cadb8c74cbe956e39f3b1ea2dbb3d19da729bd28f45ad14b81376218e3ed413bec0fd8457ff4125edf5d7cfdd814ff037389e9510a656e6473747265616d0a656e646f626a0a352030206f626a0a3c3c202f417574686f72202829202f4372656174696f6e446174652028443a32303234303931363039313134305a29202f43726561746f7220284c61546558207769746820687970657272656629202f4b6579776f726473202829202f4d6f64446174652028443a32303234303931363039313134305a29202f505445582e46756c6c62616e6e6572202854686973206973207064665465582c2056657273696f6e20332e3134313539323635332d322e362d312e34302e3233205c28546558204c69766520323032315c29206b706174687365612076657273696f6e20362e332e3329202f50726f647563657220287064665465582d312e34302e323329202f5375626a656374202829202f5469746c65202829202f54726170706564202f46616c7365203e3e0a656e646f626a0a362030206f626a0a3c3c202f54797065202f58526566202f4c656e677468203335202f46696c746572202f466c6174654465636f6465202f4465636f64655061726d73203c3c202f436f6c756d6e732034202f507265646963746f72203132203e3e202f57205b203120322031205d202f53697a652037202f4944205b3c36333535356363636563386262633030666566623566616465373166373231633e3c35623666316161303036386563663530623536303035363534623236396339303e5d203e3e0a73747265616d0a789c6362000226c6bd0f19981818738104d37d20217d0148b09c01712d1800577004f20a656e6473747265616d0a656e646f626a0a2020202020202020202020202020202020202020200a7374617274787265660a3231360a2525454f460a	5	\N
3	message	Требуется ваше подтверждение	25 февраля 2024	Материалы для стен	\\x	\N	1
\.


--
-- Data for Name: paragraphs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paragraphs (id, title, body, post_id) FROM stdin;
2	Качество: каждая деталь важна	Одним из главных требований к аудио-визуальным системам для конференц-залов является высокое качество звука и изображения. Важно, чтобы каждый участник мог четко слышать и видеть всех других, будь они в одной комнате или на расстоянии метров.  Для обеспечения качественного звука используются передовые акустические системы и микрофоны с шумоподавлением. Важно учесть акустические особенности конференц-зала, чтобы избежать эффекта эха или потери звука.  Качественное изображение достигается благодаря современным проекторам и дисплеям с высоким разрешением. Это особенно важно при проведении видеоконференций и презентаций, где каждая деталь имеет значение.	2
3	Комфорт: создайте условия для успешных встреч	Комфорт участников встречи - это ещё один аспект, на который следует обратить внимание при выборе аудио-визуальных систем для конференц-залов. Удобные кресла, хорошая освещенность и климат-контроль помогают создать оптимальные условия для работы.  Кроме того, комфорт включает в себя возможность быстро и легко подключить свои устройства к системе, будь то ноутбук, смартфон или планшет. Важно, чтобы ничто не мешало процессу обмена информацией и идеями.	2
\.


--
-- Data for Name: platform_news; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.platform_news (id, title, date, label) FROM stdin;
1	Технические работы	25 февраля 2024	В срок с 25.02.2024 03:00 МСК по 26.02.2024 03:00 МСК на платформе будут проводиться технические работы по обновлению сайта
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, title, post_type, image1, image2, image3) FROM stdin;
2	Как рассчитать стоимость через калькулятор FIX-ремонт?	blog	\N	\N	\N
\.


--
-- Data for Name: project_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.project_type (id, name) FROM stdin;
2	Строительство домов
3	Ремонт квартир
5	Новый тип проекта
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
1	Монтаж пола	\\x	t	5
2	Подписание договора	\\x	t	5
\.


--
-- Data for Name: works; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.works (id, title, project_type_id, deadline, cost, square, task, description, image1, image2, image3, image4, image5, video_link, video_duration) FROM stdin;
1	Дом из кирпича 560 м2 на Барвихе	2	15 дней	2500000	240	Театр, специализирующийся на разнообразных представлениях, выразил желание усовершенствовать свои технические возможности для привлечения новой аудитории и создания незабываемых визуальных впечатлений. Заказчик искал комплексное решение для обновления мультимедийного оборудования на сцене и в зрительном зале.	{"Тест1: абоба","Тест2: обабо"}	\N	\N	\N	\N	\N	https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley	1:25 минут
5	Квартира 300 м² на Баумана	3	10 дней	1500000	300	В картинках должен быть какой то темный репорт, хз	{"Шаг 1: тестирование разделителя","Шаг 2: надеюсь он работает"}	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BMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAIa2ZQ0AABWOSURBVEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAAAAAAAAEAmBMAAAAAAAAAAmRAAAwAAAAAAAGRCAAwAAAAAAACQCQEwAAAAAAAAQCYEwAAAAAAAAACZEAADAAAAAAAAZEIADAAAAAAAAJAJATAAAAAAAABAJgTAAAAAAAAAAJkQAAMAAAAAAABkQgAMAAAAAAAAkAkBMAD/f3t2QAMAAIAwyP6p7fFBDQAAAAAAgAgBDAAAAAAAABAhgAEAAAAAAAAiBDAAAAAAAABAhAAGAAAAAAAAiBDAAAAAAAAAABECGAAAAAAAACBCAAMAAAAAAABECGAAAAAAAACACAEMAAAAAAAAECGAAQAAAAAAACIEMAAAAAAAAECEAAYAAAAAAACIEMAAAAAAAAAAEQIYAAAAAAAAIEIAAwAAAAAAAEQIYAAAAAAAAIAIAQwAAAAAAAAQIYABAAAAAAAAIgQwAAAAAAAAQIQABgAAAAAAAIgQwAAAAAAAAAARAhgAAAAAAAAgQgADAAAAAAAARAhgAAAAAAAAgAgBDAAAAAAAABAhgAEAAAAAAAAiBDAAAAAAAABAhAAGAAAAAAAAiBDAAAAAAAAAABECGAAAAAAAACBCAAMAAAAAAABECGAAAAAAAACACAEMAAAAAAAAECGAAQAAAAAAABK2A1h1Y1XfuI3yAAAAAElFTkSuQmCC	\N	\N	\N	\N	рикролла не будет(	его нет.
\.


--
-- Name: additional_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.additional_options_id_seq', 1, false);


--
-- Name: contracts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contracts_id_seq', 5, true);


--
-- Name: faqs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faqs_id_seq', 6, true);


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

SELECT pg_catalog.setval('public.notifications_id_seq', 6, true);


--
-- Name: paragraphs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paragraphs_id_seq', 3, true);


--
-- Name: platform_news_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.platform_news_id_seq', 1, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 2, true);


--
-- Name: project_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.project_type_id_seq', 5, true);


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

SELECT pg_catalog.setval('public.users_id_seq', 12, true);


--
-- Name: work_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.work_status_id_seq', 2, true);


--
-- Name: works_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.works_id_seq', 5, true);


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

