package com.beone.webapp.utils;

import java.util.Locale;

import org.springframework.context.support.ReloadableResourceBundleMessageSource;

import com.beone.webapp.model.BeOneLanguage;
import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.User;

public class MessageTranslator {
	public static String getStatusMessageTranslation(ReloadableResourceBundleMessageSource messageSource, StatusCode code, Locale locale) {
		String result = "Translation missing: "+ code.name();
		
		String trans = messageSource.getMessage("logic.application."+code.name(), null, locale);
		if(trans != null && !"".equals(trans)) {
			result = trans;
		}
		
		return result;
	}

	public static BeOneLanguage getLanguageOfUserOrCaller(User currentUser, Locale locale) {
		if(currentUser.getLanguage() != -1) {
			return BeOneLanguage.TURKISH;
		} else {
			if(locale.getLanguage().equals(new Locale("tr").getLanguage())) {
				return BeOneLanguage.TURKISH;
			} else if(locale.getLanguage().equals(new Locale("de").getLanguage())) {
				return BeOneLanguage.GERMAN;
			} else if(locale.getLanguage().equals(new Locale("en").getLanguage())) {
				return BeOneLanguage.ENGLISH;
			} else {
				return BeOneLanguage.TURKISH;
			}
		}
	}
}
