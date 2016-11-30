package com.beone.webapp.services.v1;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.beone.webapp.controller.AbstractController;
import com.beone.webapp.controller.ControllerUtils;
import com.beone.webapp.controller.InvalidRequestParameterException;
import com.beone.webapp.controller.service.WishDailyCheckService;
import com.beone.webapp.controller.service.WishService;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserWish;

@RestController
public class WishRestServiceController extends AbstractController {
	
	private static final Logger logger = LoggerFactory.getLogger(WishRestServiceController.class);
	
	@Autowired
	private WishService wishService;
	
	@Autowired
	private WishDailyCheckService checkService;

	public WishService getWishService() {
		return wishService;
	}

	public void setWishService(WishService wishService) {
		this.wishService = wishService;
	}
	
	public WishDailyCheckService getCheckService() {
		return checkService;
	}

	public void setCheckService(WishDailyCheckService checkService) {
		this.checkService = checkService;
	}

	@RequestMapping(
			value = "/api/v1/wishes/test", 
			produces = "application/json",
			method = RequestMethod.GET)
	public RestResult testConnection(
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("testConnection-post is called");
		
		RestResult result = new RestResult();
		result.setData(null);
		result.setMessage("Wishes loaded");
		result.setStatus(true);
		
		return result;
	}

	@RequestMapping(
			value = "/api/v1/wishes", 
			produces = "application/json",
			method = RequestMethod.GET)
	public RestResult getLastActiverWishes(
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("getLastActiverWishes-post is called");
		
		currentUser = getCurrentAuthUser();
		
		RestResult result = new RestResult();
		try {
			ArrayList<UserWish> wishes = wishService.getActiveUserWishes(currentUser);
			result.setData(wishes);
			result.setMessage("Wishes loaded");
			result.setStatus(true);
		} catch(Exception e) {
			logger.error("Error occured during retrieval of active user wishes", e);
			result.setData(null);
			result.setMessage("Wishes could not be loaded");
			result.setStatus(false);
		}
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/wishes/{date}", 
			produces = "application/json",
			method = RequestMethod.GET)
	public RestResult getLast10UserWishesOfDate(
			@PathVariable(value="date") String date, 
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("getLast10UserWishesOfDate-post is called");
		
		currentUser = getCurrentAuthUser();
		
		RestResult result = new RestResult();
		
		try {
			ControllerUtils.validateDateParameter(date);
			
			Date givenDate = Date.valueOf(date);

			try {
				ArrayList<UserWish> wishes = wishService.getUserWishesOfDate(currentUser, givenDate);
				result.setData(wishes);
				result.setMessage("Wishes loaded");
				result.setStatus(true);
			} catch(Exception e) {
				result.setData(null);
				result.setMessage("Wishs could not be loaded");
				result.setStatus(false);
				logger.error("Error occured during retrieval of active user wishes", e);
			}
		} catch(InvalidRequestParameterException ex) {
			result.setData(null);
			result.setMessage("Given date value is not valid");
			result.setStatus(false);
			logger.error("Error occured during retrieval of active user wishes", ex);
		}
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/wishes", 
			produces = "application/json",
			method = RequestMethod.POST)
	public RestResult createOrAddUserWish(
			@RequestBody UserWish userWish,
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("createOrAddUserWish-post is called");
		
		Calendar cal = GregorianCalendar.getInstance(TimeZone.getTimeZone("UTC"));
		
		// if the user is empty, then get it from the context
		User currentUser = null;
		RestResult result = new RestResult();
		
		if(userWish.getWishText() == null || userWish.getWishText() == "") {
			result.setData(null);
			result.setMessage("Wish description may not be empty");
			result.setStatus(false);
		} else {
			if(userWish.getUser() == null) {
				currentUser = getCurrentAuthUser();
				userWish.setUser(currentUser);
				userWish.setCreatedAt(new Date(cal.getTimeInMillis()));
				userWish.setUpdatedAt(new Date(cal.getTimeInMillis()));
				try {
					UserWish res = wishService.createOrAddUserWish(userWish, request, response);
					// add userwishdailycheck service and create an item for today
					checkService.addDailyCheckForWish(userWish);
					
					result.setData(res);
					result.setMessage("Wish inserted or updated");
					result.setStatus(true);
				} catch(Exception e) {
					result.setData(null);
					result.setMessage("Wish could not be inserted or updated");
					result.setStatus(false);
				}
			} else {
				result.setData(null);
				result.setMessage("User for this Wish could not be retrieved.");
				result.setStatus(false);
			}
		}
		
		
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/wishes/", 
			produces = "application/json",
			method = RequestMethod.DELETE)
	public RestResult deleteUserWish(
			@RequestBody UserWish userWish,
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("deleteUserWish-post is called");
		
		RestResult result = new RestResult();
		try {
			wishService.deleteUserWish(userWish, request, response);
			result.setData(null);
			result.setMessage("Wish deleted");
			result.setStatus(true);
		} catch(Exception e) {
			result.setData(null);
			result.setMessage("Wish could not be deleted");
			result.setStatus(false);
		}
		
		return result;
	}
}
