package com.beone.webapp.utils;

import java.util.Locale;

import com.beone.webapp.model.StatusCode;

public class MessageTranslator {
	public static String getStatusMessageTranslation(StatusCode code, Locale locale) {
		String result = "Translation missing: "+ code.name();
		
		return result;
	}
}
