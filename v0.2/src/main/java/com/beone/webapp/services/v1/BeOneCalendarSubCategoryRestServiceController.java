package com.beone.webapp.services.v1;

import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.beone.webapp.controller.AbstractController;
import com.beone.webapp.controller.service.BeOneCalendarService;
import com.beone.webapp.controller.service.BeOneCalendarSubCategoryService;
import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.BeOneLanguage;
import com.beone.webapp.utils.BeOneCalendarSubCategoryUtil;
import com.beone.webapp.utils.MessageTranslator;

@RestController
public class BeOneCalendarSubCategoryRestServiceController extends AbstractController {
	private static final Logger logger = LoggerFactory.getLogger(BeOneCalendarSubCategoryRestServiceController.class); 
	
	@Autowired
	private BeOneCalendarService beOneCalendarService;
	@Autowired
	private BeOneCalendarSubCategoryService beOneCalendarSubCategoryService;
	
	public BeOneCalendarService getBeOneCalendarService(){
		return beOneCalendarService;
	}
	public void setBeOneCalendarService(BeOneCalendarService beOneCalendarService){
		this.beOneCalendarService = beOneCalendarService;
	}
	public BeOneCalendarSubCategoryService getBeOneCalendarSubCategoryService(){
		return beOneCalendarSubCategoryService;
	}
	public void setBeOneCalendarSubCategoryService(BeOneCalendarSubCategoryService beOneCalendarSubCategoryService){
		this.beOneCalendarSubCategoryService = beOneCalendarSubCategoryService;
	}
	
	@RequestMapping(
			value = "/api/v1/allcalendarsubcategories",
			produces = "application/json",
			method = RequestMethod.GET
			)
	public RestResult getAllSubCategories(Locale locale){
		RestResult result = new RestResult();
		logger.info("BeOneCalendarSubCategoryRestServiceController: getAllSubCategories is called...");
		
		currentUser = getCurrentAuthUser();
		BeOneLanguage language = MessageTranslator.getLanguageOfUserOrCaller(currentUser, locale);
		
		Set<BeOneCalendarSubCategory> subCategories = new HashSet<BeOneCalendarSubCategory>();
		
		try {
			subCategories = beOneCalendarSubCategoryService.getAllSubCategories();
			if(subCategories == null || subCategories.size() == 0){
				result.setData(null);
				result.setMessage("BeOneCalendarSubCategoryRestServiceController: no subcategory could not be found...");
				result.setStatus(false);
			} else {
				result.setData(BeOneCalendarSubCategoryUtil.convertToTOSet(subCategories, language));
				result.setMessage("BeOneCalendarSubCategoryRestServiceController: CalendarSubCategories got successfully...");
				result.setStatus(true);
			}
		} catch (Exception e) {
			logger.error("BeOneCalendarSubCategoryRestServiceController: getAllSubCategories error!", e);
			result.setData(null);
			result.setMessage("BeOneCalendarSubCategoryRestServiceController: CalendarSubcategories could not be returned!!!");
			result.setStatus(false);
		}
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/calendarsubcategories/",
			produces = "application/json",
			params = {"calendarId"},
			method = RequestMethod.GET)
	public RestResult getAllSubCategoriesOfCalendar(
			@RequestParam(value = "calendarId") int calendarId, Locale locale){
		RestResult result = new RestResult();
		logger.info("BeOneCalendarSubCategoryRestServiceController: getAllSubCategoriesOfCalendar is called");
		
		currentUser = getCurrentAuthUser();
		BeOneLanguage language = MessageTranslator.getLanguageOfUserOrCaller(currentUser, locale);
		
		BeOneCalendar calendar = new BeOneCalendar();
		
		try {
			calendar = beOneCalendarService.getCalendarById(calendarId);
			if(calendar == null){
				result.setData(null);
				result.setMessage("BeOneCalendarSubCategoryRestServiceController: calendarId could not be found");
				result.setStatus(false);				
			} else {
				Set<BeOneCalendarSubCategory> calendarSubCategorySet = beOneCalendarSubCategoryService.getAllSubCategoriesOfCalendar(calendar);
				if(calendarSubCategorySet == null || calendarSubCategorySet.size() == 0){
					result.setData(null);
					result.setMessage("BeOneCalendarSubCategoryRestServiceController: no subcategory could not be found for calendarId:" + calendarId);
					result.setStatus(false);				
				} else {
					result.setData(BeOneCalendarSubCategoryUtil.convertToTOSet(calendarSubCategorySet, language));
					result.setMessage("BeOneCalendarSubCategoryRestServiceController: CalendarSubCategories got successfully...");
					result.setStatus(true);				
				}
			}
		} catch(Exception e) {
			logger.error("BeOneCalendarSubCategoryRestServiceController: getAllSubCategoriesOfCalendar error!", e);
			result.setStatus(false);
			result.setMessage("BeOneCalendarSubCategoryRestServiceController: CalendarSubcategories could not be returned!!!");
			result.setData(null);
		}
		return result;
	}
}