

INSERT INTO country (countryname) VALUES ('Turkey');
INSERT INTO country (countryname) VALUES ('Germany');
INSERT INTO country (countryname) VALUES ('United Kingdom');


INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Turkey'), 'Istanbul');
INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Turkey'), 'Bursa');
INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Turkey'), 'Adana');
INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Turkey'), 'Izmir');
INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Turkey'), 'Ankara');
INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Germany'), 'Munich');
INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Germany'), 'Augsburg');
INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Germany'), 'Freising');
INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Germany'), 'Nuernberg');
INSERT INTO city (countryid, cityname) VALUES ((SELECT countryid FROM country WHERE countryname='Germany'), 'Ulm');


INSERT INTO users (username, email, password, firstname, lastname, birthday, gender, currentcityid, provider, createdat, updatedat) VALUES ('engingokten', 'engin@beone.com', '1234', 'Engin', 'G&ouml;kten', '1981-01-01', 'Male', (SELECT cityid FROM city WHERE cityname='Istanbul'), 'beone', now(), now());
INSERT INTO users (username, email, password, firstname, lastname, birthday, gender, currentcityid, provider, createdat, updatedat) VALUES ('selcukbeyhan', 'selcuk@beone.com', '1234', 'Selcuk', 'Beyhan', '1981-01-01', 'Male', (SELECT cityid FROM city WHERE cityname='Istanbul'), 'beone', now(), now());
INSERT INTO users (username, email, password, firstname, lastname, birthday, gender, currentcityid, provider, createdat, updatedat) VALUES ('user1', 'user1@beone.com', '1234', 'User 1', 'Test', '1981-01-01', 'Male', (SELECT cityid FROM city WHERE cityname='Istanbul'), 'beone', now(), now());

INSERT INTO question(questionTypeId, textLanguageId, questionCode, questionTranslatedText, isActive) VALUES (1, 1, 1, 'Bugun neler ogrendin?', true);
INSERT INTO question(questionTypeId, textLanguageId, questionCode, questionTranslatedText, isActive) VALUES (1, 1, 2, 'Bugun neler diliyorsun?', true);
INSERT INTO question(questionTypeId, textLanguageId, questionCode, questionTranslatedText, isActive) VALUES(2, 1, 3, 'Bugun keyfin nasil?', true);

