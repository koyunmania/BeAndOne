package com.beone.webapp.services.v1;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.beone.webapp.controller.ControllerUtils;
import com.beone.webapp.controller.InvalidRequestParameterException;
import com.beone.webapp.controller.service.ExperienceService;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserExperience;

@RestController
public class ExperienceRestServiceController extends AbstractController {
	
	private static final Logger logger = LoggerFactory.getLogger(ExperienceRestServiceController.class);
	
	@Autowired
	private ExperienceService experienceService;

	public ExperienceService getExperienceService() {
		return experienceService;
	}

	public void setExperienceService(ExperienceService experienceService) {
		this.experienceService = experienceService;
	}
	
	@RequestMapping(
			value = "/api/v1/experiences/test", 
			produces = "application/json",
			method = RequestMethod.GET)
	public RestResult testConnection(
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("testConnection-post is called");
		
		RestResult result = new RestResult();
		result.setData(null);
		result.setMessage("Experiences loaded");
		result.setStatus(true);
		
		return result;
	}

	@RequestMapping(
			value = "/api/v1/experiences", 
			produces = "application/json",
			method = RequestMethod.GET)
	public RestResult getLast10UserExperiences(
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("getLast10UserExperiences-post is called");
		
		currentUser = getCurrentAuthUser();
		
		RestResult result = new RestResult();
		try {
			ArrayList<UserExperience> experiences = experienceService.getLast10UserExperiences(currentUser);
			result.setData(experiences);
			result.setMessage("Experiences loaded");
			result.setStatus(true);
		} catch(Exception e) {
			logger.error("ExperienceRestServiceController: getLast10UserExperiences error!", e);
			result.setData(null);
			result.setMessage("Experiences could not be loaded");
			result.setStatus(false);
		}
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/experiences/{date}", 
			produces = "application/json",
			method = RequestMethod.GET)
	public RestResult getLast10UserExperiencesOfDate(
			@PathVariable(value="date") String date, 
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("getLast10UserExperiencesOfDate-post is called with: " + date);
		
		currentUser = getCurrentAuthUser();
		
		RestResult result = new RestResult();
		
		try {
			ControllerUtils.validateDateParameter(date);

			try {
				ArrayList<UserExperience> experiences = experienceService.getLast10UserExperiencesOfDate(currentUser, date);
				result.setData(experiences);
				result.setMessage("Experiences loaded");
				result.setStatus(true);
			} catch(Exception e) {
				result.setData(null);
				result.setMessage("Experiences could not be loaded");
				result.setStatus(false);
			}
		} catch(InvalidRequestParameterException ex) {
			logger.error("ExperienceRestServiceController: getLast10UserExperiencesOfDate error!", ex);
			result.setData(null);
			result.setMessage("Given date value is not valid");
			result.setStatus(false);
		}
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/experiences", 
			produces = "application/json",
			method = RequestMethod.POST)
	public RestResult createOrAddUserExperience(@RequestBody UserExperience userExperience) {
		logger.info("createOrAddUserExperience-post is called");
		
		// if the user is empty, then get it from the contextt
		User currentUser = null;
		RestResult result = new RestResult();
		
		if(userExperience.getExperienceDescription() == null || userExperience.getExperienceDescription() == "") {
			logger.warn("Description provided empty");
			result.setData(null);
			result.setMessage("Experience description may not be empty");
			result.setStatus(false);
		} else {
			if(userExperience.getUser() == null) {
				logger.info("No user provided, current user is being used");
				currentUser = getCurrentAuthUser();
				
				//check if userExperience is an existing one which should be updated
				//if so set updatedAt time else createdAt
				if(userExperience.getUserExperienceId() > 0) {
					Date now = new Date(Calendar.getInstance().getTimeInMillis());
					Timestamp t = new Timestamp(now.getTime());
					String description = userExperience.getExperienceDescription();
					userExperience = experienceService.getUserExperienceById(currentUser, userExperience.getUserExperienceId());
					userExperience.setUser(currentUser);
					userExperience.setUpdatedAt(t);
					userExperience.setExperienceDescription(description);
					
				}
				else {
					Date now = new Date(Calendar.getInstance().getTimeInMillis());
					Timestamp t = new Timestamp(now.getTime());
					userExperience.setUser(currentUser);
					userExperience.setCreatedAt(t);
					userExperience.setUpdatedAt(t);
				}
				
				try {
					UserExperience res = experienceService.createOrAddUserExperience(userExperience);
					result.setData(res);
					result.setMessage("Experience inserted or updated");
					result.setStatus(true);
				} catch(Exception e) {
					logger.error("ExperienceRestServiceController: createOrAddUserExperience error!", e);
					result.setData(null);
					result.setMessage("Experience could not be inserted or updated");
					result.setStatus(false);
				}
			} else {
				logger.warn("This error should not have been occurred");
				result.setData(null);
				result.setMessage("User for this experience could not be retrieved.");
				result.setStatus(false);
			}
		}

		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/experiences/", 
			params = {"experienceId"},
			produces = "application/json",
			method = RequestMethod.DELETE)
	public RestResult deleteUserExperience(
			@RequestParam(value = "experienceId") int experienceId,
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("deleteUserExperience-post is called");
		
		currentUser = getCurrentAuthUser();
		
		RestResult result = new RestResult();
		
		try {
			experienceService.deleteUserExperience(currentUser, experienceId);
			result.setData(null);
			result.setMessage("Experience deleted");
			result.setStatus(true);
		} catch(Exception e) {
			logger.error("ExperienceRestServiceController: deleteUserExperience error!", e);
			result.setData(null);
			result.setMessage("Experience could not be deleted");
			result.setStatus(false);
		}
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/experiences/",
			params = {"experienceId"},
			produces = "application/json",
			method = RequestMethod.GET
			)
	public RestResult getUserExperienceById(@RequestParam(value = "experienceId") int experienceId) {
		logger.info("getUserExperienceById GET is called");
		
		currentUser = getCurrentAuthUser();
		
		RestResult result = new RestResult();
		
		try {
			UserExperience res = experienceService.getUserExperienceById(currentUser, experienceId);
			result.setData(res);
			result.setMessage("Experience loaded");
			result.setStatus(true);
		}
		catch(Exception e) {
			logger.error("ExperienceRestServiceController: getUserExperienceById error!", e);
			result.setData(null);
			String string = String.format("Experience with id=%s can not be found!", experienceId);
			result.setMessage(string);
			result.setStatus(false);
		}
		return result;

	} 
}
