--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: beonecalendarevents; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE beonecalendarevents (
    eventid integer NOT NULL,
    subcategoryid integer NOT NULL,
    eventname character varying(200) NOT NULL,
    eventdate timestamp without time zone NOT NULL,
    eventdescription text NOT NULL,
    eventlocation character varying(500) NOT NULL,
    eventtype character varying(500) NOT NULL
);


ALTER TABLE public.beonecalendarevents OWNER TO "beoneuser";

--
-- Name: beonecalendarevents_eventid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE beonecalendarevents_eventid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beonecalendarevents_eventid_seq OWNER TO "beoneuser";

--
-- Name: beonecalendarevents_eventid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE beonecalendarevents_eventid_seq OWNED BY beonecalendarevents.eventid;


--
-- Name: beonecalendars; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE beonecalendars (
    calendarid integer NOT NULL,
    calendarname character varying(200),
    description character varying(500)
);


ALTER TABLE public.beonecalendars OWNER TO "beoneuser";

--
-- Name: beonecalendars_calendarid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE beonecalendars_calendarid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beonecalendars_calendarid_seq OWNER TO "beoneuser";

--
-- Name: beonecalendars_calendarid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE beonecalendars_calendarid_seq OWNED BY beonecalendars.calendarid;


--
-- Name: beonecalendarsubcategories; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE beonecalendarsubcategories (
    subcategoryid integer NOT NULL,
    calendarid integer,
    calendarsubcategory character varying(200),
    description character varying(500)
);


ALTER TABLE public.beonecalendarsubcategories OWNER TO "beoneuser";

--
-- Name: beonecalendarsubcategories_subcategoryid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE beonecalendarsubcategories_subcategoryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beonecalendarsubcategories_subcategoryid_seq OWNER TO "beoneuser";

--
-- Name: beonecalendarsubcategories_subcategoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE beonecalendarsubcategories_subcategoryid_seq OWNED BY beonecalendarsubcategories.subcategoryid;


--
-- Name: city; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE city (
    cityid integer NOT NULL,
    countryid integer,
    cityname character varying(50)
);


ALTER TABLE public.city OWNER TO "beoneuser";

--
-- Name: city_cityid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE city_cityid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_cityid_seq OWNER TO "beoneuser";

--
-- Name: city_cityid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE city_cityid_seq OWNED BY city.cityid;


--
-- Name: country; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE country (
    countryid integer NOT NULL,
    countryname character varying(50)
);


ALTER TABLE public.country OWNER TO "beoneuser";

--
-- Name: country_countryid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE country_countryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.country_countryid_seq OWNER TO "beoneuser";

--
-- Name: country_countryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE country_countryid_seq OWNED BY country.countryid;


--
-- Name: dailies; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE dailies (
    dailyid integer NOT NULL,
    dailytitle character varying(200) NOT NULL,
    dailycategoryid integer NOT NULL,
    dailydescription character varying(500) NOT NULL
);


ALTER TABLE public.dailies OWNER TO "beoneuser";

--
-- Name: dailies_dailyid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE dailies_dailyid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dailies_dailyid_seq OWNER TO "beoneuser";

--
-- Name: dailies_dailyid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE dailies_dailyid_seq OWNED BY dailies.dailyid;


--
-- Name: dailycategories; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE dailycategories (
    categoryid integer NOT NULL,
    categoryname character varying(50) NOT NULL
);


ALTER TABLE public.dailycategories OWNER TO "beoneuser";

--
-- Name: dailycategories_categoryid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE dailycategories_categoryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dailycategories_categoryid_seq OWNER TO "beoneuser";

--
-- Name: dailycategories_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE dailycategories_categoryid_seq OWNED BY dailycategories.categoryid;


--
-- Name: likeduserexperiences; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE likeduserexperiences (
    entryid integer NOT NULL,
    userexperienceid integer NOT NULL,
    userid integer NOT NULL
);


ALTER TABLE public.likeduserexperiences OWNER TO "beoneuser";

--
-- Name: likeduserexperiences_entryid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE likeduserexperiences_entryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.likeduserexperiences_entryid_seq OWNER TO "beoneuser";

--
-- Name: likeduserexperiences_entryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE likeduserexperiences_entryid_seq OWNED BY likeduserexperiences.entryid;


