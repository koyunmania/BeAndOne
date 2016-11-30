package com.beone.webapp.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CityController extends AbstractController {
	private static final Logger logger = LoggerFactory.getLogger(CityController.class);

	@RequestMapping(value = "/cities", method = RequestMethod.GET)
	public String cities(Locale locale, Model model) {
		logger.info("cities-get is called");
		
		logger.debug("cities-get exiting");
		return "cities";
	}
	
	@RequestMapping(value = "/city/{cityName}", method = RequestMethod.GET)
	public String city(@PathVariable(value="cityName") String cityName, Locale locale, Model model) {
		logger.info("city-get is called");
		
		initializeBasics(model);
		
		logger.debug("city-get exiting");
		return "city";
	}
}
