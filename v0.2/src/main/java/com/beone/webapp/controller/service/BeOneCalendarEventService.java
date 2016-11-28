package com.beone.webapp.controller.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.BeOneCalendarEvent;
import com.beone.webapp.model.BeOneCalendarEventTranslation;
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
	public BeOneCalendarEvent insertOrUpdateEvent(BeOneCalendarEvent event, String eventNameTr, String eventNameEn) {
//		BeOneCalendarEvent existingEvent = 
//				calendarEventDao.findBySubcategoryAndEventName(event.getSubCategory(), eventNameTr, eventNameEn);
		
		logger.debug("Event given to insert or update");
		
//		if(existingEvent == null) {
			calendarEventDao.insertNew(event);
//			existingEvent = event;
			logger.debug("Event inserted successfully.");
//		} else {
//			logger.debug("Provided event already exists, not inserting but updating");
//			existingEvent.setEventDate(event.getEventDate());
//			existingEvent.setEventLocation(event.getEventLocation());
//			existingEvent.setEventType(event.getEventType());
//			
//			calendarEventDao.update(existingEvent);
//		}
//		
//		return existingEvent;
			return event;
	}

	@Transactional
	public BeOneCalendarEventTranslation insertOrUpdateEventTranslation(BeOneCalendarEventTranslation eventTrans) {
		BeOneCalendarEventTranslation existingTrans = 
				calendarEventDao.findEventTranslation(eventTrans);
		
		logger.debug("EventTranslation given to insert or update");
		
		if(existingTrans == null) {
			calendarEventDao.insertNewTranslation(eventTrans);
			existingTrans = eventTrans;
			logger.debug("Event inserted successfully.");
		} else {
			logger.debug("Provided event already exists, not inserting but updating");
			existingTrans.setDesignNumber(eventTrans.getDesignNumber());
			existingTrans.setEventDescription(eventTrans.getEventDescription());
			existingTrans.setEventLocation(eventTrans.getEventLocation());
			existingTrans.setEventName(eventTrans.getEventName());
			existingTrans.setPlusCMessageNumber(eventTrans.getPlusCMessageNumber());
			existingTrans.setPlusCToApp(eventTrans.getPlusCToApp());
			existingTrans.setPlusCToPrint(eventTrans.getPlusCToPrint());
			existingTrans.setPlusCToWall(eventTrans.getPlusCToWall());
			existingTrans.setPlusCToWeb(eventTrans.getPlusCToWeb());
			
			calendarEventDao.updateTranslation(existingTrans);
		}
		
		return existingTrans;
	}
	
	
}
