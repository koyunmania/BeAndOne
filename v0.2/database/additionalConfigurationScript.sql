-- The content of this file is to be executed after the data is imported.

UPDATE beonecalendars SET colorcode='color:#71719e;', buttonClass='btn-astro', sortOrder=1  WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Astro Olaylar');
UPDATE beonecalendars SET colorcode='color:#5fc49f;', buttonClass='btn-nature', sortOrder=2 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Doğa Olayları');
UPDATE beonecalendars SET colorcode='color:#efa759;', buttonClass='btn-holy', sortOrder=3 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Kutsal Günler');
UPDATE beonecalendars SET colorcode='color:#5fc2c4;', buttonClass='btn-international', sortOrder=4 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Uluslararası Günler');
UPDATE beonecalendars SET colorcode='color:#df6c4f;', buttonClass='btn-national', sortOrder=5 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Ulusal Günler');
UPDATE beonecalendars SET colorcode='color:#f7d752;', buttonClass='btn-independence', sortOrder=6 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Bağımsızlık Günleri');


UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Eclipses');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Equinoxes and Solstices');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Meteor Showers');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Moon Phases');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Rise & Set');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Planetary Retrogrades');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Stars Whisper');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Plants');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Animals');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Weather & Other');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Bahá''í Faith');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Buddhism');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Christianity (All Denominations)');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Hinduism');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Islam');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Jainism');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Judaism');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Paganism');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Shinto');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Sikhism');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Zoroastrianism');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='United Nations International Days');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Other');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE subcategoryid=(SELECT subcategoryid from beonecalendarsubcategorytranslations where calendarsubcategorytrans='Turkey');
UPDATE beonecalendarsubcategories SET calendaricon='glyphicon glyphicon-adjust' WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Independence Days');


-- Dummy data for the sub category setting
insert into UserCalendarSubCategories (select u.userid, s.subcategoryid from users u cross join beonecalendarsubcategories s);
