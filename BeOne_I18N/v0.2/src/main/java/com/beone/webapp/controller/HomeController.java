package com.beone.webapp.controller;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.beone.constants.Constants;
import com.beone.webapp.controller.service.ExperienceService;
import com.beone.webapp.controller.service.UserAlbumService;
import com.beone.webapp.controller.service.UserService;
import com.beone.webapp.model.User;
import com.beone.webapp.utils.UrlUtils;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController extends AbstractController{
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private ExperienceService experienceService;
	
	@Autowired
	private UserAlbumService albumService;
	
	@Autowired
	private UserService userService;
	
	public UserAlbumService getAlbumService() {
		return albumService;
	}

	public void setAlbumService(UserAlbumService albumService) {
		this.albumService = albumService;
	}

	public ExperienceService getExperienceService() {
		return experienceService;
	}

	public void setExperienceService(ExperienceService experienceService) {
		this.experienceService = experienceService;
	}
	
	
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)	
	public String home(TimeZone timezone, Locale locale, Model model, @RequestParam(required = false, defaultValue = "en", value="lang") String lang) {
		logger.info("Welcome home! The client locale is {} and timezone is {}", locale, timezone);
		
		// get the current date of the user
		Calendar cal = GregorianCalendar.getInstance(timezone);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		month++;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		// build the date string
		String date = 
			"" + (day < 10 ? "0"+day : day) +
			"-" +
			(month < 10 ? "0"+month : month) +
			"-" +
			year;
		
		currentUser = getCurrentAuthUser();
		currentUser.setLocale(lang);
		userService.updateUserLocale(currentUser);
		
		// for the retrieval of profile image, there is another controller
//		String profilePhotoUrl = albumService.getUrlOfProfilePhoto(currentUser);
//		model.addAttribute("profilePhotoUrl", profilePhotoUrl);
		
		return openHomePage(model, date, timezone, currentUser);
	}

	@RequestMapping(value = "/home/{date}", method = RequestMethod.GET)
	public String homeDate(@PathVariable(value="date") String date, TimeZone timezone, Locale locale, Model model, @RequestParam(required = false, defaultValue = "en", value="lang") String lang) {
		logger.info("homeDate is called with date: " + date);
		logger.info("Welcome home! The client locale is {} and timezone is {}", locale, timezone);
		// validate the date string, check it
		
		try {
			ControllerUtils.validateDateParameter(date);
			return openHomePage(model, date, timezone, null);
		} catch(InvalidRequestParameterException ex) {
			return "error";
		}
	}
	
	private String openHomePage(Model model, String date, TimeZone timezone, User user) {
		String url = Constants.HOME;
		model.addAttribute("selectedDate", date);	
		
		// get the current date of the user
		Calendar cal = GregorianCalendar.getInstance(timezone);
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		month++;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		// build the date string
		String userDate = 
			""+(day < 10 ? "0"+day : day)+
			"-"+
			(month < 10 ? "0"+month : month) +
			"-"+
			year;
		
		model.addAttribute("usersCurrentDate", userDate);
		if(null!=user)
		{
			url = UrlUtils.getUserLocale(user, null, url);
		}
		return "home";
	}
}
