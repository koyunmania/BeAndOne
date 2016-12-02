

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


INSERT INTO users (username, email, password, firstname, lastname, birthday, gender, currentcityid, language, provider, createdat, updatedat) VALUES 
	('engingokten', 'engin@beone.com', '1234', 'Engin', 'G&ouml;kten', '1981-01-01', 'Male', (SELECT cityid FROM city WHERE cityname='Istanbul'), 0, 'beone', now(), now());
INSERT INTO users (username, email, password, firstname, lastname, birthday, gender, currentcityid, language, provider, createdat, updatedat) VALUES 
	('selcukbeyhan', 'selcuk@beone.com', '1234', 'Selcuk', 'Beyhan', '1981-01-01', 'Male', (SELECT cityid FROM city WHERE cityname='Istanbul'), 0, 'beone', now(), now());
INSERT INTO users (username, email, password, firstname, lastname, birthday, gender, currentcityid, language, provider, createdat, updatedat) VALUES 
	('user1', 'user1@beone.com', '1234', 'User 1', 'Test', '1981-01-01', 'Male', (SELECT cityid FROM city WHERE cityname='Istanbul'), 0, 'beone', now(), now());

INSERT INTO question(questionTypeId, textLanguageId, questionCode, questionTranslatedText, isActive) VALUES
	(1, 1, 1, 'Bugun neler ogrendin?', true);
INSERT INTO question(questionTypeId, textLanguageId, questionCode, questionTranslatedText, isActive) VALUES
	(1, 1, 2, 'Bugun neler diliyorsun?', true);
INSERT INTO question(questionTypeId, textLanguageId, questionCode, questionTranslatedText, isActive) VALUES
	(2, 1, 3, 'Bugun keyfin nasil?', true);

	
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-03', '1a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-04', '2a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-05', '3a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-06', '4a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-07', '5a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-08', '6a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-09', '7a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-10', '8a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-11', '9a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-12', '10a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-13', '11a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-14', '12a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-15', '13a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-16', '14a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-17', '15a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-18', '16a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-19', '17a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-20', '18a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-21', '19a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-22', '20a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-23', '21a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-24', '22a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-25', '23a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-26', '24a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-27', '25a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-28', '26a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-29', '27a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-30', '28a.jpg', true, now(), now());
INSERT INTO CoverPhotos(photodisplayday, photofilename, isactive, createdat ,updatedat) VALUES ('2016-12-31', '29a.jpg', true, now(), now());

