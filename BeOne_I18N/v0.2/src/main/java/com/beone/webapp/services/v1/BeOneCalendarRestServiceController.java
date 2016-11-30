package com.beone.webapp.services.v1;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.beone.webapp.controller.AbstractController;
import com.beone.webapp.controller.service.BeOneCalendarService;
import com.beone.webapp.controller.service.UserCalendarSubCategoryService;
import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarEvent;
import com.beone.webapp.model.UserCalendar;
import com.beone.webapp.model.UserCalendarSubCategory;
import com.beone.webapp.services.v1.model.BeOneCalendarEventTO;
import com.beone.webapp.utils.BeOneCalendarUtil;

@RestController
public class BeOneCalendarRestServiceController extends AbstractController{
	private static final Logger logger = LoggerFactory.getLogger(BeOneCalendarRestServiceController.class);
	
	@Autowired
	private BeOneCalendarService beOneCalendarService;
	
	@Autowired
	private UserCalendarSubCategoryService userCalendarSubCategoryService;
	
	public BeOneCalendarService getBeOneCalendarService() {
		return beOneCalendarService;
	}
	public void setBeOneCalendarService(BeOneCalendarService beOneCalendarService) {
		this.beOneCalendarService = beOneCalendarService;
	}
	public UserCalendarSubCategoryService getUserCalendarSubCategoryService() {
		return userCalendarSubCategoryService;
	}
	public void setUserCalendarSubCategoryService(UserCalendarSubCategoryService userCalendarSubCategoryService) {
		this.userCalendarSubCategoryService = userCalendarSubCategoryService;
	}

	@RequestMapping(
			value = "/api/v1/usercalendars/",
			params = {"calendarId"},
			produces = "application/json",
			method = RequestMethod.DELETE)
	public RestResult deleteUserCalendar(
			@RequestParam(value = "calendarId") int calendarId) {
		RestResult result = new RestResult();
		logger.info("BeOneCalendarRestServiceController: deleteUserCalendar is called");
		
		currentUser = getCurrentAuthUser();
		
		try{
			beOneCalendarService.deleteUserCalendar(currentUser, calendarId);
			result.setStatus(true);
			result.setMessage("BeOneCalendarRestServiceController: UserCalendar deleted successfully...");
			result.setData(null);
		} catch(Exception e) {
			logger.error("BeOneCalendarRestServiceController: deleteUserCalendar error!", e);
			result.setStatus(false);
			result.setMessage("BeOneCalendarRestServiceController: UserCalendar could not be deleted!!!");
			result.setData(null);
		}
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/calendars",
			produces = "application/json",
			method = RequestMethod.GET
			)
	public RestResult getAllCalendars() {
		RestResult result = new RestResult();
		logger.info("BeOneCalendarRestServiceController: getAllCalendars is called");
		
		Set<BeOneCalendar> allCalendars = null;
		
		try {
			allCalendars = beOneCalendarService.getAllCalendars();
			if(allCalendars == null) {
				result.setData(null);
				result.setMessage("BeOneCalendarRestServiceController: Null data returned from beOneCalendarService");
				result.setStatus(false);
			}
			else {
				result.setData(allCalendars);
				result.setMessage("BeOneCalendarRestServiceController: Data returned from beOneCalendarService");
				result.setStatus(true);
			}
		} catch (Exception e) {
			logger.error("BeOneCalendarRestServiceController: getAllCalendars error!", e);
			result.setData(null);
			result.setMessage("BeOneCalendarRestServiceController: allCalendars could not be loaded!");
			result.setStatus(false);
		}
		
		return result;
	}
	
	
	@RequestMapping(
			value = "/api/v1/usercalendars",
			produces = "application/json",
			method = RequestMethod.GET
			)
	public RestResult getAllUserCalendars() {
		RestResult result = new RestResult();
		logger.info("BeOneCalendarRestServiceController: getAllUserCalendars is called");
		
		Set<UserCalendar> allUserCalendars = null;
		
		currentUser = getCurrentAuthUser();
		
		try {
			allUserCalendars = beOneCalendarService.getAllUserCalendars(currentUser);
			if(allUserCalendars == null) {
				logger.info("BeOneCalendarRestServiceController: No registered user calendar found");
				result.setData(null);
				result.setMessage("BeOneCalendarRestServiceController: Null data returned from beOneCalendarService");
				result.setStatus(false);
			}
			else {
				logger.info("BeOneCalendarRestServiceController: User calendars loaded");
				//Set<UserCalendar> allUserCalendars_TO = BeOneCalendarUtil.convertToTOSet(allUserCalendars);
				result.setData(allUserCalendars);
				result.setMessage("BeOneCalendarRestServiceController: Data returned from beOneCalendarService");
				result.setStatus(true);
			}
		} catch (Exception e) {
			logger.error("BeOneCalendarRestServiceController: User calendars could not be loaded", e);
			result.setData(null);
			result.setMessage("BeOneCalendarRestServiceController: allUserCalendars could not be loaded!");
			result.setStatus(false);
		}
		
		return result;
	}
	
