-- Table: users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	userid serial NOT NULL,
	username character varying(100),
	email character varying(200),
	password character varying(200),
	firstname character varying(100),
	lastname character varying(100),
	birthday character varying(10),
	gender character varying(20),
	currentCityId integer,
	currentCountryId integer,
	language integer,
	locale character varying(20),
	status character varying(20),
	provider character varying(20),
	createdAt timestamp,
	updatedAt timestamp,
  CONSTRAINT users_pkey PRIMARY KEY (userid)
)
WITH (
  OIDS=FALSE
);

DROP TABLE IF EXISTS registertoken;
CREATE TABLE registertoken(
	entryId SERIAL NOT NULL,
	userId integer NOT NULL,
	token character varying(100),
	CONSTRAINT registertoken_pkey PRIMARY KEY(entryId)
);

-- Table: userconnection
DROP TABLE IF EXISTS userconnection;
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
	createdAt timestamp,
	updatedAt timestamp,
	CONSTRAINT userconnection_pkey PRIMARY KEY (userid, providerid, provideruserid)
)
WITH (
	OIDS=FALSE
);

-- Index: userconnectionrank

DROP INDEX IF EXISTS userconnectionrank;
CREATE UNIQUE INDEX userconnectionrank
	ON userconnection
	USING btree
	(userid, providerid COLLATE pg_catalog."default", rank);


DROP TABLE IF EXISTS userfriends;
CREATE TABLE userfriends (
	userId integer,
	friendUserId integer,
	friendshipStatus character varying(20),
	createdAt timestamp,
	updatedAt timestamp,
	CONSTRAINT userfriends_pkey PRIMARY KEY (userId, friendUserId)
);

DROP TABLE IF EXISTS usertokens;
CREATE TABLE usertokens (
	entryId SERIAL NOT NULL,
	userId integer,
	token character varying(2000),
	createdAt timestamp,
	updatedAt timestamp,
	CONSTRAINT usertokens_pkey PRIMARY KEY (entryId)
);

DROP TABLE IF EXISTS profileentry;
CREATE TABLE profileentry (
	entryId SERIAL NOT NULL,
	userId integer,
	fieldName character varying(20),
	fieldValue character varying(20),
	createdAt timestamp,
	updatedAt timestamp,
	CONSTRAINT profileentry_pkey PRIMARY KEY (entryId)
);

DROP TABLE IF EXISTS country;
CREATE TABLE country (
	countryId SERIAL NOT NULL,
	countryName character varying(50),
	CONSTRAINT country_pkey PRIMARY KEY (countryId)
);

DROP TABLE IF EXISTS city;
CREATE TABLE city (
	cityId SERIAL NOT NULL,
	countryId integer,
	cityName character varying(50),
	CONSTRAINT city_pkey PRIMARY KEY (cityId)
);



DROP TABLE IF EXISTS newsfeed;
CREATE TABLE newsfeed(
	feedId SERIAL NOT NULL,
	feedTitle character varying(200),
	feedContent character varying(1000),
	feedAuthor integer,
	feedPublishDate timestamp,
	createdAt timestamp,
	updatedAt timestamp,
	CONSTRAINT newsfeed_pkey PRIMARY KEY (feedId)
);

DROP TABLE IF EXISTS userlikednews;
CREATE TABLE userlikednews(
	entryId SERIAL NOT NULL,
	userId integer,
	newsid integer,
	createdAt timestamp,
	updatedAt timestamp,
	CONSTRAINT userlikednews_pkey PRIMARY KEY (entryId)
);


DROP TABLE IF EXISTS beonecalendars;
CREATE TABLE beonecalendars (
	calendarId SERIAL NOT NULL,
	colorcode character varying(500),
	buttonClass character varying(50),
	sortOrder integer not null,
	CONSTRAINT beonecalendars_pkey PRIMARY KEY (calendarId)
);

