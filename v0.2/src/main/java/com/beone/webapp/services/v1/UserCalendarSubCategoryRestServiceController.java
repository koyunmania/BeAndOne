package com.beone.webapp.services.v1;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.HashSet;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.beone.webapp.controller.AbstractController;
import com.beone.webapp.controller.service.BeOneCalendarSubCategoryService;
import com.beone.webapp.controller.service.UserCalendarSubCategoryService;
import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserCalendarSubCategory;
import com.beone.webapp.services.v1.model.UserCalendarSubCategoryTO;
import com.beone.webapp.utils.BeOneCalendarSubCategoryUtil;
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
	public RestResult getAllUserCalendarSubCategories(){
		RestResult result = new RestResult();
		logger.info("UserCalendarSubCategoryRestServiceController: getAllUserCalendarSubCategories method called...");
		
		currentUser = getCurrentAuthUser();
		
		Set<UserCalendarSubCategoryTO> subs = new HashSet<UserCalendarSubCategoryTO>(); 
		
		try {
			subs = UserCalendarSubCategoryUtil.convertToTOSet(userCalendarSubCategoryService.getAllUserCalendarSubCategories(currentUser));
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
			@RequestBody Set<BeOneCalendarSubCategory> beOneCalendarSubs){
		logger.info("UserCalendarSubCategoryRestServiceController: addUserCalendarSubCategories called...");
		RestResult result = new RestResult();
		
		Date now = new Date(Calendar.getInstance().getTimeInMillis());
		Timestamp t = new Timestamp(now.getTime());

		User currentUser = getCurrentAuthUser();
		try {
			for(BeOneCalendarSubCategory beOneCalendarSub: beOneCalendarSubs){
				UserCalendarSubCategory sub = new UserCalendarSubCategory();
				sub.setBeOneCalendarSubCategory(beOneCalendarSub);
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
			@RequestBody Set<BeOneCalendarSubCategory> beOneCalendarSubs){
		logger.info("UserCalendarSubCategoryRestServiceController: removeUserCalendarSubCategories called...");
		RestResult result = new RestResult();
		try {
			for(BeOneCalendarSubCategory beOneCalendarSub: beOneCalendarSubs){
				UserCalendarSubCategory sub = new UserCalendarSubCategory();
				sub.setBeOneCalendarSubCategory(beOneCalendarSub);
				sub.setUser(currentUser);
				userCalendarSubCategoryService.deleteUserCalendarSubCategory(sub);
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