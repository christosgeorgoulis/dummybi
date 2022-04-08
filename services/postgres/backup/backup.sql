--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6 (Debian 13.6-1.pgdg110+1)
-- Dumped by pg_dump version 14.1

-- Started on 2022-04-04 01:11:39

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
-- TOC entry 5 (class 2615 OID 16387)
-- Name: dw; Type: SCHEMA; Schema: -; Owner: dummy
--

CREATE SCHEMA dw;


ALTER SCHEMA dw OWNER TO dummy;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 207 (class 1259 OID 16454)
-- Name: comment; Type: TABLE; Schema: dw; Owner: dummy
--

CREATE TABLE dw.comment (
    id text NOT NULL,
    message text,
    owner text,
    post text,
    publishdate text
);


ALTER TABLE dw.comment OWNER TO dummy;

--
-- TOC entry 208 (class 1259 OID 16460)
-- Name: post; Type: TABLE; Schema: dw; Owner: dummy
--

CREATE TABLE dw.post (
    id text NOT NULL,
    text text,
    image text,
    likes bigint,
    link text,
    tags text,
    publishdate text,
    owner text
);


ALTER TABLE dw.post OWNER TO dummy;

--
-- TOC entry 209 (class 1259 OID 16467)
-- Name: user; Type: TABLE; Schema: dw; Owner: dummy
--

CREATE TABLE dw."user" (
    dateofbirth text,
    email text,
    firstname text,
    gender text,
    id text NOT NULL,
    lastname text,
    city text,
    country text,
    state text,
    street text,
    timezone text,
    phone text,
    picture text,
    registerdate text,
    title text,
    updateddate text
);


ALTER TABLE dw."user" OWNER TO dummy;

--
-- TOC entry 3024 (class 0 OID 16454)
-- Dependencies: 207
-- Data for Name: comment; Type: TABLE DATA; Schema: dw; Owner: dummy
--



--
-- TOC entry 3025 (class 0 OID 16460)
-- Dependencies: 208
-- Data for Name: post; Type: TABLE DATA; Schema: dw; Owner: dummy
--



--
-- TOC entry 3026 (class 0 OID 16467)
-- Dependencies: 209
-- Data for Name: user; Type: TABLE DATA; Schema: dw; Owner: dummy
--



--
-- TOC entry 2885 (class 2606 OID 16484)
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: dw; Owner: dummy
--

ALTER TABLE ONLY dw.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- TOC entry 2889 (class 2606 OID 16482)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: dw; Owner: dummy
--

ALTER TABLE ONLY dw.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- TOC entry 2891 (class 2606 OID 16474)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: dw; Owner: dummy
--

ALTER TABLE ONLY dw."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 2886 (class 1259 OID 16490)
-- Name: fki_comment_of_user; Type: INDEX; Schema: dw; Owner: dummy
--

CREATE INDEX fki_comment_of_user ON dw.comment USING btree (owner);


--
-- TOC entry 2887 (class 1259 OID 16480)
-- Name: fki_post_of_user; Type: INDEX; Schema: dw; Owner: dummy
--

CREATE INDEX fki_post_of_user ON dw.post USING btree (owner);


--
-- TOC entry 2892 (class 2606 OID 16485)
-- Name: comment comment_of_user; Type: FK CONSTRAINT; Schema: dw; Owner: dummy
--

ALTER TABLE ONLY dw.comment
    ADD CONSTRAINT comment_of_user FOREIGN KEY (owner) REFERENCES dw."user"(id) NOT VALID;


--
-- TOC entry 2893 (class 2606 OID 16475)
-- Name: post post_of_user; Type: FK CONSTRAINT; Schema: dw; Owner: dummy
--

ALTER TABLE ONLY dw.post
    ADD CONSTRAINT post_of_user FOREIGN KEY (owner) REFERENCES dw."user"(id) NOT VALID;


CREATE MATERIALIZED VIEW dw."comment_lag" AS
with first_comment AS
(
SELECT dw.comment.owner, MIN(publishdate::timestamp) AS "date_of_comment"
FROM dw.comment
GROUP BY dw.comment.owner
)
SELECT dw.user.id AS comment_owner, 
	DATE_PART('day', first_comment.date_of_comment - registerdate::timestamp) * 24 + 
              DATE_PART('hour', first_comment.date_of_comment - registerdate::timestamp) AS duration
FROM dw.user
INNER JOIN first_comment
	ON first_comment.owner = dw.user.id;

CREATE MATERIALIZED VIEW dw."daily_activity_per_city" AS
SELECT dw.user.city, dw.post.publishdate::date, COUNT(*) AS "count"
FROM dw.post
LEFT JOIN dw.user
	ON dw.user.id = dw.post.owner
GROUP BY dw.user.city, dw.post.publishdate::date;

CREATE MATERIALIZED VIEW dw."daily_new_users" AS
SELECT registerdate::date AS "registerdate", COUNT(DISTINCT dw.user.id) AS "count"
FROM dw.user
GROUP BY registerdate::date;


-- Completed on 2022-04-04 01:11:39

--
-- PostgreSQL database dump complete
--