DROP TABLE IF EXISTS beonecalendartranslations;
CREATE TABLE beonecalendartranslations (
	translationid SERIAL NOT NULL,
	transname character varying(200),
	transdescription character varying(500),
	languageid integer not null,
	calendarid integer not null,
	CONSTRAINT beonecalendartranslations_pkey PRIMARY KEY (translationid)
);

DROP TABLE IF EXISTS beonecalendarsubcategories;
CREATE TABLE beonecalendarsubcategories
(
	subcategoryId serial NOT NULL,
	calendarid integer,
	description character varying(500),
	calendaricon character varying(500),
	CONSTRAINT beonecalendarsubcategories_pkey PRIMARY KEY (subcategoryId)
);

DROP TABLE IF EXISTS beonecalendarsubcategorytranslations;
CREATE TABLE beonecalendarsubcategorytranslations
(
	translationid serial NOT NULL,
	subcategoryid integer,
	calendarsubcategorytrans character varying(200),
	descriptiontrans character varying(500),
	languageid integer not null,
	CONSTRAINT beonecalendarsubcategorytranslations_pkey PRIMARY KEY (translationid)
);

DROP TABLE IF EXISTS beonecalendarevents;
CREATE TABLE beonecalendarevents (
	eventId SERIAL NOT NULL,
	subcategoryId integer NOT NULL,
--	eventName character varying(200) NOT NULL,
	eventDate timestamp NOT NULL,
--	eventDescription text NOT NULL,
--	eventLocation character varying(500) NOT NULL,
	eventType character varying(500) NOT NULL,
--	eventHappeningPhotoFilename character varying(50) NOT NULL,
	CONSTRAINT beonecalendarevents_pkey PRIMARY KEY (eventId)
);

DROP TABLE IF EXISTS beonecalendareventtranslations;
CREATE TABLE beonecalendareventtranslations (
	translationid SERIAL NOT NULL,
	eventId integer NOT NULL,
	languageid integer not null,
	eventName character varying(200) NOT NULL,
	eventDescription text NOT NULL,
	eventLocation character varying(200) NOT NULL,
	designNumber character varying(10) NOT NULL,
	plusCMessageNumber character varying(10) NOT NULL,
	plusCToWeb character varying(10) NOT NULL,
	plusCToWall character varying(10) NOT NULL,
	plusCToPrint character varying(10) NOT NULL,
	plusCToApp character varying(10) NOT NULL,
	CONSTRAINT beonecalendareventtranslations_pkey PRIMARY KEY (translationid)
);

DROP TABLE IF EXISTS usercalendarsubcategories;
CREATE TABLE usercalendarsubcategories (
  userid integer NOT NULL,
  beonecalendarsubcategoryid integer NOT NULL,
  createdat timestamp without time zone,
  updatedat timestamp without time zone,
  CONSTRAINT usercalendarsubcategories_pkey PRIMARY KEY (userid, beonecalendarsubcategoryid)
);

DROP TABLE IF EXISTS usercalendars;
CREATE TABLE usercalendars (
  userid integer NOT NULL,
  calendarid integer NOT NULL,
  createdat timestamp without time zone,
  updatedat timestamp without time zone,
  CONSTRAINT registeredcalendars_pkey PRIMARY KEY (userid, calendarid)
);

DROP TABLE IF EXISTS userexperiences;
CREATE TABLE userexperiences(
	userExperienceId SERIAL NOT NULL,
	userId integer NOT NULL,
	experienceDescription character varying(500) NOT NULL,
	createdAt timestamp,
	updatedAt timestamp,
	experienceDate character varying(10) NOT NULL,
	CONSTRAINT userexperiences_pkey PRIMARY KEY (userExperienceId)
);

DROP TABLE IF EXISTS userexperiencecomments;
CREATE TABLE userexperiencecomments(
	commentId SERIAL NOT NULL,
	userId integer NOT NULL,
	userExperienceId integer NOT NULL,
	commentedCommentId integer NOT NULL, -- if someone has commented a comment
	commentDescription character varying(500) NOT NULL,
	CONSTRAINT userexperiencecomments_pkey PRIMARY KEY (commentId)
);

