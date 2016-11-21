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
public class CountryController extends AbstractController {
	private static final Logger logger = LoggerFactory.getLogger(CountryController.class);

	@RequestMapping(value = "/countries", method = RequestMethod.GET)
	public String countries(Locale locale, Model model) {
		logger.info("countries-get is called");
		
		initializeBasics(model);
		
		logger.debug("countries-get exiting");
		return "countries";
	}
	
	@RequestMapping(value = "/country/{countryName}", method = RequestMethod.GET)
	public String country(@PathVariable(value="countryName") String countryName, Locale locale, Model model) {
		logger.info("country-get is called");
		
		initializeBasics(model);
		
		logger.debug("country-get exiting");
		return "country";
	}
}
