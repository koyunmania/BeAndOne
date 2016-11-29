package com.beone.webapp.controller.service;

import java.sql.Timestamp;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarEvent;
import com.beone.webapp.model.BeOneCalendarTranslation;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserCalendar;
import com.beone.webapp.model.UserCalendarSubCategory;
import com.beone.webapp.persistence.CalendarDao;
import com.beone.webapp.persistence.CalendarEventDao;


public class BeOneCalendarService {
	private static final Logger logger = LoggerFactory.getLogger(BeOneCalendarService.class);

	@Autowired
	private CalendarDao calendarDao;
	
	@Autowired
	private CalendarEventDao calendarEventDao;
	
	public CalendarDao getCalendarDao() {
		return calendarDao;
	}
	public void setCalendarDao(CalendarDao calendarDao) {
		this.calendarDao = calendarDao;
	}
	public CalendarEventDao getCalendarEventDao() {
		return calendarEventDao;
	}
	public void setCalendarEventDao(CalendarEventDao calendarEventDao) {
		this.calendarEventDao = calendarEventDao;
	}
	
	@Transactional
	public UserCalendar getUserCalendarById(int userId, int calendarId){
		UserCalendar userCalendar = calendarDao.getUserCalendarById(userId, calendarId);
		return userCalendar;
	}
	@Transactional
	public BeOneCalendar addCalendarIfNotExistsOrReturn(BeOneCalendar cal, String calendarName) {
		BeOneCalendar existingCalendar = calendarDao.findByName(calendarName);
		if(existingCalendar == null) {
			logger.debug("The calendar does not exist, creating it.");
			calendarDao.insertNew(cal);
			return cal;
		} else {
			logger.debug("Calendar already exists.");
			return existingCalendar;
		}
	}
	
	@Transactional
	public void addUserCalendar(UserCalendar userCalendar) {
		calendarDao.addUserCalendar(userCalendar);
	}
	
	@Transactional
	public void deleteUserCalendar(User user, int calendarId){
		calendarDao.deleteUserCalendar(user, calendarId);
	}
	
	@Transactional
	public BeOneCalendar getCalendarByName(String calendarName, int languageId) {
		BeOneCalendar existingCalendars = calendarDao.findByName(calendarName);
		return existingCalendars;
	}
	
	@Transactional
	public BeOneCalendar getCalendarById(int calendarId) {
		BeOneCalendar existingCalendars = calendarDao.getCalendarById(calendarId);
		return existingCalendars;
	}

	//	@Transactional
//	public BeOneCalendar getCalendarByNameAndCategory(String calendarName, String category) {
//		BeOneCalendar existingCalendar = calendarDao.findByNameAndCategory(calendarName, category);
//		return existingCalendar;
//	}
//	
	@Transactional
	public Set<BeOneCalendar> getAllCalendars() {
		Set<BeOneCalendar> allCalendars = calendarDao.getAll();
		return allCalendars;
	}

	@Transactional
	public Set<UserCalendar> getAllUserCalendars(User user) {
		Set<UserCalendar> allCalendars = calendarDao.getAllUserCalendars(user);
		return allCalendars;
	}

	@Transactional
	public Set<BeOneCalendarEvent> getAllUserCalendarEvents(User currentUser) {
		Set<BeOneCalendarEvent> allCalendarEvents = calendarEventDao.findEventsByUserId(currentUser.getUserId());
		
		return allCalendarEvents;
	}
	
	@Transactional
	public Set<BeOneCalendarEvent> getAllUserCalendarEventsOfDate(User currentUser, Set<UserCalendarSubCategory> subs, Timestamp startDate, Timestamp endDate) {
		String userCity = currentUser.getCurrentCity().getCityName();
		Set<BeOneCalendarEvent> allCalendarEvents = calendarEventDao.findEventsByUserIdAndDate(subs, userCity, currentUser.getUserId(), startDate, endDate);
		
		return allCalendarEvents;
	}
	
	@Transactional
	public void addTranslationIfNotExists(BeOneCalendarTranslation trans) {
		BeOneCalendarTranslation existingTrans = calendarDao.getCalendarTranslation(trans);
		if(existingTrans != null) {
			//return existingTrans;
		} else {
			calendarDao.insertNewTranslation(trans);
		}
	}
	
}