DROP TABLE IF EXISTS likeduserexperiences;
CREATE TABLE likeduserexperiences(
	entryId SERIAL NOT NULL,
	userExperienceId integer NOT NULL,
	userId integer NOT NULL,
	CONSTRAINT likeduserexperiences_pkey PRIMARY KEY (entryId)
);

DROP TABLE IF EXISTS dailycategories;
CREATE TABLE dailycategories(
	categoryId SERIAL NOT NULL,
	categoryName character varying(50) NOT NULL,
	CONSTRAINT dailycategories_pkey PRIMARY KEY (categoryId)
);


DROP TABLE IF EXISTS dailies;
CREATE TABLE dailies(
	dailyId SERIAL NOT NULL,
	dailyTitle character varying(200) NOT NULL,
	dailyCategoryId integer NOT NULL,
	dailyDescription character varying(500) NOT NULL,
	CONSTRAINT dailies_pkey PRIMARY KEY (dailyId)
);

DROP TABLE IF EXISTS userwishes;
CREATE TABLE userwishes(
	userWishId SERIAL NOT NULL,
	userId integer NOT NULL,
	wishText character varying(500) NOT NULL,
	createdAt timestamp,
	updatedAt timestamp,
	isActive boolean NOT NULL,
	CONSTRAINT userwishes_pkey PRIMARY KEY (userWishId)
);

DROP TABLE IF EXISTS userwishdailychecks;
CREATE TABLE userwishdailychecks(
	entryId SERIAL NOT NULL,
	userWishId integer NOT NULL,
	targetDate timestamp,
	checkedAt timestamp,
	checkStatus integer NOT NULL,
	CONSTRAINT userwishdailychecks_pkey PRIMARY KEY (entryId)
);

DROP TABLE IF EXISTS question;
CREATE TABLE question(
	questionId SERIAL NOT NULL,
	questionTypeId integer NOT NULL,
	textLanguageId integer NOT NULL,
	questionCode integer NOT NULL,
	questionTranslatedText character varying(500) NOT NULL,
	isActive boolean NOT NULL,
	CONSTRAINT question_pkey PRIMARY KEY(questionId)
);

DROP TABLE IF EXISTS useranswer;
CREATE TABLE useranswer (
	userAnswerId SERIAL NOT NULL,
	userId integer NOT NULL,
	questionId integer NOT NULL,
	userAnswerText character varying(1000),
	selectedAnswerId integer,
	userAnswerGivenDate timestamp,
	CONSTRAINT useranswer_pkey PRIMARY KEY(userAnswerId)
);

DROP TABLE IF EXISTS possibleanswer;
CREATE TABLE possibleanswer(
	possibleAnswerId SERIAL NOT NULL,
	textLanguageId integer NOT NULL,
	questionId integer NOT NULL,
	translatedText character varying(500),
	CONSTRAINT possibleanswer_pkey PRIMARY KEY(possibleAnswerId)
);

DROP TABLE IF EXISTS useralbum;
CREATE TABLE useralbum(
	albumId SERIAL NOT NULL,
	userId integer NOT NULL,
	albumName character varying(100),
	albumFoldername character varying(150),
	CONSTRAINT useralbums_pkey PRIMARY KEY(albumId)
);

DROP TABLE IF EXISTS useralbumphoto;
CREATE TABLE useralbumphoto(
	albumPhotoId SERIAL NOT NULL,
	albumId integer NOT NULL,
	randomFilename character varying(100),
	originalFilename character varying(500),
	isActive boolean NOT NULL,
	CONSTRAINT useralbumphotos_pkey PRIMARY KEY(albumPhotoId)
);


GRANT ALL PRIVILEGES ON DATABASE beone TO beoneuser;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO beoneuser;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO beoneuser;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO beoneuser;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO beoneuser;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO beoneuser;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO beoneuser;