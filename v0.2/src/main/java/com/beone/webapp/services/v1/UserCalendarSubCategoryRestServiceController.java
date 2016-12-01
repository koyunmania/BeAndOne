package com.beone.webapp.services.v1;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.beone.webapp.controller.AbstractController;
import com.beone.webapp.controller.service.UserCalendarSubCategoryService;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.BeOneLanguage;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserCalendarSubCategory;
import com.beone.webapp.services.v1.model.BeOneCalendarSubCategoryTO;
import com.beone.webapp.services.v1.model.UserCalendarSubCategoryTO;
import com.beone.webapp.utils.BeOneCalendarSubCategoryUtil;
import com.beone.webapp.utils.MessageTranslator;
import com.beone.webapp.utils.UserCalendarSubCategoryUtil;

@RestController
public class UserCalendarSubCategoryRestServiceController extends AbstractController {
	private static final Logger logger = LoggerFactory.getLogger(UserCalendarSubCategoryRestServiceController.class);
	
	@Autowired
	private UserCalendarSubCategoryService userCalendarSubCategoryService;
	
	public UserCalendarSubCategoryService getUserCalendarSubCategoryService(){
		return userCalendarSubCategoryService;
	}
	public void setUserCalendarSubCategoryService(UserCalendarSubCategoryService userCalendarSubCategoryService) {
		this.userCalendarSubCategoryService = userCalendarSubCategoryService;
	}
	
	@RequestMapping(
			value = "/api/v1/usercalendarsubcategories/",
			produces = "application/json",
			method= RequestMethod.GET
			)
	public RestResult getAllUserCalendarSubCategories(Locale locale){
		RestResult result = new RestResult();
		logger.info("UserCalendarSubCategoryRestServiceController: getAllUserCalendarSubCategories method called...");
		
		currentUser = getCurrentAuthUser();
		BeOneLanguage language = MessageTranslator.getLanguageOfUserOrCaller(currentUser, locale);
		
		Set<UserCalendarSubCategoryTO> subs = new HashSet<UserCalendarSubCategoryTO>(); 
		
		try {
			subs = UserCalendarSubCategoryUtil.convertToTOSet(
					userCalendarSubCategoryService.getAllUserCalendarSubCategories(currentUser),
					language);
			if(subs == null || subs.size() == 0) {
				result.setData(null);
				result.setMessage("UserCalendarSubCategoryRestServiceController: getAllUserCalendarSubCategories returned empty...");
				result.setStatus(false);
			}
			else {
				result.setData(subs);
				result.setMessage("UserCalendarSubCategoryRestServiceController: getAllUserCalendarSubCategories returned...");
				result.setStatus(true);
			}
		} catch(Exception e) {
			logger.error("UserCalendarSubCategoryRestServiceController: getAllUserCalendarSubCategories error!", e);
			result.setData(null);
			result.setMessage("UserCalendarSubCategoryRestServiceController: getAllUserCalendarSubCategories error!");
			result.setStatus(false);
		}
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/addusercalendarsubcategories/",
			produces = "application/json",
			method = RequestMethod.POST
			)
	public RestResult addUserCalendarSubCategories(
			@RequestBody Set<BeOneCalendarSubCategoryTO> beOneCalendarSubs){
		logger.info("UserCalendarSubCategoryRestServiceController: addUserCalendarSubCategories called...");
		RestResult result = new RestResult();
		
		Date now = new Date(Calendar.getInstance().getTimeInMillis());
		Timestamp t = new Timestamp(now.getTime());

		currentUser = getCurrentAuthUser();
		try {
			for(BeOneCalendarSubCategoryTO beOneCalendarSub: beOneCalendarSubs){
				BeOneCalendarSubCategory converted = 
						BeOneCalendarSubCategoryUtil.convertFromTO(beOneCalendarSub);
				
				UserCalendarSubCategory sub = new UserCalendarSubCategory();
				sub.setBeOneCalendarSubCategory(converted);
				sub.setUser(currentUser);
				sub.setCreatedAt(t);
				sub.setUpdatedAt(t);
				userCalendarSubCategoryService.addUserCalendarSubCategory(sub);
			}
			result.setData(beOneCalendarSubs);
			result.setStatus(true);
			result.setMessage("UserCalendarSubCategoryRestServiceController: addUserCalendarSubCategories successful...");
		} catch(Exception e){
			logger.error("UserCalendarSubCategoryRestServiceController: addUserCalendarSubCategories error!", e);
			result.setData(null);
			result.setMessage("UserCalendarSubCategoryRestServiceController: addUserCalendarSubCategories error!");
			result.setStatus(false);
		}
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/removeUserCalendarSubCategories/",
			produces = "application/json",
			method = RequestMethod.POST
			)
	public RestResult removeUserCalendarSubCategories(
			@RequestBody Set<BeOneCalendarSubCategoryTO> beOneCalendarSubs){
		logger.info("UserCalendarSubCategoryRestServiceController: removeUserCalendarSubCategories called...");
		currentUser = getCurrentAuthUser();
		
		RestResult result = new RestResult();
		try {
			for(BeOneCalendarSubCategoryTO beOneCalendarSub: beOneCalendarSubs){
				BeOneCalendarSubCategory converted = 
						BeOneCalendarSubCategoryUtil.convertFromTO(beOneCalendarSub);
				UserCalendarSubCategory sub = new UserCalendarSubCategory();
				sub.setBeOneCalendarSubCategory(converted);
				sub.setUser(currentUser);
				
				UserCalendarSubCategory existing = 
						userCalendarSubCategoryService.getUserSubCategoryIfExists(sub);
				
				if(existing != null) {
					userCalendarSubCategoryService.deleteUserCalendarSubCategory(existing);
				} else {
					logger.warn("UserCalendarSubCategoryRestServiceController: removeUserCalendarSubCategories tried to delete a not existing item!");
					result.setData(null);
					result.setMessage("UserCalendarSubCategoryRestServiceController: Subcategory membership does not exist");
					result.setStatus(false);
				}
			}
			result.setData(beOneCalendarSubs);
			result.setStatus(true);
			result.setMessage("UserCalendarSubCategoryRestServiceController: removeUserCalendarSubCategories successful...");
		} catch(Exception e){
			logger.error("UserCalendarSubCategoryRestServiceController: removeUserCalendarSubCategories error!", e);
			result.setData(null);
			result.setMessage("UserCalendarSubCategoryRestServiceController: removeUserCalendarSubCategories error!");
			result.setStatus(false);
		}
		return result;
	}
}