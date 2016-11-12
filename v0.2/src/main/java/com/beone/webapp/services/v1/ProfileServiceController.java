package com.beone.webapp.services.v1;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RestController;

import com.beone.webapp.controller.AbstractController;

@RestController
public class ProfileServiceController extends AbstractController {
	private static final Logger logger = LoggerFactory.getLogger(ProfileServiceController.class);
	
	/*@RequestMapping(
			value = "/api/v1/profile/", 
			produces = "application/json",
			method = RequestMethod.GET)
	public RestResult getCurrentUserProfile(
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("getCurrentUserProfile-get is called");
		
		currentUser = getCurrentAuthUser();
		RestResult result = new RestResult();
		
		try {
			ProfileTO resultProfile = new ProfileTO();
			resultProfile.setFullname(currentUser.getFirstname() + " " + currentUser.getLastname());
			resultProfile.setBirthday(currentUser.getBirthday());
			resultProfile.setGender(currentUser.getGender());
			resultProfile.setCurrentCity(currentUser.getCurrentCity().getCityName());
			
			result.setData(resultProfile);
			result.setMessage("Profile loaded");
			result.setStatus(true);
		} catch(Exception e) {
			logger.error("Error occured during retrieval of active user profile", e);
			result.setData(null);
			result.setMessage("Profile could not be loaded");
			result.setStatus(false);
		}
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/profile/",
			produces = "application/json",
			method = RequestMethod.POST
			)
	public RestResult addOrUpdateCurrentUserProfile(){
		logger.info("addOrUpdateCurrentUserProfile-post is called");
		RestResult result = new RestResult();
		//ProfileController profile =  
		return result;
	}*/
}
