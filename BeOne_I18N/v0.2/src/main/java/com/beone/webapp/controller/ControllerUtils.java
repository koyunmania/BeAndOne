package com.beone.webapp.controller;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ControllerUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(ControllerUtils.class);
	
	public static void validateDateParameter(String date) throws InvalidRequestParameterException {
		Pattern p = Pattern.compile("[0-9]{2}-[0-9]{2}-20[0-9]{2}");
		Matcher m = p.matcher(date);
		// has it the length of 8
		if(date.length() != 10) {
			logger.warn("The provided date is not valid {}, has not the length of 10", date);
			throw new InvalidRequestParameterException();
		} else if(!m.find()) {
			logger.warn("The provided date is not valid {}, doesnt match the pattern", date);
			throw new InvalidRequestParameterException();
		} else {
			// do nothing
		}
	}
}