--
-- Name: newsfeed; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE newsfeed (
    feedid integer NOT NULL,
    feedtitle character varying(200),
    feedcontent character varying(1000),
    feedauthor integer,
    feedpublishdate timestamp without time zone,
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.newsfeed OWNER TO "beoneuser";

--
-- Name: newsfeed_feedid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE newsfeed_feedid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.newsfeed_feedid_seq OWNER TO "beoneuser";

--
-- Name: newsfeed_feedid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE newsfeed_feedid_seq OWNED BY newsfeed.feedid;


--
-- Name: profileentry; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE profileentry (
    entryid integer NOT NULL,
    userid integer,
    fieldname character varying(20),
    fieldvalue character varying(20),
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.profileentry OWNER TO "beoneuser";

--
-- Name: profileentry_entryid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE profileentry_entryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.profileentry_entryid_seq OWNER TO "beoneuser";

--
-- Name: profileentry_entryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE profileentry_entryid_seq OWNED BY profileentry.entryid;


--
-- Name: usercalendars; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE usercalendars (
    userid integer NOT NULL,
    calendarid integer NOT NULL,
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.usercalendars OWNER TO "beoneuser";

--
-- Name: userconnection; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE userconnection (
    userid integer NOT NULL,
    providerid character varying(255) NOT NULL,
    provideruserid character varying(255) NOT NULL,
    rank integer NOT NULL,
    displayname character varying(255),
    profileurl character varying(512),
    imageurl character varying(512),
    accesstoken character varying(255) NOT NULL,
    secret character varying(255),
    refreshtoken character varying(255),
    expiretime bigint,
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.userconnection OWNER TO "beoneuser";

--
-- Name: userexperiencecomments; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE userexperiencecomments (
    commentid integer NOT NULL,
    userid integer NOT NULL,
    userexperienceid integer NOT NULL,
    commentedcommentid integer NOT NULL,
    commentdescription character varying(500) NOT NULL
);


ALTER TABLE public.userexperiencecomments OWNER TO "beoneuser";

--
-- Name: userexperiencecomments_commentid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE userexperiencecomments_commentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userexperiencecomments_commentid_seq OWNER TO "beoneuser";

--
-- Name: userexperiencecomments_commentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE userexperiencecomments_commentid_seq OWNED BY userexperiencecomments.commentid;


--
-- Name: userexperiences; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE userexperiences (
    userexperienceid integer NOT NULL,
    userid integer NOT NULL,
    experiencedescription character varying(500) NOT NULL,
    createdat timestamp without time zone,
    updatedat timestamp without time zone,
    experiencedate character varying(10) NOT NULL
);


ALTER TABLE public.userexperiences OWNER TO "beoneuser";

--
-- Name: userexperiences_userexperienceid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE userexperiences_userexperienceid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userexperiences_userexperienceid_seq OWNER TO "beoneuser";

--
-- Name: userexperiences_userexperienceid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE userexperiences_userexperienceid_seq OWNED BY userexperiences.userexperienceid;


--
-- Name: userfriends; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE userfriends (
    userid integer NOT NULL,
    frienduserid integer NOT NULL,
    friendshipstatus character varying(20),
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.userfriends OWNER TO "beoneuser";

--
-- Name: userlikednews; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE userlikednews (
    entryid integer NOT NULL,
    userid integer,
    newsid integer,
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.userlikednews OWNER TO "beoneuser";

--
-- Name: userlikednews_entryid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE userlikednews_entryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userlikednews_entryid_seq OWNER TO "beoneuser";

--
-- Name: userlikednews_entryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE userlikednews_entryid_seq OWNED BY userlikednews.entryid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE users (
    userid integer NOT NULL,
    username character varying(100),
    email character varying(200),
    password character varying(200),
    firstname character varying(100),
    lastname character varying(100),
    birthday character varying(10),
    gender character varying(20),
    currentcityid integer,
    provider character varying(20),
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.users OWNER TO "beoneuser";

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE users_userid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_userid_seq OWNER TO "beoneuser";

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE users_userid_seq OWNED BY users.userid;


--
-- Name: usertokens; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE usertokens (
    entryid integer NOT NULL,
    userid integer,
    token character varying(2000),
    createdat timestamp without time zone,
    updatedat timestamp without time zone
);


ALTER TABLE public.usertokens OWNER TO "beoneuser";

--
-- Name: usertokens_entryid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE usertokens_entryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usertokens_entryid_seq OWNER TO "beoneuser";

--
-- Name: usertokens_entryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE usertokens_entryid_seq OWNED BY usertokens.entryid;


--
-- Name: userwishdailychecks; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE userwishdailychecks (
    entryid integer NOT NULL,
    userwishid integer NOT NULL,
    targetdate timestamp without time zone,
    checkedat timestamp without time zone,
    checkstatus integer NOT NULL
);


ALTER TABLE public.userwishdailychecks OWNER TO "beoneuser";

--
-- Name: userwishdailychecks_entryid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE userwishdailychecks_entryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userwishdailychecks_entryid_seq OWNER TO "beoneuser";

--
-- Name: userwishdailychecks_entryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE userwishdailychecks_entryid_seq OWNED BY userwishdailychecks.entryid;


--
-- Name: userwishes; Type: TABLE; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE TABLE userwishes (
    userwishid integer NOT NULL,
    userid integer NOT NULL,
    wishtext character varying(500) NOT NULL,
    createdat timestamp without time zone,
    updatedat timestamp without time zone,
    isactive boolean NOT NULL
);


ALTER TABLE public.userwishes OWNER TO "beoneuser";

--
-- Name: userwishes_userwishid_seq; Type: SEQUENCE; Schema: public; Owner: Selcuk
--

CREATE SEQUENCE userwishes_userwishid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.userwishes_userwishid_seq OWNER TO "beoneuser";

--
-- Name: userwishes_userwishid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: Selcuk
--

ALTER SEQUENCE userwishes_userwishid_seq OWNED BY userwishes.userwishid;


--
-- Name: eventid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY beonecalendarevents ALTER COLUMN eventid SET DEFAULT nextval('beonecalendarevents_eventid_seq'::regclass);


--
-- Name: calendarid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY beonecalendars ALTER COLUMN calendarid SET DEFAULT nextval('beonecalendars_calendarid_seq'::regclass);


--
-- Name: subcategoryid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY beonecalendarsubcategories ALTER COLUMN subcategoryid SET DEFAULT nextval('beonecalendarsubcategories_subcategoryid_seq'::regclass);


--
-- Name: cityid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY city ALTER COLUMN cityid SET DEFAULT nextval('city_cityid_seq'::regclass);


--
-- Name: countryid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY country ALTER COLUMN countryid SET DEFAULT nextval('country_countryid_seq'::regclass);


--
-- Name: dailyid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY dailies ALTER COLUMN dailyid SET DEFAULT nextval('dailies_dailyid_seq'::regclass);


--
-- Name: categoryid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY dailycategories ALTER COLUMN categoryid SET DEFAULT nextval('dailycategories_categoryid_seq'::regclass);


--
-- Name: entryid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY likeduserexperiences ALTER COLUMN entryid SET DEFAULT nextval('likeduserexperiences_entryid_seq'::regclass);


--
-- Name: feedid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY newsfeed ALTER COLUMN feedid SET DEFAULT nextval('newsfeed_feedid_seq'::regclass);


--
-- Name: entryid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY profileentry ALTER COLUMN entryid SET DEFAULT nextval('profileentry_entryid_seq'::regclass);


--
-- Name: commentid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY userexperiencecomments ALTER COLUMN commentid SET DEFAULT nextval('userexperiencecomments_commentid_seq'::regclass);


--
-- Name: userexperienceid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY userexperiences ALTER COLUMN userexperienceid SET DEFAULT nextval('userexperiences_userexperienceid_seq'::regclass);


--
-- Name: entryid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY userlikednews ALTER COLUMN entryid SET DEFAULT nextval('userlikednews_entryid_seq'::regclass);


--
-- Name: userid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY users ALTER COLUMN userid SET DEFAULT nextval('users_userid_seq'::regclass);


--
-- Name: entryid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY usertokens ALTER COLUMN entryid SET DEFAULT nextval('usertokens_entryid_seq'::regclass);


--
-- Name: entryid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY userwishdailychecks ALTER COLUMN entryid SET DEFAULT nextval('userwishdailychecks_entryid_seq'::regclass);


--
-- Name: userwishid; Type: DEFAULT; Schema: public; Owner: Selcuk
--

ALTER TABLE ONLY userwishes ALTER COLUMN userwishid SET DEFAULT nextval('userwishes_userwishid_seq'::regclass);


--
-- Data for Name: beonecalendarevents; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY beonecalendarevents (eventid, subcategoryid, eventname, eventdate, eventdescription, eventlocation, eventtype) FROM stdin;
750	150	Solar Eclipses -Total Solar 	2016-03-09 03:59:00	-	Istanbul	TimeEvent
751	150	Solar Eclipses -Annular Solar 	2016-09-01 12:01:00	-	Istanbul	TimeEvent
752	150	Lunar Eclipses-Penumbral Lunar	2016-03-23 13:47:00	-	Istanbul	TimeEvent
753	150	Lunar Eclipses-Almost Lunar	2016-08-18 12:42:00	-	Istanbul	TimeEvent
754	151	Summer Solstice	2016-06-21 01:34:00		Istanbul	TimeEvent
755	151	Winter Solstice	2016-12-21 12:44:00		Istanbul	TimeEvent
756	151	Spring Equinox	2016-03-20 06:30:00		Istanbul	TimeEvent
757	151	Autumn Equinox 	2016-09-22 17:21:00		Istanbul	TimeEvent
758	152	Quadrantids	2016-01-03 00:00:00		Universal	FullDayEvent
759	152	Lyrids (Best seen in northern hemisphere)	2016-04-22 00:00:00		Universal	FullDayEvent
760	152	Eta Aquariids (Best seen in southern tropics)	2016-05-06 00:00:00		Universal	FullDayEvent
761	152	Alpha Capricornids	2016-07-27 00:00:00		Universal	FullDayEvent
762	152	Delta Aquariids  (Best seen in southern tropics)	2016-07-28 00:00:00		Universal	FullDayEvent
763	152	Perseids	2016-08-12 00:00:00		Universal	FullDayEvent
764	152	Draconids	2016-10-08 00:00:00		Universal	FullDayEvent
765	152	Orionids	2016-10-20 00:00:00		Universal	FullDayEvent
766	152	Southern Taurids	2016-10-23 00:00:00		Universal	FullDayEvent
767	152	Northern Taurids	2016-11-11 00:00:00		Universal	FullDayEvent
768	152	Leonids	2016-11-17 00:00:00		Universal	FullDayEvent
769	152	Geminids  (Best seen in northern hemisphere)	2016-12-13 00:00:00		Universal	FullDayEvent
770	152	Ursids	2016-12-21 00:00:00		Universal	FullDayEvent
771	153	New Moon 	2016-01-10 03:30:00		Istanbul	TimeEvent
772	153	Full Moon 	2016-01-24 03:45:00		Istanbul	TimeEvent
773	153	Blue Moon 	2016-05-22 00:14:00		Istanbul	TimeEvent
774	153	Super Moon	2016-11-14 15:52:00		Istanbul	TimeEvent
775	154	Sunrise	2016-01-01 07:29:00	1. A whole new day is starting. Why don’t you wake up early to nature and fully embrace that precious moment? \n2. At sunrise, watching the transition of colours in the sky and hearing the animals singing could be breathtaking. Are you in? \n3. What if you were born again every single day? How would you live differently? Write down the answer. \n4. There is no ordinary sunrise. Colors of sky, clouds, sounds…Every day, all of them create a unique combination. How would you make today unique?\n5. Note what makes you grateful to wake up to another day.\n6. Go out and listen to the stillness of sunrise. Close your eyes and just focus on what you hear.\n7. If you live in a big city, wake up early, maybe even before sunrise... go out and enjoy the shorter commute.\n8. Sunrise is a great moment to savour the awakening of the day. What would you awake in your soul today?\n9. Go somewhere where you can watch the sunrise on the endless sky. How would you make it eternal? Note down, take photos, keep the moment in your heart…\n10. Let this sun rise on you to do something beautiful that you haven’t done before. What would it be?	Istanbul	TimeEvent
776	154	Sunset 	2016-01-01 16:46:00		Istanbul	TimeEvent
777	155	Mercury Retrograde	2016-01-05 00:00:00		Istanbul	FullDayEvent
778	155	Chiron Retrograde	2016-06-27 00:00:00		Istanbul	FullDayEvent
779	155	Mars Retrograde	2016-04-17 00:00:00		Istanbul	FullDayEvent
780	155	Jupiter Retrograde	2016-01-08 00:00:00		Istanbul	FullDayEvent
781	155	Saturn Retrograde	2016-03-25 00:00:00		Istanbul	FullDayEvent
782	155	Uranus Retrograde	2016-07-29 00:00:00		Istanbul	FullDayEvent
783	155	Neptune Retrograde	2016-06-13 00:00:00		Istanbul	FullDayEvent
784	155	Pluto Retrograde	2016-04-18 00:00:00		Istanbul	FullDayEvent
785	156	Time to plant trees	2016-02-15 00:00:00		Istanbul	FullDayEvent
786	156	Trees start absorbing water from their roots to the leaves	2016-03-05 00:00:00		Istanbul	FullDayEvent
787	156	Time to prune grape vines	2016-03-09 00:00:00		Istanbul	FullDayEvent
788	156	Grape vines start absorbing water	2016-03-08 00:00:00		Istanbul	FullDayEvent
789	156	Foliation starts	2016-03-30 00:00:00		Istanbul	FullDayEvent
790	156	Blooming starts	2016-03-29 00:00:00		Istanbul	FullDayEvent
791	156	Tulip season 	2016-04-10 00:00:00		Istanbul	FullDayEvent
792	156	Cleft grafting time	2016-03-10 00:00:00		Istanbul	FullDayEvent
793	156	Tulips blooimng season	2016-04-30 00:00:00		Istanbul	FullDayEvent
794	156	Time to care for roses	2016-04-25 00:00:00		Istanbul	FullDayEvent
795	156	Rose season	2016-05-18 00:00:00		Istanbul	FullDayEvent
796	156	Time to hoe vineyards	2016-05-21 00:00:00		Istanbul	FullDayEvent
797	156	Waters decrease in soil	2016-05-23 00:00:00		Istanbul	FullDayEvent
798	156	Season of the Harvest	2016-06-07 00:00:00	Crops are harvested for its journey from field to our tables. That could be good idea to go and observe that important event for farmers & harvesters and listen to the story from them.  	Istanbul	FullDayEvent
799	156	Time to plant rice	2016-06-09 00:00:00		Istanbul	FullDayEvent
800	156	Budding Season starts	2016-06-25 00:00:00		Istanbul	FullDayEvent
801	156	Grapes start turning red	2016-07-26 00:00:00		Istanbul	FullDayEvent
802	156	Budding Season ends	2016-07-29 00:00:00		Istanbul	FullDayEvent
803	156	Cotton-picking Time 	2016-08-12 00:00:00		Istanbul	FullDayEvent
804	156	Fruits ripening period	2016-08-15 00:00:00		Istanbul	FullDayEvent
805	156	Trees start exuding water	2016-09-28 00:00:00		Istanbul	FullDayEvent
806	156	Tree planting and grafting time	2016-10-20 00:00:00		Istanbul	FullDayEvent
807	156	Tree pruning time	2016-10-31 00:00:00		Istanbul	FullDayEvent
808	156	Foliage season 	2016-11-02 00:00:00		Istanbul	FullDayEvent
809	156	Foliage season ends	2016-12-08 00:00:00		Istanbul	FullDayEvent
810	157	Animals' mating season	2016-02-05 00:00:00		Istanbul	FullDayEvent
811	157	Birds' mating season	2016-02-17 00:00:00		Istanbul	FullDayEvent
812	157	Migration season for storks	2016-03-02 00:00:00		Istanbul	FullDayEvent
813	157	Migration season for swallows	2016-03-15 00:00:00		Istanbul	FullDayEvent
814	157	Insects starts appearing	2016-03-25 00:00:00		Istanbul	FullDayEvent
815	157	Migration season for Kite Birds	2016-03-28 00:00:00		Istanbul	FullDayEvent
816	157	Nightingales start chirping	2016-04-02 00:00:00		Istanbul	FullDayEvent
817	157	Silkworms raising time	2016-04-24 00:00:00		Istanbul	FullDayEvent
818	157	Season of bees hatching	2016-04-26 00:00:00		Istanbul	FullDayEvent
819	157	Sparrows breeding season	2016-04-27 00:00:00		Istanbul	FullDayEvent
820	157	Bees honey making season	2016-08-05 00:00:00		Istanbul	FullDayEvent
821	157	Sheeps shearing season 	2016-05-26 00:00:00		Istanbul	FullDayEvent
822	157	Migration season for cranes	2016-10-04 00:00:00		Istanbul	FullDayEvent
823	157	Fish abundance season	2016-10-15 00:00:00		Istanbul	FullDayEvent
824	157	Insects starts disappearing	2016-11-25 00:00:00		Istanbul	FullDayEvent
825	158	1st Spring Herald: In the Air	2016-02-20 00:00:00		Istanbul	FullDayEvent
826	158	2nd Spring Herald: In Waters 	2016-02-27 00:00:00		Istanbul	FullDayEvent
827	158	Melting of Mountain Snow	2016-03-03 00:00:00		Istanbul	FullDayEvent
828	158	Avalanche and Flood could happen	2016-03-05 00:00:00		Istanbul	FullDayEvent
829	158	3rd Spring Herald: In Soils 	2016-03-06 00:00:00		Istanbul	FullDayEvent
830	158	"Kocakarı Soğukları" (Extreme cold weather) starts	2016-03-11 00:00:00		Istanbul	FullDayEvent
831	158	"Kocakarı Soğukları" (Extreme cold weather) ends	2016-03-18 00:00:00		Istanbul	FullDayEvent
832	158	"Sitte-I Sevir" (Cold weather in April) starts	2016-04-21 00:00:00		Istanbul	FullDayEvent
833	158	"Sitte-I Sevir" (Cold weather in April) ends	2016-04-26 00:00:00		Istanbul	FullDayEvent
834	158	Spring winds end	2016-05-25 00:00:00		Istanbul	FullDayEvent
835	158	Sea temperatures getting warmer	2016-05-04 00:00:00		Istanbul	FullDayEvent
836	158	Breezes season starts	2016-05-31 00:00:00		Istanbul	FullDayEvent
837	158	Hot winds season starts	2016-07-03 00:00:00		Istanbul	FullDayEvent
838	158	Breezes season ends	2016-07-08 00:00:00		Istanbul	FullDayEvent
839	158	"Eyyam-I Bahur" (Extreme hot weather) starts	2016-07-31 00:00:00		Istanbul	FullDayEvent
840	158	"Eyyam-I Bahur" (Extreme hot weather) ends	2016-08-07 00:00:00		Istanbul	FullDayEvent
841	158	Hot winds season ends	2016-08-24 00:00:00		Istanbul	FullDayEvent
842	158	Sea temperatures getting colder	2016-10-26 00:00:00		Istanbul	FullDayEvent
843	158	Dew Season 	2016-11-09 00:00:00		Istanbul	FullDayEvent
844	158	Indian Summer	2016-11-11 00:00:00		Istanbul	FullDayEvent
845	159	World Religion Day 	2016-01-17 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
846	159	Ayyám-i-Há (Intercalary Days)	2016-02-26 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
847	159	Nineteen Day Fast/Alá	2016-03-02 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
848	159	Naw-Rúz (New Year)	2016-03-21 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
849	159	First Day of Ridvan	2016-04-21 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
850	159	Ninth Day of Ridvan	2016-04-29 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
851	159	Twelfth Day of Ridvan	2016-05-02 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
852	159	Declaration of the Bab	2016-05-23 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
853	159	Ascension of Baha'u'llah	2016-05-29 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
854	159	The Martyrdom of the Bab	2016-07-09 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
855	159	Birth of the Báb	2016-10-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
856	159	Birth of Baha'u'llah	2016-11-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
857	159	Day of the Covenant	2016-11-26 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
858	159	Ascension of  'Abdu'l-Baha	2016-11-28 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
859	160	Mahayana New Year	2016-01-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
860	160	Ajahn Chah Memorial Day - for Theravada Countries	2016-01-16 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
861	160	Chinese New Year (Spring Festival)	2016-02-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
1228	171	World Soil Day	2016-12-05 00:00:00		Universal	FullDayEvent
1229	171	International Civil Aviation Day	2016-12-07 00:00:00		Universal	FullDayEvent
862	160	Nirvana Day (Parinirvana) - for Mahayana Countries	2016-02-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
863	160	Magha Puja Day (Sangha Day) - for Theravada Countries	2016-03-23 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
864	160	Theravada New Year	2016-04-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
865	160	Visakha Puja (Vesak, Buddha Day)	2016-05-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
866	160	Ajahn Chah's Birthday - for Theravada Countries	2016-06-17 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
867	160	Pavarana Day	2016-10-16 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
868	160	Obon (Ulambana) - for Mahayana Countries and some Theravadins in Cambodia, Laos & Thailand 	2016-07-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
869	160	Asalha Puja Day (Dhamma Day)  - for Theravada Countries	2016-07-19 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
870	160	Bodhi Day  (Rohatsu) - for many mainstream Mahayana Countries (check) 	2016-12-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
871	161	Solemnity of Mary, Mother of God - Catholic Christian	2016-01-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
872	161	Feast Day of Saint Basil - Orthodox Christian/Eastern	2016-01-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
873	161	Feast Day of Saint Basil - Orthodox Christian/Western	2016-01-02 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
874	161	Twelfth Night	2016-01-05 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
875	161	Epiphany (Dia de los Reyes - Three Kings Day)	2016-01-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
876	161	Feast of the Epiphany (Theophany) - Orthodox Christian 	2016-01-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
877	161	Christmas Day -  Orthodox Christian for some Countries	2016-01-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
878	161	Feast of the Holy Family - Catholic Christian for some Countries	2016-01-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
879	161	Feast of Baptism of the Lord Jesus	2016-01-10 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
880	161	Blessing of the Animals - Hispanic Catholic Christian	2016-01-17 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
881	161	Week of Prayer for Christian Unity	2016-01-18 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
882	161	Timkat (Timket) - Ethiopian Orthodox Christian	2016-01-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
883	161	Conversion of St. Paul the Apostle	2016-01-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1230	171	International Day of Commemoration and Dignity of the Victims of the Crime of Genocide and of the Prevention of this Crime	2016-12-09 00:00:00		Universal	FullDayEvent
884	161	Clean Monday - Orthodox Christian	2016-02-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
885	161	Candlemas - Presentation of Christ in the Temple	2016-02-02 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
886	161	Saint Brighid of Kildare - Celtic Christian	2016-02-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
887	161	St. Blaise Day	2016-02-03 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
888	161	Transfiguration Sunday	2016-02-07 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
889	161	Shrove Tuesday	2016-02-09 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
890	161	Ash Wednesday	2016-02-10 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
891	161	Lent	2016-02-10 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
892	161	World Day of the Sick (Feast Day of Our Lady of Lourdes) -  Roman Catholic	2016-02-11 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
893	161	Triodion - Orthodox Christian	2016-02-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
894	161	St. Valentine's Day	2016-02-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
895	161	St. David of Wales	2016-03-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
896	161	Orthodox Sunday - Orthodox Christian	2016-03-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
897	161	Cheesefare Sunday - Orthodox Christian	2016-03-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
898	161	Palm Sunday 	2016-03-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
899	161	Maundy Thursday (Holy Thursday)	2016-03-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
900	161	Good Friday	2016-03-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
901	161	Annunciation of the Blessed Virgin Mary - Catholic Christian	2016-03-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
902	161	Easter	2016-03-27 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
903	161	St. George's Day	2016-04-23 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
904	161	Lazarus Satuday - Orthodox Christian	2016-04-23 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
905	161	Palm Sunday - Orthodox Christian	2016-04-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
906	161	Holy Friday - Orthodox Christian	2016-04-29 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
953	161	Yule	2016-12-21 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
907	161	St. James the Great Day - Orthodox Christian	2016-04-30 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
908	161	Pascha (Easter) - Orthodox Christian	2016-05-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
909	161	Saints Philip & James	2016-05-03 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
910	161	Ascension of Jesus	2016-05-05 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
911	161	Pentecost	2016-05-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
912	161	Trinity Sunday	2016-05-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
913	161	Corpus Christi - Catholic Christian	2016-05-26 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
914	161	Ascension of Jesus - Orthodox Christian	2016-06-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
915	161	Sacred Heart of Jesus - Catholic Christian	2016-06-03 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
916	161	St. Columba of Iona - Celtic Christian	2016-06-09 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
917	161	New Church Day - Swedenborgian Christian	2016-06-19 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
918	161	Pentecost - Orthodox Christian	2016-06-19 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
919	161	All Saints - Orthodox Christian	2016-06-26 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
920	161	Saint Peter and Saint Paul's Day	2016-06-29 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
921	161	St Benedict Day - Catholic Christian	2016-07-11 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
922	161	St. Vladimir the Great Day - Orthodox Christian	2016-07-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
923	161	Pioneer Day- Mormon Christian	2016-07-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
924	161	St. James the Great Day	2016-07-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
925	161	Lammas	2016-08-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
926	161	Fast in honor of Holy Mother of Lord Jesus - Orthodox Christian	2016-08-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
927	161	Transfiguration of the Lord - Orthodox Christian	2016-08-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
928	161	Assumption of Blessed Virgin Mary - Catholic Christian	2016-08-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
929	161	Dormition of the Theotokos - Orthodox Christian	2016-08-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1144	171	World Press Freedom Day 	2016-05-03 00:00:00		Universal	FullDayEvent
1317	173	Working Journalists Day	2016-01-10 00:00:00		Universal	FullDayEvent
930	161	Beheading of St. John the Baptist	2016-08-29 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
931	161	Ecclesiastical year begins - Orthodox Christian	2016-09-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
932	161	Nativity of Virgin Mary - Catholic Christian	2016-09-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
933	161	Nativity of Theotokos - Orthodox Christian	2016-09-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
934	161	Elevation of the Life Giving Cross (Holy Cross)	2016-09-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
935	161	Michaelmas	2016-09-29 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
936	161	Meskel - Ethiopian Orthodox Christian	2016-09-29 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
937	161	St Francis Day - Catholic Christian	2016-10-04 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
938	161	Blessing of the Animals	2016-10-04 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
939	161	St. Luke, Apostle & Evangelist	2016-10-18 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
940	161	Milvian Bridge Day	2016-10-28 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
941	161	All Hallows Eve	2016-10-31 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
942	161	Reformation Day - Protestant Christian	2016-10-31 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
943	161	All Saints Day	2016-11-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
944	161	All Souls Day - Catholic Christian	2016-11-02 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
945	161	Nativity Fast - Orthodox Christian	2016-11-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
946	161	Christ the King	2016-11-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
947	161	Advent	2016-11-27 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
948	161	St. Andrew's Day	2016-11-30 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
949	161	Saint Nicholas Day	2016-12-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
950	161	Immaculate Conception of Mary - Catholic Christian	2016-12-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
951	161	Feast day - Our Lady of Guadalupe - Catholic Christian	2016-12-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
952	161	Posadas Navidenas - Hispanic Christian	2016-12-16 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1145	171	Time of Remembrance and Reconciliation for Those Who Lost Their Lives During the Second World War	2016-05-08 00:00:00		Universal	FullDayEvent
1146	171	World Migratory Bird Day	2016-05-09 00:00:00		Universal	FullDayEvent
954	161	Christmas Eve (Mainly Western Churches)	2016-12-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
955	161	Christmas Day * (Mainly Western Churches)	2016-12-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
956	161	Feast of the Nativity - Orthodox Christian for some Countries	2016-12-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
957	161	St Stephen's Day	2016-12-26 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
958	161	Holy Innocents	2016-12-28 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
959	161	Holy Family - Catholic Christian	2016-12-30 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
960	161	Watch Night	2016-12-31 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
961	162	Makar Sankranti / Pongal	2016-01-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
962	162	Sakat Chauth (Sankashti Chaturthi(	2016-01-27 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
963	162	Chandra Darshan	2016-01-11 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
964	162	Vasant Panchami (Saraswati Puja)	2016-02-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
965	162	Magha Purnima	2016-02-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
966	162	Maha Shivaratri	2016-03-07 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
967	162	Holika Dahan	2016-03-23 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
968	162	Holi (Festival of Colours)	2016-03-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
969	162	Basoda (Sheetala Ashtami)	2016-04-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
970	162	Hindu New Year	2016-04-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
971	162	Telugu New Year (Ugadi, Gudi Padwa)	2016-04-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
972	162	Jhulelal Jayanti	2016-04-09 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
973	162	Gauri Puja	2016-04-09 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
974	162	Yamuna Chhath	2016-04-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
975	162	Tamil New Year (Puthandu)	2016-04-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
976	162	Vaisakhi (Baisakhi) 	2016-04-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
977	162	Bengali New Year (Bihu, Pohela Boishakh)	2016-04-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
978	162	Ramayana	2016-04-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
979	162	Rama Navami	2016-04-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
980	162	Hanuman Jayanti	2016-04-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
981	162	Akshaya Tritiya (Akha Teej) 	2016-05-09 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
982	162	Vat Savitri (Savitri Pooja)	2016-06-04 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
983	162	Ganga Dussehra	2016-06-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
984	162	Gayatri Jayanti	2016-06-16 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
985	162	Nirjala Ekadashi	2016-06-16 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
986	162	Puri Rath Yatra (Ratha Yatra) 	2016-07-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
987	162	Guru Purnima	2016-07-19 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
988	162	Nag Panchami	2016-08-07 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
989	162	Ganesh Chathurthi	2016-08-05 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
990	162	Varalakshmi Vratam	2016-08-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
991	162	Raksha Bandhan	2016-08-18 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
992	162	Krishna Janmashtami	2016-08-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
993	162	Onam	2016-09-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
994	162	Vishwakarma Day (Vishwakarma Puja)	2016-09-16 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
995	162	Mahalaya Amavasya 	2016-09-30 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
996	162	Hartalika Teej	2016-09-04 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
997	162	Pitru Paksha	2016-09-17 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
998	162	Navaratri	2016-10-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
999	162	Dasara (Dussehra)	2016-10-11 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
1000	162	Durga Puja	2016-10-07 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
1001	162	Karva Chauth	2016-10-19 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
1147	171	International Day of Families	2016-05-15 00:00:00		Universal	FullDayEvent
1148	171	World Telecommunication and Information Society Day	2016-05-17 00:00:00		Universal	FullDayEvent
1002	162	Diwali (Deepavali)	2016-10-30 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
1003	163	Rabi' al-thani begins	2016-01-11 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1004	163	Jumada al-awwal begins	2016-02-10 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1005	163	Jumada al-Thani begins	2016-03-10 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1006	163	The night of Muhammad's conception	2016-04-07 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1007	163	Rajab begins 	2016-04-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1008	164	Lailat al Miraj	2016-05-03 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1009	164	Sha'aban begins	2016-05-08 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1010	163	Lailat al Bara'ah (Mid-Sha'ban)	2016-05-21 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1011	163	Ramadan	2016-06-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1012	163	Laylat al Qadr	2016-07-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1013	163	Eid al-Fitr Eve	2016-07-04 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1014	163	Shawwal begins	2016-07-05 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1015	163	Eid al-Fitr	2016-07-05 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1016	163	Dhū al-Qaʿdah begins	2016-08-04 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1017	163	Dhu al-Hijjah begins	2016-09-03 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1018	163	Waqf al Arafa - Hajj Day	2016-09-10 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1019	163	Eid al Adha Eve	2016-09-11 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1020	163	Eid al Adha	2016-09-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1021	163	Muḥarram begins (Islamic New Year)	2016-10-02 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1022	163	Day of Ashura	2016-10-11 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1023	163	Ṣafar begins	2016-11-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1024	163	Rabi' al-awwal begins	2016-12-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1025	163	Mawlid al-Nabi	2016-12-11 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1149	171	"Vesak", the Day of the Full Moon	2016-05-20 00:00:00		Universal	FullDayEvent
1150	171	World Day for Cultural Diversity for Dialogue and Development 	2016-05-21 00:00:00		Universal	FullDayEvent
1026	163	Mohammed's Birth Week	2016-04-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1027	165	Rohini Vrat 	2016-01-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1028	165	Meru Trayodashi 	2016-02-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1029	165	Ashtahnika Vidhan	2016-03-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1030	165	Chaumasi Chaudas	2016-03-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1031	165	Varshitap Arambha	2016-03-31 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1032	165	Navpad Oli	2016-04-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1033	165	Mahavir Jayanti	2016-04-19 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1034	165	Varshitap Parna	2016-05-09 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1035	165	Mahavir Swami Kevalgyan	2016-05-16 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1036	165	Anant Chaturdashi	2016-09-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1037	165	Kshamavani Parva	2016-09-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1038	165	Paryushana Parvarambha	2016-08-29 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1039	165	Paryushana Parava	2016-09-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1040	165	Diwali (Deepavali, Mahavir Nirvana)	2016-10-30 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1041	165	New Year	2016-10-31 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1042	165	Gyan Panchami	2016-11-06 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Turkey 	FullDayEvent
1043	166	Tu B'Shevat	2016-01-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1044	166	Purim	2016-03-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1045	166	Passover	2016-04-23 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1046	166	Yom HaShoah (Holocaust Remembrance Day) 	2016-05-05 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1047	166	Second Passover	2016-05-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1048	166	Lag B'Omer	2016-05-26 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1049	166	Shavuot	2016-06-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1151	171	International Day for Biological Diversity 	2016-05-22 00:00:00		Universal	FullDayEvent
1152	171	International Day to End Obstetric Fistula	2016-05-23 00:00:00		Universal	FullDayEvent
1050	166	The Three Weeks	2016-07-23 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1051	166	Tish'a B'av	2016-08-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1052	166	The 15th of Av	2016-08-19 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1053	166	Rosh Hashanah	2016-10-03 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1054	166	Yom Kippur	2016-10-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1055	166	Sukkot	2016-10-17 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1056	166	Shemini Atzeret	2016-10-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1057	166	Simchat Torah	2016-10-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1058	166	Hanukkah	2016-12-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Universal	FullDayEvent
1059	167	Imbolc - Wicca/Pagan - northern hemisphere	2016-02-02 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1060	167	Lughnassad (Lammas) - southern hemisphere	2016-02-02 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1061	167	Equinox: Ostara - Wicca/Pagan - northern hemisphere 	2016-03-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1062	167	Equinox: Mabon - Wicca/Pagan - southern hemisphere 	2016-03-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1063	167	Beltane - Samhain - Wicca/Pagan - northern and southern Hemispheres	2016-05-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1064	167	Solstice: Litha - Wicca/Pagan - northern hemisphere	2016-06-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1065	167	Solstice: Yule - Wicca/Pagan - southern hemisphere	2016-06-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1066	167	Imbolc - Southern hemisphere	2016-08-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1067	167	Lughnassad (Lammas) Wicca/Pagan - northern hemisphere	2016-08-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1068	167	Equinox: Mabon - Wicca/Pagan - northern hemisphere	2016-09-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1069	167	Equinox: Ostata - Wicca/Pagan - southern hemisphere	2016-09-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1070	167	Samhain - Beltane Wicca/Pagan - northern and southern hemispheres	2016-10-31 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1071	167	Solstice: Yule - Wicca/Pagan - northern hemisphere 	2016-12-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1153	171	International Day of UN Peacekeepers	2016-05-29 00:00:00		Universal	FullDayEvent
1154	171	World No-Tobacco Day	2016-05-31 00:00:00		Universal	FullDayEvent
1318	173	Energy Saving Day	2016-01-11 00:00:00		Universal	FullDayEvent
1072	167	Solstice: Litha - Wicca/Pagan - southern hemisphere	2016-12-22 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Eastern Standard Time	FullDayEvent
1073	168	Gantan-sai (Oshogatsu, New Year) 	2016-01-01 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1074	168	Koshogatsu	2016-01-07 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1075	168	Setsubun (Rissun)	2016-02-03 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1076	168	Toshigoi-no-Matsuri	2016-02-17 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1077	168	Hinamatsuri	2016-03-03 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1078	168	Haru Matsuri	2016-03-05 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1079	168	Tango no Sekku	2016-05-05 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1080	168	Nagoshi-no-Oharae	2016-06-30 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1081	168	Obon (Ulambana) for some regions in Japan 	2016-07-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1082	168	Shichi-Go-San	2016-11-15 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1083	168	Niinamesei	2016-11-23 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1084	168	O’harae	2016-12-31 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Japan Overall	FullDayEvent
1085	169	Birth of Guru Gobind Singh	2016-01-05 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1086	169	Lohri	2016-01-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1087	169	Birth of Guru Har Rai	2016-01-31 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1088	169	Maghi 	2016-01-13 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1089	169	Nanakshahi New Year	2016-03-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1090	169	Holi	2016-03-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1091	169	Hola Mohalla	2016-03-25 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1092	169	Birth of Guru Angad	2016-04-18 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1093	169	Birth of Guru Tegh Bahadur	2016-04-18 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1094	169	Birth of Guru Arjan	2016-05-02 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1095	169	Birth of Guru Amar Das	2016-05-23 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1096	169	Basant Panchami (Basant Kite Festival)	2016-02-12 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1097	169	Baisakhi (Vaisakhi)	2016-04-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1098	169	Guru Arjan martyrdom	2016-06-16 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1099	169	Birth of Guru Ramdas	2016-10-09 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1100	169	Installation of Scriptures as Guru Granth	2016-10-20 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1101	169	Diwali - Deepavali	2016-10-30 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1102	169	Bandi Chhorh Divas	2016-10-30 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1103	169	Birth of Guru Nanak	2016-11-14 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1104	169	Martyrdom of Guru Tegh Bahdur	2016-11-24 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Nanakshahi Calendar	FullDayEvent
1105	170	Nouruz (New Year)	2016-03-21 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
1106	170	Khordad Sal (Birth of Prophet Zaranthushtra)	2016-03-28 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
1107	170	Zartosht No-Diso (Death of Prophet Zarathushtra)	2016-12-26 00:00:00	It’s a special day for many people all around the world. Why don’t you send your good vibes to your friends who celebrate it?  Calling them, texting or just sharing it could be great opportunity to be with them on that divine day. 	Not sure	FullDayEvent
1108	171	International Day of Commemoration in Memory of the Victims of the Holocaust	2016-01-27 00:00:00		Universal	FullDayEvent
1109	171	World Cancer Day	2016-02-04 00:00:00		Universal	FullDayEvent
1110	171	International Day of Zero Tolerance to Female Genital Mutilation	2016-02-06 00:00:00		Universal	FullDayEvent
1111	171	International Day of Women and Girls in Science 	2016-02-11 00:00:00		Universal	FullDayEvent
1112	171	World Radio Day 	2016-02-13 00:00:00		Universal	FullDayEvent
1113	171	World Day of Social Justice	2016-02-20 00:00:00		Universal	FullDayEvent
1114	171	International Mother Language Day 	2016-02-21 00:00:00		Universal	FullDayEvent
1115	171	Zero Discrimination Day	2016-03-01 00:00:00		Universal	FullDayEvent
1116	171	World Wildlife Day	2016-03-03 00:00:00		Universal	FullDayEvent
1117	171	International Women’s Day 	2016-03-08 00:00:00		Universal	FullDayEvent
1118	171	International Day of Happiness	2016-03-20 00:00:00		Universal	FullDayEvent
1119	171	World Poetry Day 	2016-03-21 00:00:00		Universal	FullDayEvent
1120	171	International Day for the Elimination of Racial Discrimination 	2016-03-21 00:00:00		Universal	FullDayEvent
1121	171	International Day of Nowruz 	2016-03-21 00:00:00		Universal	FullDayEvent
1122	171	World Down Syndrome Day	2016-03-21 00:00:00		Universal	FullDayEvent
1123	171	International Day of Forests	2016-03-21 00:00:00		Universal	FullDayEvent
1124	171	World Water Day	2016-03-22 00:00:00		Universal	FullDayEvent
1125	171	World Meteorological Day	2016-03-23 00:00:00		Universal	FullDayEvent
1126	171	World Tuberculosis Day	2016-03-24 00:00:00		Universal	FullDayEvent
1127	171	International Day for the Right to the Truth concerning Gross Human Rights Violations and for the Dignity of Victims	2016-03-24 00:00:00		Universal	FullDayEvent
1128	171	International Day of Remembrance of the Victims of Slavery and the Transatlantic Slave Trade	2016-03-25 00:00:00		Universal	FullDayEvent
1129	171	International Day of Solidarity with Detained and Missing Staff Members	2016-03-25 00:00:00		Universal	FullDayEvent
1130	171	World Autism Awareness Day	2016-04-02 00:00:00		Universal	FullDayEvent
1131	171	International Day for Mine Awareness and Assistance in Mine Action	2016-04-04 00:00:00		Universal	FullDayEvent
1132	171	International Day of Sport for Development and Peace 	2016-04-06 00:00:00		Universal	FullDayEvent
1133	171	International Day of Reflection on the Genocide in Rwanda	2016-04-06 00:00:00		Universal	FullDayEvent
1134	171	World Health Day	2016-04-06 00:00:00		Universal	FullDayEvent
1135	171	International Day of Human Space Flight	2016-04-12 00:00:00		Universal	FullDayEvent
1136	171	International Mother Earth Day	2016-04-22 00:00:00		Universal	FullDayEvent
1137	171	World Book and Copyright Day 	2016-04-23 00:00:00		Universal	FullDayEvent
1138	171	World Immunization Week	2016-04-24 00:00:00		Universal	FullDayEvent
1139	171	World Malaria Day	2016-04-25 00:00:00		Universal	FullDayEvent
1140	171	World Intellectual Property Day	2016-04-26 00:00:00		Universal	FullDayEvent
1141	171	World Day for Safety and Health at Work	2016-04-28 00:00:00		Universal	FullDayEvent
1142	171	Day of Remembrance for all Victims of Chemical Warfare	2016-04-29 00:00:00		Universal	FullDayEvent
1143	171	International Jazz Day 	2016-04-30 00:00:00		Universal	FullDayEvent
1155	171	Global Day of Parents	2016-06-01 00:00:00	We are grateful to the parents for their commitment & sacrifice to raise the humanity. Thanks to United Nations, today could be a great occasion to celebrate any parents for their parenting. Saying them nice words, a little surprise, flowers….Let show them your gratitude.	Universal	FullDayEvent
1156	171	International Day of Innocent Children Victims of Aggression	2016-06-04 00:00:00		Universal	FullDayEvent
1157	171	World Environment Day 	2016-06-05 00:00:00		Universal	FullDayEvent
1158	171	World Oceans Day 	2016-06-08 00:00:00		Universal	FullDayEvent
1159	171	World Day Against Child Labour	2016-06-12 00:00:00		Universal	FullDayEvent
1160	171	International Albinism Awareness Day	2016-06-13 00:00:00		Universal	FullDayEvent
1161	171	World Blood Donor Day	2016-06-14 00:00:00		Universal	FullDayEvent
1162	171	World Elder Abuse Awareness Day	2016-06-15 00:00:00		Universal	FullDayEvent
1163	171	World Day to Combat Desertification and Drought 	2016-06-17 00:00:00		Universal	FullDayEvent
1164	171	International Day for the Elimination of Sexual Violence in Conflict 	2016-06-19 00:00:00		Universal	FullDayEvent
1165	171	World Refugee Day	2016-06-20 00:00:00		Universal	FullDayEvent
1166	171	International Day of Yoga	2016-06-21 00:00:00		Universal	FullDayEvent
1167	171	United Nations Public Service Day	2016-06-23 00:00:00		Universal	FullDayEvent
1168	171	International Widows' Day	2016-06-23 00:00:00		Universal	FullDayEvent
1169	171	Day of the Seafarer	2016-06-25 00:00:00		Universal	FullDayEvent
1170	171	International Day against Drug Abuse and Illicit Trafficking	2016-06-26 00:00:00		Universal	FullDayEvent
1171	171	United Nations International Day in Support of Victims of Torture	2016-06-26 00:00:00		Universal	FullDayEvent
1172	171	International Day of Cooperatives	2016-07-02 00:00:00		Universal	FullDayEvent
1173	171	World Population Day	2016-07-11 00:00:00		Universal	FullDayEvent
1174	171	World Youth Skills Day	2016-07-15 00:00:00		Universal	FullDayEvent
1175	171	Nelson Mandela International Day 	2016-07-18 00:00:00		Universal	FullDayEvent
1176	171	World Hepatitis Day	2016-07-28 00:00:00		Universal	FullDayEvent
1177	171	International Day of Friendship	2016-07-30 00:00:00		Universal	FullDayEvent
1178	171	World Day against Trafficking in Persons	2016-07-30 00:00:00		Universal	FullDayEvent
1179	171	International Day of the World's Indigenous People 	2016-08-09 00:00:00		Universal	FullDayEvent
1180	171	International Youth Day 	2016-08-12 00:00:00		Universal	FullDayEvent
1181	171	World Humanitarian Day	2016-08-19 00:00:00		Universal	FullDayEvent
1182	171	International Day for the Remembrance of the Slave Trade and its Abolition 	2016-08-23 00:00:00		Universal	FullDayEvent
1183	171	International Day against Nuclear Tests	2016-08-29 00:00:00		Universal	FullDayEvent
1184	171	International Day of the Victims of Enforced Disappearances	2016-08-30 00:00:00		Universal	FullDayEvent
1185	171	International Day of Charity	2016-09-05 00:00:00		Universal	FullDayEvent
1186	171	International Literacy Day 	2016-09-08 00:00:00		Universal	FullDayEvent
1187	171	United Nations Day for South-South Cooperation	2016-09-12 00:00:00		Universal	FullDayEvent
1188	171	International Day of Democracy 	2016-09-15 00:00:00		Universal	FullDayEvent
1189	171	International Day for the Preservation of the Ozone Layer	2016-09-16 00:00:00		Universal	FullDayEvent
1190	171	International Day of Peace 	2016-09-21 00:00:00		Universal	FullDayEvent
1191	171	International Day for the Total Elimination of Nuclear Weapons	2016-09-26 00:00:00		Universal	FullDayEvent
1192	171	World Tourism Day	2016-09-27 00:00:00		Universal	FullDayEvent
1193	171	World Maritime Day	2016-09-29 00:00:00		Universal	FullDayEvent
1194	171	International Day of Older Persons	2016-10-01 00:00:00		Universal	FullDayEvent
1195	171	International Day of Non-Violence	2016-10-02 00:00:00		Universal	FullDayEvent
1196	171	World Habitat Day	2016-10-03 00:00:00		Universal	FullDayEvent
1197	171	World Teachers' Day 	2016-10-05 00:00:00		Universal	FullDayEvent
1198	171	World Post Day	2016-10-09 00:00:00		Universal	FullDayEvent
1199	171	World Mental Health Day	2016-10-10 00:00:00		Universal	FullDayEvent
1200	171	International Day of the Girl Child	2016-10-11 00:00:00		Universal	FullDayEvent
1201	171	International Day for Disaster Reduction 	2016-10-13 00:00:00		Universal	FullDayEvent
1202	171	International Day of Rural Women	2016-10-15 00:00:00		Universal	FullDayEvent
1203	171	World Food Day	2016-10-16 00:00:00		Universal	FullDayEvent
1204	171	International Day for the Eradication of Poverty 	2016-10-17 00:00:00		Universal	FullDayEvent
1205	171	World Statistics Day 	2016-10-20 00:00:00		Universal	FullDayEvent
1206	171	United Nations Day	2016-10-24 00:00:00		Universal	FullDayEvent
1207	171	World Development Information Day	2016-10-24 00:00:00		Universal	FullDayEvent
1208	171	World Day for Audiovisual Heritage 	2016-10-27 00:00:00		Universal	FullDayEvent
1209	171	World Cities Day	2016-10-31 00:00:00		Universal	FullDayEvent
1210	171	International Day to End Impunity for Crimes against Journalists 	2016-11-02 00:00:00		Universal	FullDayEvent
1211	171	World Tsunami Awareness Day 	2016-11-05 00:00:00		Universal	FullDayEvent
1212	171	International Day for Preventing the Exploitation of the Environment in War and Armed Conflict 	2016-11-06 00:00:00		Universal	FullDayEvent
1213	171	World Science Day for Peace and Development 	2016-11-10 00:00:00		Universal	FullDayEvent
1214	171	World Diabetes Day	2016-11-14 00:00:00		Universal	FullDayEvent
1215	171	International Day for Tolerance 	2016-11-16 00:00:00		Universal	FullDayEvent
1216	171	World Philosophy Day 	2016-11-17 00:00:00		Universal	FullDayEvent
1217	171	World Toilet Day	2016-11-19 00:00:00		Universal	FullDayEvent
1218	171	Africa Industrialization Day	2016-11-20 00:00:00		Universal	FullDayEvent
1219	171	Universal Children’s Day	2016-11-20 00:00:00		Universal	FullDayEvent
1220	171	World Day of Remembrance for Road Traffic Victims	2016-11-20 00:00:00		Universal	FullDayEvent
1221	171	World Television Day	2016-11-21 00:00:00		Universal	FullDayEvent
1222	171	International Day for the Elimination of Violence against Women 	2016-11-25 00:00:00		Universal	FullDayEvent
1223	171	International Day of Solidarity with the Palestinian People 	2016-11-29 00:00:00		Universal	FullDayEvent
1224	171	World AIDS Day 	2016-12-01 00:00:00		Universal	FullDayEvent
1225	171	International Day for the Abolition of Slavery	2016-12-02 00:00:00		Universal	FullDayEvent
1226	171	International Day of Persons with Disabilities 	2016-12-03 00:00:00		Universal	FullDayEvent
1227	171	International Volunteer Day for Economic and Social Development	2016-12-05 00:00:00		Universal	FullDayEvent
1231	171	International Anti-Corruption Day	2016-12-09 00:00:00		Universal	FullDayEvent
1232	171	Human Rights Day 	2016-12-10 00:00:00		Universal	FullDayEvent
1233	171	International Mountain Day 	2016-12-11 00:00:00		Universal	FullDayEvent
1234	171	International Migrants Day 	2016-12-18 00:00:00		Universal	FullDayEvent
1235	171	International Human Solidarity Day	2016-12-20 00:00:00		Universal	FullDayEvent
1236	172	New Year's Day	2016-01-01 00:00:00		Universal	FullDayEvent
1237	172	World Wetlands Day	2016-02-02 00:00:00		Universal	FullDayEvent
1238	172	Valentine's Day	2016-02-14 00:00:00		Universal	FullDayEvent
1239	172	Leap Day	2016-02-29 00:00:00		Universal	FullDayEvent
1240	172	World Civil Defence Day	2016-03-01 00:00:00		Universal	FullDayEvent
1241	172	World Sleep Day	2016-03-18 00:00:00		Universal	FullDayEvent
1242	172	Pi Day	2016-03-14 00:00:00		Universal	FullDayEvent
1243	172	World Consumer Rights Day	2016-03-15 00:00:00		Universal	FullDayEvent
1244	172	World Sparrow Day	2016-03-20 00:00:00		Universal	FullDayEvent
1245	172	World Puppetry Day	2016-03-21 00:00:00		Universal	FullDayEvent
1246	172	World Theatre Day	2016-03-27 00:00:00		Universal	FullDayEvent
1247	172	International Transgender Day of Visibility	2016-03-31 00:00:00		Universal	FullDayEvent
1248	172	April Fools' Day	2016-04-01 00:00:00		Universal	FullDayEvent
1249	172	International Children's Book Day	2016-04-02 00:00:00		Universal	FullDayEvent
1250	172	International Day for Street Children	2016-04-12 00:00:00		Universal	FullDayEvent
1251	172	World Hemophilia Day	2016-04-17 00:00:00		Universal	FullDayEvent
1252	172	World Day For Animals In Laboratories	2016-04-24 00:00:00		Universal	FullDayEvent
1253	172	International Dance Day	2016-04-29 00:00:00		Universal	FullDayEvent
1254	172	International Workers' Day	2016-05-01 00:00:00		Universal	FullDayEvent
1255	172	International Firefighters' Day	2016-05-04 00:00:00		Universal	FullDayEvent
1256	172	International Midwives Day	2016-05-05 00:00:00		Universal	FullDayEvent
1257	172	World Red Cross and Red Crescent Day	2016-05-08 00:00:00		Universal	FullDayEvent
1258	172	International Nurses Day	2016-05-12 00:00:00		Universal	FullDayEvent
1259	172	International Day Against Homophobia, Transphobia and Biphobia	2016-05-17 00:00:00		Universal	FullDayEvent
1260	172	International Museum Day	2016-05-18 00:00:00		Universal	FullDayEvent
1261	172	World Turtle Day	2016-05-23 00:00:00		Universal	FullDayEvent
1262	172	World Asthma Day	2016-05-03 00:00:00		Universal	FullDayEvent
1263	172	World Fair Trade Day	2016-05-14 00:00:00		Universal	FullDayEvent
1264	172	Mother's Day	2016-05-08 00:00:00		Universal	FullDayEvent
1265	172	International Music Day	2016-10-01 00:00:00		Universal	FullDayEvent
1266	172	Fathers' Day (in some countries)	2016-06-19 00:00:00		Universal	FullDayEvent
1267	172	World Day for International Justice	2016-07-17 00:00:00		Universal	FullDayEvent
1268	172	International Tiger Day	2016-07-29 00:00:00		Universal	FullDayEvent
1269	172	International Beer Day	2016-08-05 00:00:00		Universal	FullDayEvent
1270	172	International Lefthanders Day	2016-08-13 00:00:00		Universal	FullDayEvent
1271	172	World Suicide Prevention Day	2016-09-10 00:00:00		Universal	FullDayEvent
1272	172	World Rabies Day	2016-09-28 00:00:00		Universal	FullDayEvent
1273	172	World Heart Day	2016-09-29 00:00:00		Universal	FullDayEvent
1274	172	International Coffee Day	2016-09-29 00:00:00		Universal	FullDayEvent
1275	172	International Right to Know Day	2016-09-28 00:00:00		Universal	FullDayEvent
1276	172	World Vegetarian Day	2016-10-01 00:00:00		Universal	FullDayEvent
1277	172	World Cerebral Palsy Day	2016-10-02 00:00:00		Universal	FullDayEvent
1278	172	World Animal Day	2016-10-04 00:00:00		Universal	FullDayEvent
1279	172	World Thrombosis Day	2016-10-13 00:00:00		Universal	FullDayEvent
1280	172	World Standards Day	2016-10-14 00:00:00		Universal	FullDayEvent
1281	172	Global Handwashing Day	2016-10-15 00:00:00		Universal	FullDayEvent
1282	172	World Vasectomy Day	2016-10-18 00:00:00		Universal	FullDayEvent
1283	172	World Osteoporosis Day	2016-10-20 00:00:00		Universal	FullDayEvent
1284	172	International Stuttering Awareness Day	2016-10-22 00:00:00		Universal	FullDayEvent
1285	172	International Animation Day	2016-10-28 00:00:00		Universal	FullDayEvent
1286	172	World Stroke Day	2016-10-29 00:00:00		Universal	FullDayEvent
1287	172	World Sight Day	2016-10-13 00:00:00		Universal	FullDayEvent
1288	172	World Smile Day	2016-10-07 00:00:00		Universal	FullDayEvent
1289	172	World Vegan Day	2016-11-01 00:00:00		Universal	FullDayEvent
1290	172	World Pneumonia Day	2016-11-12 00:00:00		Universal	FullDayEvent
1291	172	World Kindness Day	2016-11-13 00:00:00		Universal	FullDayEvent
1292	172	International Students Day	2016-11-17 00:00:00		Universal	FullDayEvent
1293	172	World Prematurity Day	2016-11-17 00:00:00		Universal	FullDayEvent
1294	172	International Men's Day	2016-11-19 00:00:00		Universal	FullDayEvent
1295	172	Transgender Day of Remembrance	2016-11-20 00:00:00		Universal	FullDayEvent
1296	172	World Hello Day	2016-11-21 00:00:00		Universal	FullDayEvent
1297	172	International Thank-You Day	2016-01-11 00:00:00		Universal	FullDayEvent
1298	172	World Penguin Day	2016-04-25 00:00:00		Universal	FullDayEvent
1299	172	Save The Frogs Day	2016-04-30 00:00:00		Universal	FullDayEvent
1300	172	World Snake Day	2016-07-16 00:00:00		Universal	FullDayEvent
1301	172	World Lizard Day	2016-08-14 00:00:00		Universal	FullDayEvent
1302	172	International Chocolate Day	2016-09-13 00:00:00		Universal	FullDayEvent
1303	172	World Gratitude Day	2016-09-21 00:00:00		Universal	FullDayEvent
1304	172	International Internet Day	2016-10-29 00:00:00		Universal	FullDayEvent
1305	172	International Kissing Day	2016-07-06 00:00:00		Universal	FullDayEvent
1306	172	World Wish Day	2016-04-29 00:00:00		Universal	FullDayEvent
1307	172	World Sexual Health Day	2016-09-04 00:00:00		Universal	FullDayEvent
1308	172	World First Aid Day	2016-09-10 00:00:00		Universal	FullDayEvent
1309	172	World Alzheimer's Day	2016-09-21 00:00:00		Universal	FullDayEvent
1310	172	World Car Free Day	2016-09-22 00:00:00		Universal	FullDayEvent
1311	172	World Hepatitis Day	2016-07-28 00:00:00		Universal	FullDayEvent
1312	172	Singles' Day	2016-11-11 00:00:00		Universal	FullDayEvent
1313	172	World Milk Day	2016-06-01 00:00:00		Universal	FullDayEvent
1314	172	International Tourist Guide Day	2016-02-21 00:00:00		Universal	FullDayEvent
1315	173	Combat Tuberculosis Week 	2016-01-04 00:00:00		Universal	FullDayEvent
1316	173	White Cane Week 	2016-01-07 00:00:00		Universal	FullDayEvent
1319	173	Civil Defence Day	2016-02-28 00:00:00		Universal	FullDayEvent
1320	173	Green Crescent Week	2016-03-01 00:00:00		Universal	FullDayEvent
1321	173	Brain Awareness Week	2016-03-13 00:00:00		Universal	FullDayEvent
1322	173	Medicine Day	2016-03-14 00:00:00		Universal	FullDayEvent
1323	173	Çanakkale Martyrs' Memorial Day	2016-03-18 00:00:00		Universal	FullDayEvent
1324	173	Respect for the Elderly Week 	2016-03-18 00:00:00		Universal	FullDayEvent
1325	173	Turksih World Cinema Day 	2016-03-19 00:00:00		Universal	FullDayEvent
1326	173	Nawruz	2016-03-20 00:00:00		Universal	FullDayEvent
1327	173	Heart Awareness Week	2016-04-10 00:00:00		Universal	FullDayEvent
1328	173	Library Week	2016-03-28 00:00:00		Universal	FullDayEvent
1329	173	Cancer Awareness Week	2016-04-01 00:00:00		Universal	FullDayEvent
1330	173	Lawyers' Day	2016-04-05 00:00:00		Universal	FullDayEvent
1331	173	Martyred Journalists' Day	2016-04-06 00:00:00		Universal	FullDayEvent
1332	173	Great Sinan & Architects' Day	2016-04-09 00:00:00		Universal	FullDayEvent
1333	173	Turkish Police Day	2016-04-10 00:00:00		Universal	FullDayEvent
1334	173	Secularism Day	2016-04-10 00:00:00		Universal	FullDayEvent
1335	173	Tourism Week 	2016-04-15 00:00:00		Universal	FullDayEvent
1336	173	Observing Child Development Day	2016-04-15 00:00:00		Universal	FullDayEvent
1337	173	Efficiency Day	2016-04-15 00:00:00		Universal	FullDayEvent
1338	173	Poet Karacaoglan's Memorial Day	2016-04-18 00:00:00		Universal	FullDayEvent
1339	173	Midwives' Week	2016-04-21 00:00:00		Universal	FullDayEvent
1340	173	National Sovereignty and Children's Day	2016-04-23 00:00:00		Universal	FullDayEvent
1341	173	Brotherhood Week	2016-04-28 00:00:00		Universal	FullDayEvent
1342	173	Safety and Health at Work Week	2016-05-04 00:00:00		Universal	FullDayEvent
1343	173	Hıdrellez	2016-05-06 00:00:00		Universal	FullDayEvent
1344	173	Social Security Week	2016-05-10 00:00:00		Universal	FullDayEvent
1345	173	Pharmacy Day	2016-05-14 00:00:00		Universal	FullDayEvent
1346	173	Aviation Martyrs' Memorial Day	2016-05-15 00:00:00		Universal	FullDayEvent
1347	173	Commemoration of Atatürk, Youth and Sports Day	2016-05-19 00:00:00		Universal	FullDayEvent
1348	173	Farmers' Day	2016-05-14 00:00:00		Universal	FullDayEvent
1349	173	Insurance Week	2016-05-25 00:00:00		Universal	FullDayEvent
1350	173	Memorial Day for Martyred Turkish Diplomats 	2016-05-30 00:00:00		Universal	FullDayEvent
1351	173	Leukemia Awareness Day	2016-05-30 00:00:00		Universal	FullDayEvent
1352	173	Hostess' Day	2016-05-31 00:00:00		Universal	FullDayEvent
1353	173	 National Phenylketonuria Day	2016-06-01 00:00:00	4 out of every 100 citizens in Turkey have Phenylketonuria. The good news is, you can prevent it by early detection. Be aware & spread this awareness.	Universal	FullDayEvent
1354	173	Atatürk Festival in Amasya	2016-06-12 00:00:00		Universal	FullDayEvent
1355	173	Cabotage and Turkish Maritime Festival	2016-07-01 00:00:00		Universal	FullDayEvent
1356	173	Martyrs of Press Memorial Day	2016-07-23 00:00:00		Universal	FullDayEvent
1357	173	Press Day	2016-07-24 00:00:00		Universal	FullDayEvent
1358	173	Avicenna Memorial Week 	2016-08-17 00:00:00		Universal	FullDayEvent
1359	173	Turkish Armed Forces Day	2016-08-26 00:00:00		Universal	FullDayEvent
1360	173	Victory Day	2016-08-30 00:00:00		Universal	FullDayEvent
1361	173	Veterans Day	2016-09-19 00:00:00		Universal	FullDayEvent
1362	173	Turkish Language Day	2016-09-26 00:00:00		Universal	FullDayEvent
1363	173	Turkish Naval Forces Day	2016-09-27 00:00:00		Universal	FullDayEvent
1364	173	Individual Disarmament Day	2016-09-28 00:00:00		Universal	FullDayEvent
1365	173	Ahi Culture Week	2016-10-10 00:00:00		Universal	FullDayEvent
1366	173	Fire Prevention Day	2016-09-25 00:00:00		Universal	FullDayEvent
1367	173	Turkish Troubadours Day	2016-10-15 00:00:00		Universal	FullDayEvent
1368	173	Republic Day Eve	2016-10-28 00:00:00		Universal	FullDayEvent
1369	173	Republic Day	2016-10-29 00:00:00		Universal	FullDayEvent
1370	173	Organ Donation Week	2016-11-03 00:00:00		Universal	FullDayEvent
1371	173	Ataturk Memorial Day	2016-11-10 00:00:00		Universal	FullDayEvent
1372	173	Dentist's Day	2016-11-22 00:00:00		Universal	FullDayEvent
1373	173	Teachers' Day	2016-11-24 00:00:00		Universal	FullDayEvent
1374	173	Fight Against Erosion Week	2016-11-26 00:00:00		Universal	FullDayEvent
1375	173	Foundations Week	2016-12-03 00:00:00		Universal	FullDayEvent
1376	173	Women's Rights Day	2016-12-05 00:00:00		Universal	FullDayEvent
1377	173	Rumi Memorial Week 	2016-12-05 00:00:00		Universal	FullDayEvent
1378	173	Saving, Investment and Turkish Goods Week	2016-12-12 00:00:00		Universal	FullDayEvent
1379	174	 Brunei Independence Day	2016-01-01 00:00:00		Universal	FullDayEvent
1380	175	 Cameroon Independence Day	2016-01-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1381	176	 Czech Republic Independence Day	2016-01-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1382	177	 Haiti Independence Day	2016-01-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1383	178	 Sudan Independence Day	2016-01-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1384	179	 Myanmar Independence Day	2016-01-04 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1385	180	 Nauru Independence Day	2016-01-31 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1386	181	 Sri Lanka Independence Day	2016-02-04 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1387	182	 Grenada Independence Day	2016-02-07 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1388	183	 Chile Independence Day	2016-09-18 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1389	184	 Tibet Independence Day	2016-02-13 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1390	185	 Serbia Independence Day	2016-02-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1391	186	 Lithuania Independence Day	2016-02-16 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1392	187	 Kosovo Independence Day	2016-02-17 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1393	188	The Gambia Independence Day	2016-02-18 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1394	189	 Saint Lucia Independence Day	2016-02-22 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1395	190	 Estonia Independence Day	2016-02-24 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1396	191	 Kuwait Independence Day	2016-02-25 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1397	192	 Dominican Republic Independence Day	2016-02-27 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1398	193	 Bosnia and Herzegovina Independence Day	2016-03-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1399	194	 Ghana Independence Day	2016-03-06 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1400	186	 Act of the Re-Establishment of the State of Lithuania	2016-03-11 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1401	195	 Mauritius Independence Day	2016-03-12 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1402	196	 Tunisia Independence Day	2016-03-20 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1403	197	 Namibia Independence Day	2016-03-21 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1404	198	 Greece Independence Day	2016-03-25 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1405	199	 Bangladesh Independence Day	2016-03-26 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1406	200	 Senegal Independence Day	2016-04-04 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1407	201	 Georgia Independence Day	2016-04-09 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1408	202	 Syria Independence Day	2016-04-17 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1409	203	 Zimbabwe Independence Day	2016-04-18 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1410	204	 Ireland Independence Day	2016-04-24 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1411	205	 Sierra Leone Independence Day	2016-04-27 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1412	206	 Togo Independence Day	2016-04-27 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1413	207	 Latvia Independence Day	2016-05-04 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1414	208	 Romania Independence Day	2016-05-10 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1415	209	 Israel** Independence Day	2016-05-12 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Hebrew Calendar	FullDayEvent
1416	210	 Paraguay Independence Day	2016-05-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1417	211	 Norway Independence Day	2016-05-17 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1418	212	 Cuba Independence Day	2016-05-20 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1419	213	 East Timor Independence Day	2016-05-20 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1420	214	 Montenegro Independence Day	2016-05-21 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1421	215	 Ecuador Independence Day	2016-05-24 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1422	216	 Eritrea Independence Day	2016-05-24 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1423	217	 Jordan Independence Day	2016-05-25 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1424	218	 Guyana Independence Day	2016-05-26 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1425	219	 Armenia Independence Day	2016-05-28 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1426	220	 Azerbaijan Independence Day	2016-05-28 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1427	221	 Samoa Independence Day	2016-06-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1428	222	 Tonga Independence Day	2016-06-04 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1429	223	 Sweden Independence Day	2016-06-06 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1430	224	 Philippines Independence Day	2016-06-12 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1431	225	 Iceland Independence Day	2016-06-17 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1432	226	 Mozambique Independence Day	2016-06-25 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1433	227	 Madagascar Independence Day	2016-06-26 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1434	228	 Djibouti Independence Day	2016-06-27 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1435	229	 Seychelles Independence Day	2016-06-29 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1436	230	 Congo, Democratic Republic of th Independence Daye	2016-06-30 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1437	231	 Burundi Independence Day	2016-07-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1438	232	 Canada Independence Day	2016-07-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1439	233	 Rwanda Independence Day	2016-07-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1440	234	 Somalia Independence Day	2016-07-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1441	235	 Belarus Independence Day	2016-07-03 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1442	236	 Abkhazia Independence Day	2016-07-04 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1443	237	 Algeria Independence Day	2016-07-05 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1444	238	 Cape Verde Independence Day	2016-07-05 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1445	239	 Venezuela Independence Day	2016-07-05 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1446	240	 Comoros Independence Day	2016-07-06 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1447	241	 Malawi Independence Day	2016-07-06 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1448	242	 Solomon Islands Independence Day	2016-07-07 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1449	243	 Argentina Independence Day	2016-07-09 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1450	244	 South Sudan Independence Day	2016-07-09 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1451	245	 Bahamas Independence Day	2016-07-10 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1452	246	 Kiribati Independence Day	2016-07-12 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1453	247	 São Tomé and Príncipe Independence Day	2016-07-12 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1454	248	 Slovakia Independence Day	2016-07-17 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1455	249	 Colombia Independence Day	2016-07-20 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1456	250	 Colombia Independence Day	2016-08-07 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1457	251	 Belgium Independence Day	2016-07-21 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1458	252	 Liberia Independence Day	2016-07-26 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1459	253	 Maldives Independence Day	2016-07-26 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1460	254	 Peru Independence Day	2016-07-28 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1461	255	 Vanuatu Independence Day	2016-07-30 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1462	256	 Benin Independence Day	2016-07-31 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1463	257	 Switzerland Independence Day	2016-07-31 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1464	258	 Niger Independence Day	2016-08-03 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1465	259	 Burkina Faso Independence Day	2016-08-05 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1466	260	 Bolivia Independence Day	2016-08-06 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1467	261	 Jamaica Independence Day	2016-08-06 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1468	262	 Ivory Coast Independence Day	2016-08-07 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1469	263	 Singapore Independence Day	2016-08-09 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1470	264	 Chad Independence Day	2016-08-11 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1471	265	 Central African Republic Independence Day	2016-08-13 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1472	266	 Pakistan Independence Day	2016-08-14 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1473	267	Republic of the  Congo Independence Day	2016-08-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1474	268	 India Independence Day	2016-08-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1475	269	North Korea Independence Day	2016-08-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1476	270	South Korea Independence Day	2016-08-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1477	271	 Gabon Independence Day	2016-08-17 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1478	272	 Indonesia Independence Day	2016-08-17 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1479	273	 Afghanistan Independence Day	2016-08-19 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1480	274	 Hungary Independence Day	2016-08-20 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1481	275	Ukraine Independence Day	2016-08-24 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1482	276	Ukraine Unity Day	2016-01-22 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1483	277	 Uruguay Independence Day	2016-08-25 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1484	278	 Moldova Independence Day	2016-08-27 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1485	279	 Kyrgyzstan Independence Day	2016-08-31 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1486	280	 Malaysia Independence Day	2016-08-31 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1487	281	 Trinidad and Tobago Independence Day	2016-08-31 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1488	282	 Uzbekistan Independence Day	2016-09-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1489	283	 Northern Cyprus Independence Day	2016-09-02 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1490	284	 Vietnam Independence Day	2016-09-02 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1491	285	 Swaziland Independence Day	2016-09-06 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1492	286	 Brazil Independence Day	2016-09-07 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1493	287	Republic of Macedonia Independence Day	2016-09-08 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1494	288	Tajikistan Independence Day	2016-09-09 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1495	289	 Costa Rica Independence Day	2016-09-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1496	290	 El Salvador Independence Day	2016-09-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1497	291	 Guatemala Independence Day	2016-09-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1498	292	 Honduras Independence Day	2016-09-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1499	293	 Nicaragua Independence Day	2016-09-15 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1500	294	 Mexico Independence Day	2016-09-16 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1501	295	 Papua New Guinea Independence Day	2016-09-16 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1502	296	 Saint Kitts and Nevis Independence Day	2016-09-19 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1503	297	 Belize Independence Day	2016-09-21 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1504	298	 Malta Independence Day	2016-09-21 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1505	299	 Bulgaria Independence Day	2016-09-22 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1506	300	 Mali Independence Day	2016-09-22 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1507	301	 Guinea-Bissau Independence Day	2016-09-24 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1508	302	 Botswana Independence Day	2016-09-30 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1509	303	 Cyprus Independence Day	2016-10-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1510	304	 Nigeria Independence Day	2016-10-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1511	305	 Tuvalu Independence Day	2016-10-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1512	306	 Guinea Independence Day	2016-10-02 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1513	307	 Iraq Independence Day	2016-10-03 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1514	308	 Lesotho Independence Day	2016-10-04 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1515	309	 Croatia Independence Day	2016-10-08 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1516	310	 Uganda Independence Day	2016-10-09 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1517	311	 Fiji Independence Day	2016-10-10 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1518	312	 Equatorial Guinea Independence Day	2016-10-12 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1519	313	 Laos Independence Day	2016-10-22 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1520	314	 Zambia Independence Day	2016-10-24 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1521	315	 Austria Independence Day	2016-10-26 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1522	316	 Saint Vincent and the Grenadines Independence Day	2016-10-27 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1523	317	 Turkmenistan Independence Day	2016-10-27 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1524	318	 Turkey Independence Day	2016-10-29 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1525	319	 Antigua and Barbuda Independence Day	2016-11-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1526	320	 Dominica Independence Day	2016-11-03 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1527	321	 Panama Independence Day	2016-11-03 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1528	322	 Cambodia Independence Day	2016-11-09 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1529	323	 Angola Independence Day	2016-11-11 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1530	324	 Poland Independence Day	2016-11-11 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1531	325	 Rhodesia Independence Day	2016-11-11 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1532	326	 Morocco Independence Day	2016-11-18 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1533	327	 Lebanon Independence Day	2016-11-22 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1534	328	 Suriname Independence Day	2016-11-25 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1535	329	 Albania Independence Day	2016-11-28 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1536	330	 Mauritania Independence Day	2016-11-28 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1537	331	 Barbados Independence Day	2016-11-30 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1538	332	 Yemen Independence Day	2016-11-30 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1539	333	 Portugal Independence Day	2016-12-01 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1540	334	 United Arab Emirates Independence Day	2016-12-02 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1541	335	 Finland Independence Day	2016-12-06 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1542	336	 Tanzania Independence Day	2016-12-09 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1543	337	 South Africa Independence Day	2016-12-11 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1544	338	 Kenya Independence Day	2016-12-12 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1545	339	 Bahrain Independence Day	2016-12-16 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1546	340	 Kazakhstan Independence Day	2016-12-16 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1547	341	 Qatar Independence Day	2016-12-18 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1548	342	 Libya Independence Day	2016-12-24 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1549	343	 Slovenia Statehood Day Independence Day	2016-06-25 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1550	344	 Slovenia Independence and Unity Day	2016-12-26 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1551	345	 Mongolia Independence Day	2016-12-29 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
1552	346	 United States Independence Day	2016-07-04 00:00:00	Everyone deserves freedom. Happy Independence Day to + "Sub-Category"  	Universal	FullDayEvent
\.


--
-- Name: beonecalendarevents_eventid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('beonecalendarevents_eventid_seq', 1552, true);


--
-- Data for Name: beonecalendars; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY beonecalendars (calendarid, calendarname, description) FROM stdin;
8	Astro Events	\N
9	Nature Events 	\N
10	Holy Days	\N
11	International Days 	\N
12	National Days	\N
13	Independence Days	\N
\.


--
-- Name: beonecalendars_calendarid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('beonecalendars_calendarid_seq', 13, true);


--
-- Data for Name: beonecalendarsubcategories; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY beonecalendarsubcategories (subcategoryid, calendarid, calendarsubcategory, description) FROM stdin;
150	8	Eclipses	Initial content. Not taken from Excel file.
151	8	Equinoxes and Solstices	Initial content. Not taken from Excel file.
152	8	Meteor Showers	Initial content. Not taken from Excel file.
153	8	Moon Phases	Initial content. Not taken from Excel file.
154	8	Rise & Set 	Initial content. Not taken from Excel file.
155	8	Planetary Retrogrades	Initial content. Not taken from Excel file.
156	9	Plants 	Initial content. Not taken from Excel file.
157	9	Animals	Initial content. Not taken from Excel file.
158	9	Weather & Other	Initial content. Not taken from Excel file.
159	10	Bahá'í Faith	Initial content. Not taken from Excel file.
160	10	Buddhism	Initial content. Not taken from Excel file.
161	10	Christianity (All Denominations)	Initial content. Not taken from Excel file.
162	10	Hinduism	Initial content. Not taken from Excel file.
163	10	Islam	Initial content. Not taken from Excel file.
164	10	Islam 	Initial content. Not taken from Excel file.
165	10	Jainism	Initial content. Not taken from Excel file.
166	10	Judaism	Initial content. Not taken from Excel file.
167	10	Paganism	Initial content. Not taken from Excel file.
168	10	Shinto	Initial content. Not taken from Excel file.
169	10	Sikhism	Initial content. Not taken from Excel file.
170	10	Zoroastrianism	Initial content. Not taken from Excel file.
171	11	United Nations International Days	Initial content. Not taken from Excel file.
172	11	Other	Initial content. Not taken from Excel file.
173	12	Turkey	Initial content. Not taken from Excel file.
174	13	 Brunei	Initial content. Not taken from Excel file.
175	13	 Cameroon	Initial content. Not taken from Excel file.
176	13	 Czech Republic	Initial content. Not taken from Excel file.
177	13	 Haiti	Initial content. Not taken from Excel file.
178	13	 Sudan	Initial content. Not taken from Excel file.
179	13	 Myanmar	Initial content. Not taken from Excel file.
180	13	 Nauru	Initial content. Not taken from Excel file.
181	13	 Sri Lanka	Initial content. Not taken from Excel file.
182	13	 Grenada	Initial content. Not taken from Excel file.
183	13	 Chile Independence Day	Initial content. Not taken from Excel file.
184	13	 Tibet	Initial content. Not taken from Excel file.
185	13	 Serbia	Initial content. Not taken from Excel file.
186	13	 Lithuania	Initial content. Not taken from Excel file.
187	13	 Kosovo	Initial content. Not taken from Excel file.
188	13	 Gambia, The	Initial content. Not taken from Excel file.
189	13	 Saint Lucia	Initial content. Not taken from Excel file.
190	13	 Estonia	Initial content. Not taken from Excel file.
191	13	 Kuwait	Initial content. Not taken from Excel file.
192	13	 Dominican Republic	Initial content. Not taken from Excel file.
193	13	 Bosnia and Herzegovina	Initial content. Not taken from Excel file.
194	13	 Ghana	Initial content. Not taken from Excel file.
195	13	 Mauritius	Initial content. Not taken from Excel file.
196	13	 Tunisia	Initial content. Not taken from Excel file.
197	13	 Namibia	Initial content. Not taken from Excel file.
198	13	 Greece	Initial content. Not taken from Excel file.
199	13	 Bangladesh	Initial content. Not taken from Excel file.
200	13	 Senegal	Initial content. Not taken from Excel file.
201	13	 Georgia	Initial content. Not taken from Excel file.
202	13	 Syria	Initial content. Not taken from Excel file.
203	13	 Zimbabwe	Initial content. Not taken from Excel file.
204	13	 Ireland	Initial content. Not taken from Excel file.
205	13	 Sierra Leone	Initial content. Not taken from Excel file.
206	13	 Togo	Initial content. Not taken from Excel file.
207	13	 Latvia	Initial content. Not taken from Excel file.
208	13	 Romania	Initial content. Not taken from Excel file.
209	13	 Israel**	Initial content. Not taken from Excel file.
210	13	 Paraguay	Initial content. Not taken from Excel file.
211	13	 Norway	Initial content. Not taken from Excel file.
212	13	 Cuba	Initial content. Not taken from Excel file.
213	13	 East Timor	Initial content. Not taken from Excel file.
214	13	 Montenegro	Initial content. Not taken from Excel file.
215	13	 Ecuador	Initial content. Not taken from Excel file.
216	13	 Eritrea	Initial content. Not taken from Excel file.
217	13	 Jordan	Initial content. Not taken from Excel file.
218	13	 Guyana	Initial content. Not taken from Excel file.
219	13	 Armenia	Initial content. Not taken from Excel file.
220	13	 Azerbaijan	Initial content. Not taken from Excel file.
221	13	 Samoa	Initial content. Not taken from Excel file.
222	13	 Tonga	Initial content. Not taken from Excel file.
223	13	 Sweden	Initial content. Not taken from Excel file.
224	13	 Philippines	Initial content. Not taken from Excel file.
225	13	 Iceland	Initial content. Not taken from Excel file.
226	13	 Mozambique	Initial content. Not taken from Excel file.
227	13	 Madagascar	Initial content. Not taken from Excel file.
228	13	 Djibouti	Initial content. Not taken from Excel file.
229	13	 Seychelles	Initial content. Not taken from Excel file.
230	13	 Congo, Democratic Republic of the	Initial content. Not taken from Excel file.
231	13	 Burundi	Initial content. Not taken from Excel file.
232	13	 Canada	Initial content. Not taken from Excel file.
233	13	 Rwanda	Initial content. Not taken from Excel file.
234	13	 Somalia	Initial content. Not taken from Excel file.
235	13	 Belarus	Initial content. Not taken from Excel file.
236	13	 Abkhazia	Initial content. Not taken from Excel file.
237	13	 Algeria	Initial content. Not taken from Excel file.
238	13	 Cape Verde	Initial content. Not taken from Excel file.
239	13	 Venezuela	Initial content. Not taken from Excel file.
240	13	 Comoros	Initial content. Not taken from Excel file.
241	13	 Malawi	Initial content. Not taken from Excel file.
242	13	 Solomon Islands	Initial content. Not taken from Excel file.
243	13	 Argentina	Initial content. Not taken from Excel file.
244	13	 South Sudan	Initial content. Not taken from Excel file.
245	13	 Bahamas	Initial content. Not taken from Excel file.
246	13	 Kiribati	Initial content. Not taken from Excel file.
247	13	 São Tomé and Príncipe	Initial content. Not taken from Excel file.
248	13	 Slovakia	Initial content. Not taken from Excel file.
249	13	 Colombia Independence Day	Initial content. Not taken from Excel file.
250	13	 Colombia Battle of Boyoca Day	Initial content. Not taken from Excel file.
251	13	 Belgium	Initial content. Not taken from Excel file.
252	13	 Liberia	Initial content. Not taken from Excel file.
253	13	 Maldives	Initial content. Not taken from Excel file.
254	13	 Peru	Initial content. Not taken from Excel file.
255	13	 Vanuatu	Initial content. Not taken from Excel file.
256	13	 Benin	Initial content. Not taken from Excel file.
257	13	 Switzerland	Initial content. Not taken from Excel file.
258	13	 Niger	Initial content. Not taken from Excel file.
259	13	 Burkina Faso	Initial content. Not taken from Excel file.
260	13	 Bolivia	Initial content. Not taken from Excel file.
261	13	 Jamaica	Initial content. Not taken from Excel file.
262	13	 Ivory Coast	Initial content. Not taken from Excel file.
263	13	 Singapore	Initial content. Not taken from Excel file.
264	13	 Chad	Initial content. Not taken from Excel file.
265	13	 Central African Republic	Initial content. Not taken from Excel file.
266	13	 Pakistan	Initial content. Not taken from Excel file.
267	13	 Congo, Republic of the	Initial content. Not taken from Excel file.
268	13	 India	Initial content. Not taken from Excel file.
269	13	 Korea, North	Initial content. Not taken from Excel file.
270	13	 Korea, South	Initial content. Not taken from Excel file.
271	13	 Gabon	Initial content. Not taken from Excel file.
272	13	 Indonesia	Initial content. Not taken from Excel file.
273	13	 Afghanistan	Initial content. Not taken from Excel file.
274	13	 Hungary	Initial content. Not taken from Excel file.
275	13	Ukraine Independence Day	Initial content. Not taken from Excel file.
276	13	Ukraine Unity Day	Initial content. Not taken from Excel file.
277	13	 Uruguay	Initial content. Not taken from Excel file.
278	13	 Moldova	Initial content. Not taken from Excel file.
279	13	 Kyrgyzstan	Initial content. Not taken from Excel file.
280	13	 Malaysia	Initial content. Not taken from Excel file.
281	13	 Trinidad and Tobago	Initial content. Not taken from Excel file.
282	13	 Uzbekistan	Initial content. Not taken from Excel file.
283	13	 Northern Cyprus	Initial content. Not taken from Excel file.
284	13	 Vietnam	Initial content. Not taken from Excel file.
285	13	 Swaziland	Initial content. Not taken from Excel file.
286	13	 Brazil	Initial content. Not taken from Excel file.
287	13	 Macedonia, Republic of	Initial content. Not taken from Excel file.
288	13	 Tajikistan	Initial content. Not taken from Excel file.
289	13	 Costa Rica	Initial content. Not taken from Excel file.
290	13	 El Salvador	Initial content. Not taken from Excel file.
291	13	 Guatemala	Initial content. Not taken from Excel file.
292	13	 Honduras	Initial content. Not taken from Excel file.
293	13	 Nicaragua	Initial content. Not taken from Excel file.
294	13	 Mexico	Initial content. Not taken from Excel file.
295	13	 Papua New Guinea	Initial content. Not taken from Excel file.
296	13	 Saint Kitts and Nevis	Initial content. Not taken from Excel file.
297	13	 Belize	Initial content. Not taken from Excel file.
298	13	 Malta	Initial content. Not taken from Excel file.
299	13	 Bulgaria	Initial content. Not taken from Excel file.
300	13	 Mali	Initial content. Not taken from Excel file.
301	13	 Guinea-Bissau	Initial content. Not taken from Excel file.
302	13	 Botswana	Initial content. Not taken from Excel file.
303	13	 Cyprus	Initial content. Not taken from Excel file.
304	13	 Nigeria	Initial content. Not taken from Excel file.
305	13	 Tuvalu	Initial content. Not taken from Excel file.
306	13	 Guinea	Initial content. Not taken from Excel file.
307	13	 Iraq	Initial content. Not taken from Excel file.
308	13	 Lesotho	Initial content. Not taken from Excel file.
309	13	 Croatia	Initial content. Not taken from Excel file.
310	13	 Uganda	Initial content. Not taken from Excel file.
311	13	 Fiji	Initial content. Not taken from Excel file.
312	13	 Equatorial Guinea	Initial content. Not taken from Excel file.
313	13	 Laos	Initial content. Not taken from Excel file.
314	13	 Zambia	Initial content. Not taken from Excel file.
315	13	 Austria	Initial content. Not taken from Excel file.
316	13	 Saint Vincent and the Grenadines	Initial content. Not taken from Excel file.
317	13	 Turkmenistan	Initial content. Not taken from Excel file.
318	13	 Turkey	Initial content. Not taken from Excel file.
319	13	 Antigua and Barbuda	Initial content. Not taken from Excel file.
320	13	 Dominica	Initial content. Not taken from Excel file.
321	13	 Panama	Initial content. Not taken from Excel file.
322	13	 Cambodia	Initial content. Not taken from Excel file.
323	13	 Angola	Initial content. Not taken from Excel file.
324	13	 Poland	Initial content. Not taken from Excel file.
325	13	 Rhodesia	Initial content. Not taken from Excel file.
326	13	 Morocco	Initial content. Not taken from Excel file.
327	13	 Lebanon	Initial content. Not taken from Excel file.
328	13	 Suriname	Initial content. Not taken from Excel file.
329	13	 Albania	Initial content. Not taken from Excel file.
330	13	 Mauritania	Initial content. Not taken from Excel file.
331	13	 Barbados	Initial content. Not taken from Excel file.
332	13	 Yemen	Initial content. Not taken from Excel file.
333	13	 Portugal	Initial content. Not taken from Excel file.
334	13	 United Arab Emirates	Initial content. Not taken from Excel file.
335	13	 Finland	Initial content. Not taken from Excel file.
336	13	 Tanzania	Initial content. Not taken from Excel file.
337	13	 South Africa	Initial content. Not taken from Excel file.
338	13	 Kenya	Initial content. Not taken from Excel file.
339	13	 Bahrain	Initial content. Not taken from Excel file.
340	13	 Kazakhstan	Initial content. Not taken from Excel file.
341	13	 Qatar	Initial content. Not taken from Excel file.
342	13	 Libya	Initial content. Not taken from Excel file.
343	13	 Slovenia Statehood Day	Initial content. Not taken from Excel file.
344	13	 Slovenia Independence and Unity Day	Initial content. Not taken from Excel file.
345	13	 Mongolia	Initial content. Not taken from Excel file.
346	13	 United States	Initial content. Not taken from Excel file.
\.


--
-- Name: beonecalendarsubcategories_subcategoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('beonecalendarsubcategories_subcategoryid_seq', 346, true);


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY city (cityid, countryid, cityname) FROM stdin;
1	1	Munich
2	1	Augsburg
3	1	Freising
4	1	Nuernberg
5	1	Ulm
6	2	Istanbul
7	2	Bursa
8	2	Adana
9	2	Izmir
10	2	Ankara
\.


--
-- Name: city_cityid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('city_cityid_seq', 10, true);


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY country (countryid, countryname) FROM stdin;
1	Germany
2	Turkey
3	United Kingdom
\.


--
-- Name: country_countryid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('country_countryid_seq', 3, true);


--
-- Data for Name: dailies; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY dailies (dailyid, dailytitle, dailycategoryid, dailydescription) FROM stdin;
\.


--
-- Name: dailies_dailyid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('dailies_dailyid_seq', 1, false);


--
-- Data for Name: dailycategories; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY dailycategories (categoryid, categoryname) FROM stdin;
\.


--
-- Name: dailycategories_categoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('dailycategories_categoryid_seq', 1, false);


--
-- Data for Name: likeduserexperiences; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY likeduserexperiences (entryid, userexperienceid, userid) FROM stdin;
\.


--
-- Name: likeduserexperiences_entryid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('likeduserexperiences_entryid_seq', 1, false);


--
-- Data for Name: newsfeed; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY newsfeed (feedid, feedtitle, feedcontent, feedauthor, feedpublishdate, createdat, updatedat) FROM stdin;
\.


--
-- Name: newsfeed_feedid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('newsfeed_feedid_seq', 1, false);


--
-- Data for Name: profileentry; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY profileentry (entryid, userid, fieldname, fieldvalue, createdat, updatedat) FROM stdin;
\.


--
-- Name: profileentry_entryid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('profileentry_entryid_seq', 1, false);


--
-- Data for Name: usercalendars; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY usercalendars (userid, calendarid, createdat, updatedat) FROM stdin;
3	8	\N	\N
\.


--
-- Data for Name: userconnection; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY userconnection (userid, providerid, provideruserid, rank, displayname, profileurl, imageurl, accesstoken, secret, refreshtoken, expiretime, createdat, updatedat) FROM stdin;
\.


--
-- Data for Name: userexperiencecomments; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY userexperiencecomments (commentid, userid, userexperienceid, commentedcommentid, commentdescription) FROM stdin;
\.


--
-- Name: userexperiencecomments_commentid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('userexperiencecomments_commentid_seq', 1, false);


--
-- Data for Name: userexperiences; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY userexperiences (userexperienceid, userid, experiencedescription, createdat, updatedat, experiencedate) FROM stdin;
\.


--
-- Name: userexperiences_userexperienceid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('userexperiences_userexperienceid_seq', 1, false);


--
-- Data for Name: userfriends; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY userfriends (userid, frienduserid, friendshipstatus, createdat, updatedat) FROM stdin;
\.


--
-- Data for Name: userlikednews; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY userlikednews (entryid, userid, newsid, createdat, updatedat) FROM stdin;
\.


--
-- Name: userlikednews_entryid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('userlikednews_entryid_seq', 1, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY users (userid, username, email, password, firstname, lastname, birthday, gender, currentcityid, provider, createdat, updatedat) FROM stdin;
1	engingokten	engin@beone.com	1234	Engin	G&ouml;kten	1981-01-01	Male	6	beone	2016-07-10 21:38:49.715	2016-07-10 21:38:49.715
2	selcukbeyhan	selcuk@beone.com	1234	Selcuk	Beyhan	1981-01-01	Male	6	beone	2016-07-10 21:38:49.746	2016-07-10 21:38:49.746
3	user1	user1@beone.com	1234	User 1	Test1	1981-01-01	Male	6	beone	2016-07-10 21:38:49.778	2016-07-10 21:38:49.778
\.


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('users_userid_seq', 3, true);


--
-- Data for Name: usertokens; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY usertokens (entryid, userid, token, createdat, updatedat) FROM stdin;
1	3	79946eb2-b529-4a78-8c80-efdd3646f541	\N	\N
2	3	ec6e4d32-e7f0-4ba0-99fb-599a213166a6	\N	\N
3	3	802c49db-38b7-4bed-95c4-cde19a1a52cc	\N	\N
4	3	0c912546-bd9b-4f55-8b9f-e5448506bd4a	\N	\N
5	3	cea54362-5fd2-42e8-b30e-4b21dcf4f97d	\N	\N
6	3	a71b1c89-a4eb-4ae2-81a0-52a5915c5704	\N	\N
7	3	c7e98768-d9e0-444b-98cf-ba5316326a4e	\N	\N
8	3	4a0c5a45-9461-4e67-afb9-d1f958223598	\N	\N
9	3	0d009e36-fffd-4ec6-945d-e391d34eb3ba	\N	\N
10	3	76bf02a0-4759-49ec-8110-13a3ba1aa649	\N	\N
11	3	7ad84a73-7b3f-4ad4-8aa7-06ed2e575147	\N	\N
12	3	88a46184-61ab-47e4-8450-9002564be4c6	\N	\N
13	3	a0bab9f9-8329-430c-829f-97f7cb008ae8	\N	\N
14	3	9d397460-7c92-44be-89e5-519a9037ff99	\N	\N
15	3	bb0c5868-8779-4346-be00-6af8fac401f0	\N	\N
16	3	b3472dbd-5e07-4ba3-8c31-59dc68a7f720	\N	\N
17	3	0306a12d-f68c-48c3-a91c-cf675bd2315c	\N	\N
18	3	8a23e8f1-c7c8-470e-ab4c-40e6ed269f1e	\N	\N
19	3	e8d0a00a-ab6e-4b2f-a9b9-208157822e04	\N	\N
20	3	2b42c020-0d43-41a3-aa8f-cdb815603340	\N	\N
21	3	32da23f2-e60f-45a1-8b62-c29e06b6fe12	\N	\N
22	3	6c774bce-065d-44e6-8115-ee7640987eb7	\N	\N
23	3	c1c85fe6-b3ac-42e1-8273-03e84b43c3cf	\N	\N
24	3	220851b7-6fb2-40bd-bf6f-efe8ba2b9336	\N	\N
\.


--
-- Name: usertokens_entryid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('usertokens_entryid_seq', 24, true);


--
-- Data for Name: userwishdailychecks; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY userwishdailychecks (entryid, userwishid, targetdate, checkedat, checkstatus) FROM stdin;
\.


--
-- Name: userwishdailychecks_entryid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('userwishdailychecks_entryid_seq', 1, false);


--
-- Data for Name: userwishes; Type: TABLE DATA; Schema: public; Owner: Selcuk
--

COPY userwishes (userwishid, userid, wishtext, createdat, updatedat, isactive) FROM stdin;
\.


--
-- Name: userwishes_userwishid_seq; Type: SEQUENCE SET; Schema: public; Owner: Selcuk
--

SELECT pg_catalog.setval('userwishes_userwishid_seq', 1, false);


--
-- Name: beonecalendarevents_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY beonecalendarevents
    ADD CONSTRAINT beonecalendarevents_pkey PRIMARY KEY (eventid);


--
-- Name: beonecalendars_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY beonecalendars
    ADD CONSTRAINT beonecalendars_pkey PRIMARY KEY (calendarid);


--
-- Name: beonecalendarsubcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY beonecalendarsubcategories
    ADD CONSTRAINT beonecalendarsubcategories_pkey PRIMARY KEY (subcategoryid);


--
-- Name: city_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY city
    ADD CONSTRAINT city_pkey PRIMARY KEY (cityid);


--
-- Name: country_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (countryid);


--
-- Name: dailies_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY dailies
    ADD CONSTRAINT dailies_pkey PRIMARY KEY (dailyid);


--
-- Name: dailycategories_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY dailycategories
    ADD CONSTRAINT dailycategories_pkey PRIMARY KEY (categoryid);


--
-- Name: likeduserexperiences_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY likeduserexperiences
    ADD CONSTRAINT likeduserexperiences_pkey PRIMARY KEY (entryid);


--
-- Name: newsfeed_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY newsfeed
    ADD CONSTRAINT newsfeed_pkey PRIMARY KEY (feedid);


--
-- Name: profileentry_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY profileentry
    ADD CONSTRAINT profileentry_pkey PRIMARY KEY (entryid);


--
-- Name: registeredcalendars_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY usercalendars
    ADD CONSTRAINT registeredcalendars_pkey PRIMARY KEY (userid, calendarid);


--
-- Name: userconnection_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY userconnection
    ADD CONSTRAINT userconnection_pkey PRIMARY KEY (userid, providerid, provideruserid);


--
-- Name: userexperiencecomments_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY userexperiencecomments
    ADD CONSTRAINT userexperiencecomments_pkey PRIMARY KEY (commentid);


--
-- Name: userexperiences_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY userexperiences
    ADD CONSTRAINT userexperiences_pkey PRIMARY KEY (userexperienceid);


--
-- Name: userfriends_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY userfriends
    ADD CONSTRAINT userfriends_pkey PRIMARY KEY (userid, frienduserid);


--
-- Name: userlikednews_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY userlikednews
    ADD CONSTRAINT userlikednews_pkey PRIMARY KEY (entryid);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: usertokens_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY usertokens
    ADD CONSTRAINT usertokens_pkey PRIMARY KEY (entryid);


--
-- Name: userwishdailychecks_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY userwishdailychecks
    ADD CONSTRAINT userwishdailychecks_pkey PRIMARY KEY (entryid);


--
-- Name: userwishes_pkey; Type: CONSTRAINT; Schema: public; Owner: Selcuk; Tablespace: 
--

ALTER TABLE ONLY userwishes
    ADD CONSTRAINT userwishes_pkey PRIMARY KEY (userwishid);


--
-- Name: userconnectionrank; Type: INDEX; Schema: public; Owner: Selcuk; Tablespace: 
--

CREATE UNIQUE INDEX userconnectionrank ON userconnection USING btree (userid, providerid, rank);


--
-- Name: public; Type: ACL; Schema: -; Owner: Selcuk
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM "Selcuk";
GRANT ALL ON SCHEMA public TO "Selcuk";
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: beonecalendarevents; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE beonecalendarevents FROM PUBLIC;
REVOKE ALL ON TABLE beonecalendarevents FROM "Selcuk";
GRANT ALL ON TABLE beonecalendarevents TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE beonecalendarevents TO beoneuser;


--
-- Name: beonecalendarevents_eventid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE beonecalendarevents_eventid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE beonecalendarevents_eventid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE beonecalendarevents_eventid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE beonecalendarevents_eventid_seq TO beoneuser;


--
-- Name: beonecalendars; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE beonecalendars FROM PUBLIC;
REVOKE ALL ON TABLE beonecalendars FROM "Selcuk";
GRANT ALL ON TABLE beonecalendars TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE beonecalendars TO beoneuser;


--
-- Name: beonecalendars_calendarid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE beonecalendars_calendarid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE beonecalendars_calendarid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE beonecalendars_calendarid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE beonecalendars_calendarid_seq TO beoneuser;


--
-- Name: beonecalendarsubcategories; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE beonecalendarsubcategories FROM PUBLIC;
REVOKE ALL ON TABLE beonecalendarsubcategories FROM "Selcuk";
GRANT ALL ON TABLE beonecalendarsubcategories TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE beonecalendarsubcategories TO beoneuser;


--
-- Name: beonecalendarsubcategories_subcategoryid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE beonecalendarsubcategories_subcategoryid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE beonecalendarsubcategories_subcategoryid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE beonecalendarsubcategories_subcategoryid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE beonecalendarsubcategories_subcategoryid_seq TO beoneuser;


--
-- Name: city; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE city FROM PUBLIC;
REVOKE ALL ON TABLE city FROM "Selcuk";
GRANT ALL ON TABLE city TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE city TO beoneuser;


--
-- Name: city_cityid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE city_cityid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE city_cityid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE city_cityid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE city_cityid_seq TO beoneuser;


--
-- Name: country; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE country FROM PUBLIC;
REVOKE ALL ON TABLE country FROM "Selcuk";
GRANT ALL ON TABLE country TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE country TO beoneuser;


--
-- Name: country_countryid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE country_countryid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE country_countryid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE country_countryid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE country_countryid_seq TO beoneuser;


--
-- Name: dailies; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE dailies FROM PUBLIC;
REVOKE ALL ON TABLE dailies FROM "Selcuk";
GRANT ALL ON TABLE dailies TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dailies TO beoneuser;


--
-- Name: dailies_dailyid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE dailies_dailyid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE dailies_dailyid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE dailies_dailyid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE dailies_dailyid_seq TO beoneuser;


--
-- Name: dailycategories; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE dailycategories FROM PUBLIC;
REVOKE ALL ON TABLE dailycategories FROM "Selcuk";
GRANT ALL ON TABLE dailycategories TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dailycategories TO beoneuser;


--
-- Name: dailycategories_categoryid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE dailycategories_categoryid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE dailycategories_categoryid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE dailycategories_categoryid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE dailycategories_categoryid_seq TO beoneuser;


--
-- Name: likeduserexperiences; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE likeduserexperiences FROM PUBLIC;
REVOKE ALL ON TABLE likeduserexperiences FROM "Selcuk";
GRANT ALL ON TABLE likeduserexperiences TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE likeduserexperiences TO beoneuser;


--
-- Name: likeduserexperiences_entryid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE likeduserexperiences_entryid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE likeduserexperiences_entryid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE likeduserexperiences_entryid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE likeduserexperiences_entryid_seq TO beoneuser;


--
-- Name: newsfeed; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE newsfeed FROM PUBLIC;
REVOKE ALL ON TABLE newsfeed FROM "Selcuk";
GRANT ALL ON TABLE newsfeed TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE newsfeed TO beoneuser;


--
-- Name: newsfeed_feedid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE newsfeed_feedid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE newsfeed_feedid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE newsfeed_feedid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE newsfeed_feedid_seq TO beoneuser;


--
-- Name: profileentry; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE profileentry FROM PUBLIC;
REVOKE ALL ON TABLE profileentry FROM "Selcuk";
GRANT ALL ON TABLE profileentry TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE profileentry TO beoneuser;


--
-- Name: profileentry_entryid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE profileentry_entryid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE profileentry_entryid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE profileentry_entryid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE profileentry_entryid_seq TO beoneuser;


--
-- Name: usercalendars; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE usercalendars FROM PUBLIC;
REVOKE ALL ON TABLE usercalendars FROM "Selcuk";
GRANT ALL ON TABLE usercalendars TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE usercalendars TO beoneuser;


--
-- Name: userconnection; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE userconnection FROM PUBLIC;
REVOKE ALL ON TABLE userconnection FROM "Selcuk";
GRANT ALL ON TABLE userconnection TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE userconnection TO beoneuser;


--
-- Name: userexperiencecomments; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE userexperiencecomments FROM PUBLIC;
REVOKE ALL ON TABLE userexperiencecomments FROM "Selcuk";
GRANT ALL ON TABLE userexperiencecomments TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE userexperiencecomments TO beoneuser;


--
-- Name: userexperiencecomments_commentid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE userexperiencecomments_commentid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE userexperiencecomments_commentid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE userexperiencecomments_commentid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE userexperiencecomments_commentid_seq TO beoneuser;


--
-- Name: userexperiences; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE userexperiences FROM PUBLIC;
REVOKE ALL ON TABLE userexperiences FROM "Selcuk";
GRANT ALL ON TABLE userexperiences TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE userexperiences TO beoneuser;


--
-- Name: userexperiences_userexperienceid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE userexperiences_userexperienceid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE userexperiences_userexperienceid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE userexperiences_userexperienceid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE userexperiences_userexperienceid_seq TO beoneuser;


--
-- Name: userfriends; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE userfriends FROM PUBLIC;
REVOKE ALL ON TABLE userfriends FROM "Selcuk";
GRANT ALL ON TABLE userfriends TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE userfriends TO beoneuser;


--
-- Name: userlikednews; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE userlikednews FROM PUBLIC;
REVOKE ALL ON TABLE userlikednews FROM "Selcuk";
GRANT ALL ON TABLE userlikednews TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE userlikednews TO beoneuser;


--
-- Name: userlikednews_entryid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE userlikednews_entryid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE userlikednews_entryid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE userlikednews_entryid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE userlikednews_entryid_seq TO beoneuser;


--
-- Name: users; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM "Selcuk";
GRANT ALL ON TABLE users TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE users TO beoneuser;


--
-- Name: users_userid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE users_userid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE users_userid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE users_userid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE users_userid_seq TO beoneuser;


--
-- Name: usertokens; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE usertokens FROM PUBLIC;
REVOKE ALL ON TABLE usertokens FROM "Selcuk";
GRANT ALL ON TABLE usertokens TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE usertokens TO beoneuser;


--
-- Name: usertokens_entryid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE usertokens_entryid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE usertokens_entryid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE usertokens_entryid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE usertokens_entryid_seq TO beoneuser;


--
-- Name: userwishdailychecks; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE userwishdailychecks FROM PUBLIC;
REVOKE ALL ON TABLE userwishdailychecks FROM "Selcuk";
GRANT ALL ON TABLE userwishdailychecks TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE userwishdailychecks TO beoneuser;


--
-- Name: userwishdailychecks_entryid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE userwishdailychecks_entryid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE userwishdailychecks_entryid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE userwishdailychecks_entryid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE userwishdailychecks_entryid_seq TO beoneuser;


--
-- Name: userwishes; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON TABLE userwishes FROM PUBLIC;
REVOKE ALL ON TABLE userwishes FROM "Selcuk";
GRANT ALL ON TABLE userwishes TO "Selcuk";
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE userwishes TO beoneuser;


--
-- Name: userwishes_userwishid_seq; Type: ACL; Schema: public; Owner: Selcuk
--

REVOKE ALL ON SEQUENCE userwishes_userwishid_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE userwishes_userwishid_seq FROM "Selcuk";
GRANT ALL ON SEQUENCE userwishes_userwishid_seq TO "Selcuk";
GRANT USAGE ON SEQUENCE userwishes_userwishid_seq TO beoneuser;


--
-- PostgreSQL database dump complete
--