	//to-do: RestResult is overwritten in every for loop	
	@RequestMapping(
			value = "/api/v1/usercalendars",
			produces = "application/json",
			method = RequestMethod.POST
			)
	public RestResult addUserCalendar(@RequestBody Set<BeOneCalendar> beOneCalendars) {
		logger.info("BeOneCalendarRestServiceController: addUserCalendar is called");
		RestResult result = new RestResult();
		
		currentUser = getCurrentAuthUser();

		for(BeOneCalendar beOneCalendar: beOneCalendars) {
			
			UserCalendar userCalendar = new UserCalendar();
			userCalendar.setUser(currentUser);
			userCalendar.setCalendar(beOneCalendar);
			
			try {
				beOneCalendarService.addUserCalendar(userCalendar);
				result.setData(BeOneCalendarUtil.convertUserCalendarToTO(userCalendar));
				result.setStatus(true);
				result.setMessage("BeOneCalendarRestServiceController: UserCalender inserted...");
				logger.info("BeOneCalendarRestServiceController: " + beOneCalendar.getCalendarName() + " successfully inserted");
			} catch(Exception e){
				result.setData(null);
				result.setStatus(false);
				result.setMessage("BeOneCalendarRestServiceController: UserCalendar could not be added!!!");
				logger.info("BeOneCalendarRestServiceController: " + beOneCalendar.getCalendarName() + " failed to insert");
			}
		}
		return result;
	}
	
	
	@RequestMapping(
			value = "/api/v1/usercalendarevents/{date}",
			produces = "application/json",
			method = RequestMethod.GET
			)
	public RestResult getAllUserCalendarEvents(@PathVariable(value="date") String date) {
		RestResult result = new RestResult();
		logger.info("BeOneCalendarRestServiceController: getAllUserCalendarEvents is called with: " + date);
		
		Set<BeOneCalendarEvent> allUserCalendarEvents = null;
		
		currentUser = getCurrentAuthUser();
		
		java.util.Date parsedStartDate = null;
		java.util.Date parsedEndDate = null;
		Timestamp convertedStartDate = null;
		Timestamp convertedEndDate = null;
		SimpleDateFormat df = null;
		try {
			df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			parsedStartDate = df.parse(date+" 00:00:00");
			parsedEndDate = df.parse(date+" 23:59:59");
			convertedStartDate = new Timestamp(parsedStartDate.getTime());
			convertedEndDate = new Timestamp(parsedEndDate.getTime());
		} catch (ParseException e1) {
			try {
				logger.error("BeOneCalendarRestServiceController: Given date is not in applicable format", e1);
				df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				parsedStartDate = df.parse(date+" 00:00:00");
				parsedEndDate = df.parse(date+" 23:59:59");
				convertedStartDate = new Timestamp(parsedStartDate.getTime());
				convertedEndDate = new Timestamp(parsedEndDate.getTime());
			} catch (ParseException e2) {
				logger.error("BeOneCalendarRestServiceController: Given date is not in applicable format", e2);
				result.setData(null);
				result.setMessage("BeOneCalendarRestServiceController: Given date is not in applicable format!");
				result.setStatus(false);
				
				return result;
			}
		}
		
		// Get all subCategories of user
		Set<UserCalendarSubCategory> subs = new HashSet<UserCalendarSubCategory>(); 

		try {
			subs = userCalendarSubCategoryService.getAllUserCalendarSubCategories(currentUser);
		} catch (Exception e) {
			logger.error("BeOneCalendarRestServiceController: UserCalendarSubCategories can not be get!");
			result.setData(null);
			result.setMessage("BeOneCalendarRestServiceController: UserCalendarSubCategories can not be get!");
			result.setStatus(false);
			
			return result;
		}
		
		try {
			allUserCalendarEvents = beOneCalendarService.getAllUserCalendarEventsOfDate(currentUser, subs, convertedStartDate, convertedEndDate);
			if(allUserCalendarEvents == null) {
				logger.info("BeOneCalendarRestServiceController: No registered user calendar events found");
				result.setData(null);
				result.setMessage("BeOneCalendarRestServiceController: Null data returned from beOneCalendarService");
				result.setStatus(false);
			}
			else {
				logger.info("BeOneCalendarRestServiceController: User calendar events loaded");
				// the subcategory and calendar of the event is also converted and ready to be returned
				Set<BeOneCalendarEventTO> allUserCalendars_TO = BeOneCalendarUtil.convertEventToTOSet(allUserCalendarEvents);
				
				result.setData(allUserCalendars_TO);
				result.setMessage("BeOneCalendarRestServiceController: Data returned from beOneCalendarService");
				result.setStatus(true);
			}
		} catch (Exception e) {
			logger.error("BeOneCalendarRestServiceController: User calendar events could not be loaded", e);
			result.setData(null);
			result.setMessage("BeOneCalendarRestServiceController: User calendar events could not be loaded!");
			result.setStatus(false);
		}
		
		return result;
	}
}