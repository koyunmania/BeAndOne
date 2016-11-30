package com.beone.webapp.controller.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.BeOneCalendarEvent;
import com.beone.webapp.persistence.CalendarEventDao;

public class BeOneCalendarEventService {
	
	private static final Logger logger = LoggerFactory.getLogger(BeOneCalendarEventService.class);
	
	@Autowired
	private CalendarEventDao calendarEventDao;

	public CalendarEventDao getCalendarEventDao() {
		return calendarEventDao;
	}

	public void setCalendarEventDao(CalendarEventDao calendarEventDao) {
		this.calendarEventDao = calendarEventDao;
	}

	@Transactional
	public BeOneCalendarEvent insertOrUpdateEvent(BeOneCalendarEvent event) {
		BeOneCalendarEvent existingEvent = 
				calendarEventDao.findBySubcategoryAndEventName(event.getSubCategory(), event.getEventName());
		
		logger.debug("Event given to insert or update");
		
		if(existingEvent == null) {
			calendarEventDao.insertNew(event);
			existingEvent = event;
			logger.debug("Event inserted successfully.");
		} else {
			logger.debug("Provided event already exists, not inserting or updating");
			existingEvent.setEventDate(event.getEventDate());
			existingEvent.setEventDescription(event.getEventDescription());
			existingEvent.setEventLocation(event.getEventLocation());
			existingEvent.setEventType(event.getEventType());
			
			calendarEventDao.update(existingEvent);
		}
		
		return existingEvent;
	}
	
	
}
