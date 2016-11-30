package com.beone.webapp.services.v1;

import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.beone.webapp.controller.AbstractController;
import com.beone.webapp.controller.service.CityService;
import com.beone.webapp.controller.service.CountryService;
import com.beone.webapp.controller.service.UserService;
import com.beone.webapp.model.Country;
import com.beone.webapp.model.User;
import com.beone.webapp.services.v1.model.CountryTO;
import com.beone.webapp.services.v1.model.UserTO;
import com.beone.webapp.utils.BeOneUserUtil;
import com.beone.webapp.utils.CityUtil;
import com.beone.webapp.utils.CountryUtil;

@RestController
public class UserRestServiceController extends AbstractController {
	private static final Logger logger = LoggerFactory.getLogger(UserRestServiceController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CountryService countryService;
	
	@Autowired
	private CityService cityService;
	
	public UserService getUserService() {
		return this.userService;
	}
	public void setUserService(UserService userService){
		this.userService = userService;
	}
	public CountryService getCountrService() {
		return this.countryService;
	}
	public void setCountryService(CountryService countryService) {
		this.countryService = countryService;
	}
	public CityService getCityService() {
		return this.cityService;
	}
	public void setCityService(CityService cityService) {
		this.cityService = cityService;
	}
	
	@RequestMapping(
			value = "/api/v1/countries/",
			produces = "application/json",
			method= RequestMethod.GET
			)
	public RestResult getAllCountriesWithCities() {
		logger.info("UserRestServiceController getAllCities method called...");
		RestResult result = new RestResult();
		
		try {
			Set<Country> countries = countryService.getAllCountriesWithCities();
			Set<CountryTO> countriesTO = CountryUtil.convertToTOSet(countries);
			
			result.setData(countriesTO);
			result.setMessage("UserRestServiceController getAllCountriesWithCities method returned...");
			result.setStatus(true);
			logger.info("UserRestServiceController getAllCountriesWithCities method returned...");
		} catch(Exception e) {
			result.setData(null);
			result.setMessage("UserRestServiceController getAllCountriesWithCities method error!!!");
			result.setStatus(false);
			logger.error("UserRestServiceController getAllCountriesWithCities method error.", e);
		}
		return result;
	}

	/*@RequestMapping(
			value = "/api/v1/countries_/",
			produces = "application/json",
			method = RequestMethod.GET
			)
	public RestResult getAllCountries(){
		logger.info("UserRestServiceController getAllCountries method called...");
		
		RestResult result = new RestResult();
		try {
			ArrayList<Country> countries = countryService.getAllCountries();
			result.setData(countries);
			result.setMessage("UserRestServiceController getAllCountries method returned...");
			result.setStatus(true);
			logger.info("UserRestServiceController getAllCountries method returned...");
		} catch(Exception e) {
			result.setData(null);
			result.setMessage("UserRestServiceController getAllCountries method error!!!");
			result.setStatus(true);
			logger.info("UserRestServiceController getAllCountries method error!!!");
		}
		
		return result;
	}*/
	
	@RequestMapping(
			value = "/api/v1/users/",
			produces = "application/json",
			method = RequestMethod.POST
			)
	public RestResult updateUser(@RequestBody UserTO user) {
		logger.info("UserRestServiceController update user method called...");
		
		currentUser = getCurrentAuthUser();
		RestResult result = new RestResult();
		
		try {
			currentUser.setBirthday(user.getBirthday());
			currentUser.setGender(user.getGender());
			currentUser.setUsername(user.getUsername());
			currentUser.setFirstname(user.getFirstname());
			currentUser.setLastname(user.getLastname());

			userService.updateUser(currentUser, user.getCurrentCityId(), user.getCurrentCountryId());
			
			result.setData(null);
			result.setMessage("User update successfully...");
			result.setStatus(true);
		} catch(Exception e) {
			logger.error("Error occured updating user information!", e);
			result.setData(null);
			result.setMessage("User could not be updated!");
			result.setStatus(false);
		}
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/users/", 
			produces = "application/json",
			method = RequestMethod.GET)
	public RestResult getCurrentUserProfile() {
		logger.info("getCurrentUserProfile-get is called");
		
		currentUser = getCurrentAuthUser();
		RestResult result = new RestResult();
		
		try {
			UserTO resultUser = BeOneUserUtil.convertToTO(currentUser);
			
			result.setData(resultUser);
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
}