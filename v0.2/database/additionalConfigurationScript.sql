
-- The content of this file is to be executed after the data is imported.

UPDATE beonecalendars SET colorcode='color:#71719e;', buttonClass='btn-astro', calendaricon='glyphicon glyphicon-adjust', sortOrder=1  WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Astro Olaylar');
UPDATE beonecalendars SET colorcode='color:#5fc49f;', buttonClass='btn-nature', calendaricon='glyphicon glyphicon-tree-deciduous', sortOrder=2 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Doğa Olayları');
UPDATE beonecalendars SET colorcode='color:#efa759;', buttonClass='btn-holy', calendaricon='glyphicon glyphicon-heart', sortOrder=3 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Kutsal Günler');
UPDATE beonecalendars SET colorcode='color:#5fc2c4;', buttonClass='btn-international', calendaricon='glyphicon glyphicon-globe', sortOrder=4 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Uluslararası Günler');
UPDATE beonecalendars SET colorcode='color:#df6c4f;', buttonClass='btn-national', calendaricon='beone-icon-calendar', sortOrder=5 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Ulusal Günler');
UPDATE beonecalendars SET colorcode='color:#f7d752;', buttonClass='btn-independence', calendaricon='glyphicon glyphicon-flag', sortOrder=6 WHERE calendarid=(SELECT calendarid from beonecalendartranslations where transname='Bağımsızlık Günleri');


-- Dummy data for the sub category setting
insert into UserCalendarSubCategories (select u.userid, s.subcategoryid from users u cross join beonecalendarsubcategories s);
