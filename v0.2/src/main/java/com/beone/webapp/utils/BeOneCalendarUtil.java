package com.beone.webapp.utils;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarEvent;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.BeOneCalendarEventTranslation;
import com.beone.webapp.model.BeOneCalendarTranslation;
import com.beone.webapp.model.BeOneLanguage;
import com.beone.webapp.model.UserCalendar;
import com.beone.webapp.services.v1.model.BeOneCalendarEventTO;
import com.beone.webapp.services.v1.model.BeOneCalendarSubCategoryTO;
import com.beone.webapp.services.v1.model.BeOneCalendarTO;
import com.beone.webapp.services.v1.model.UserCalendarTO;

public class BeOneCalendarUtil {

	public static Set<BeOneCalendarTO> convertToTOSet(
			Set<BeOneCalendar> allUserCalendars, BeOneLanguage language) {
		Set<BeOneCalendarTO> converted = new HashSet<BeOneCalendarTO>();
		for(BeOneCalendar cal : allUserCalendars) {
			BeOneCalendarTO con = convertToTO(cal, language);
			converted.add(con);
		}
		
		return converted;
	}

	public static BeOneCalendarTO convertToTO(BeOneCalendar cal, BeOneLanguage language) {
		BeOneCalendarTO converted = new BeOneCalendarTO();
		BeOneCalendarTranslation trans = null;
		for(BeOneCalendarTranslation tr : cal.getTranslations()) {
			if(tr.getLanguageId() == language.ordinal()) {
				trans = tr;
			}
		}
		
		converted.setCalendarId(cal.getCalendarId());
		converted.setCalendarName(trans == null ? BeOneCalendar.CALENDAR_NAME_TRANSLATION_MISSING : trans.getTransName());
		converted.setDescription(trans == null ? BeOneCalendar.CALENDAR_DESC_TRANSLATION_MISSING : trans.getTransName());
		converted.setColorCode(cal.getColorCode());
		converted.setSortOrder(cal.getSortOrder());
		converted.setButtonClass(cal.getButtonClass());
		
		return converted;
	}

	public static Set<BeOneCalendarEventTO> convertEventToTOSet(
			Set<BeOneCalendarEvent> allUserCalendarEvents, BeOneLanguage language) {
		Set<BeOneCalendarEventTO> converted = new HashSet<BeOneCalendarEventTO>();
		for(BeOneCalendarEvent cal : allUserCalendarEvents) {
			BeOneCalendarEventTO con = convertEventToTO(cal, language);
			converted.add(con);
		}
		
		return converted;
	}

	public static BeOneCalendarEventTO convertEventToTO(BeOneCalendarEvent cal, BeOneLanguage language) {
		Set<BeOneCalendarEventTranslation> translations = cal.getTranslations();
		BeOneCalendarEventTranslation trans = null;
		for(BeOneCalendarEventTranslation tr : translations) {
			if(tr.getLanguageId() == language.ordinal()) {
				trans = tr;
			}
		}
		
		BeOneCalendarEventTO converted = new BeOneCalendarEventTO();
		
		converted.setEventDate(cal.getEventDate());
		converted.setEventDescription(trans == null ? "Translation missing" : trans.getEventDescription());
		converted.setEventId(cal.getEventId());
		converted.setEventLocation(cal.getEventLocation());
		converted.setEventName(trans == null ? "Translation missing" : trans.getEventName());
		converted.setEventType(cal.getEventType());
		converted.setSubCategory(BeOneCalendarSubCategoryUtil.convertToTO(cal.getSubCategory(), language));
		converted.setEventHappeningPhotoUrl(
				trans == null 
					? "http://d3sljlta800p6s.cloudfront.net/PlusC/1.jpg"
					: "http://d3sljlta800p6s.cloudfront.net/PlusC/"+trans.getPlusCToWeb()+".jpg");
		
		return converted;
	}

//	public static BeOneCalendarSubCategoryTO convertSubCategoryToTO(
//			BeOneCalendarSubCategory subCat, BeOneLanguage language) {
//		Set<BeOneCalendarSubCategoryTranslation> translations = subCat.getTranslations();
//		BeOneCalendarSubCategoryTranslation trans = null;
//		for(BeOneCalendarSubCategoryTranslation tr : translations) {
//			if(tr.getLanguageId() == language.ordinal()) {
//				trans = tr;
//			}
//		}
//		
//		BeOneCalendarSubCategoryTO converted = new BeOneCalendarSubCategoryTO();
//		converted.setCalendarSubCategory(trans == null ? "Missing Translation" : trans.getTransName());
//		converted.setDescription(trans == null ? "Missing Translation" : trans.getTransDescription());
//		converted.setSubcategoryId(subCat.getSubcategoryId());
//		converted.setCalendar(convertToTO(subCat.getCalendar(), language));
//		
//		return converted;
//	}

	public static String getOrGenerateColorCode(String calendarName) {
		if(calendarName.contains("Astro")) {
			return "#020304";
		} else {
			return "#a0a0a0";
		}
	}

	public static String getOrGenerateCalendarIcon(String calendarName) {
		if(calendarName.contains("Astro")) {
			return "icon-astro";
		} else {
			return "icon-default";
		}
	}

	public static UserCalendarTO convertUserCalendarToTO(UserCalendar userCalendar, BeOneLanguage language) {
		UserCalendarTO converted = new UserCalendarTO();
		converted.setCalendar(convertToTO(userCalendar.getCalendar(), language));
		converted.setUser(BeOneUserUtil.convertToTO(userCalendar.getUser()));
		converted.setCreatedAt(userCalendar.getCreatedAt());
		converted.setUpdatedAt(userCalendar.getUpdatedAt());
		
		return converted;
	}

	public static BeOneCalendar convertFromTO(BeOneCalendarTO calendar) {
		BeOneCalendar converted = new BeOneCalendar();
		
		converted.setCalendarId(calendar.getCalendarId());
		converted.setButtonClass(calendar.getButtonClass());
		converted.setColorCode(calendar.getColorCode());
		converted.setSortOrder(calendar.getSortOrder());
		
		return converted;
	}

}
