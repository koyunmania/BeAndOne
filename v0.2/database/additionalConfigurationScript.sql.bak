


insert into beonecalendars values (1, 'Astro Olaylar', '', 'color:#71719e;', 'glyphicon glyphicon-adjust','btn-astro',1);
insert into beonecalendars values (2, 'Doğa Olayları', '', 'color:#71719e;', 'glyphicon glyphicon-adjust','btn-astro',1);
insert into beonecalendars values (3, 'Kutsal Günler', '', 'color:#71719e;', 'glyphicon glyphicon-adjust','btn-astro',1);
insert into beonecalendars values (4, 'Uluslararası Günler', '', 'color:#71719e;', 'glyphicon glyphicon-adjust','btn-astro',1);
insert into beonecalendars values (5, 'Ulusal Günler', '', 'color:#71719e;', 'glyphicon glyphicon-adjust','btn-astro',1);
insert into beonecalendars values (6, 'Bağımsızlık Günleri', '', 'color:#71719e;', 'glyphicon glyphicon-adjust','btn-astro',1);


-- The content of this file is to be executed after the data is imported.

UPDATE beonecalendars SET colorcode='color:#71719e;', buttonClass='btn-astro', calendaricon='glyphicon glyphicon-adjust', sortOrder=1  WHERE calendarname='Astro Olaylar';
UPDATE beonecalendars SET colorcode='color:#5fc49f;', buttonClass='btn-nature', calendaricon='glyphicon glyphicon-tree-deciduous', sortOrder=2 WHERE calendarname='Doğa Olayları';
UPDATE beonecalendars SET colorcode='color:#efa759;', buttonClass='btn-holy', calendaricon='glyphicon glyphicon-heart', sortOrder=3 WHERE calendarname='Kutsal Günler';
UPDATE beonecalendars SET colorcode='color:#5fc2c4;', buttonClass='btn-international', calendaricon='glyphicon glyphicon-globe', sortOrder=4 WHERE calendarname='Uluslararası Günler';
UPDATE beonecalendars SET colorcode='color:#df6c4f;', buttonClass='btn-national', calendaricon='beone-icon-calendar', sortOrder=5 WHERE calendarname='Ulusal Günler';
UPDATE beonecalendars SET colorcode='color:#f7d752;', buttonClass='btn-independence', calendaricon='glyphicon glyphicon-flag', sortOrder=6 WHERE calendarname='Bağımsızlık Günleri';


-- Dummy data for the sub category setting
insert into UserCalendarSubCategories (select u.userid, s.subcategoryid from users u cross join beonecalendarsubcategories s);
