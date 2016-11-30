package com.beone.webapp.utils;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarEvent;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.UserCalendar;
import com.beone.webapp.services.v1.model.BeOneCalendarEventTO;
import com.beone.webapp.services.v1.model.BeOneCalendarSubCategoryTO;
import com.beone.webapp.services.v1.model.BeOneCalendarTO;
import com.beone.webapp.services.v1.model.UserCalendarTO;

public class BeOneCalendarUtil {

	public static Set<BeOneCalendarTO> convertToTOSet(Set<BeOneCalendar> allUserCalendars) {
		Set<BeOneCalendarTO> converted = new HashSet<BeOneCalendarTO>();
		for(BeOneCalendar cal : allUserCalendars) {
			BeOneCalendarTO con = convertToTO(cal);
			converted.add(con);
		}
		
		return converted;
	}

	public static BeOneCalendarTO convertToTO(BeOneCalendar cal) {
		BeOneCalendarTO converted = new BeOneCalendarTO();
		
		converted.setCalendarId(cal.getCalendarId());
		converted.setCalendarName(cal.getCalendarName());
		converted.setDescription(cal.getDescription());
		converted.setColorCode(cal.getColorCode());
		converted.setCalendarIcon(cal.getCalendarIcon());
		converted.setSortOrder(cal.getSortOrder());
		
		return converted;
	}

	public static Set<BeOneCalendarEventTO> convertEventToTOSet(Set<BeOneCalendarEvent> allUserCalendarEvents) {
		Set<BeOneCalendarEventTO> converted = new HashSet<BeOneCalendarEventTO>();
		for(BeOneCalendarEvent cal : allUserCalendarEvents) {
			BeOneCalendarEventTO con = convertEventToTO(cal);
			converted.add(con);
		}
		
		return converted;
	}

	public static BeOneCalendarEventTO convertEventToTO(BeOneCalendarEvent cal) {
		BeOneCalendarEventTO converted = new BeOneCalendarEventTO();
		
		converted.setEventDate(cal.getEventDate());
		converted.setEventDescription(cal.getEventDescription());
		converted.setEventId(cal.getEventId());
		converted.setEventLocation(cal.getEventLocation());
		converted.setEventName(cal.getEventName());
		converted.setEventType(cal.getEventType());
		converted.setSubCategory(convertSubCategoryToTO(cal.getSubCategory()));
		converted.setEventHappeningPhotoFilename(cal.getEventHappeningPhotoFilename());
		
		return converted;
	}

	public static BeOneCalendarSubCategoryTO convertSubCategoryToTO(BeOneCalendarSubCategory subCat) {
		BeOneCalendarSubCategoryTO converted = new BeOneCalendarSubCategoryTO();
		converted.setCalendarSubCategory(subCat.getCalendarSubCategory());
		converted.setDescription(subCat.getDescription());
		converted.setSubcategoryId(subCat.getSubcategoryId());
		converted.setCalendar(convertToTO(subCat.getCalendar()));
		
		return converted;
	}

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

	public static UserCalendarTO convertUserCalendarToTO(UserCalendar userCalendar) {
		UserCalendarTO converted = new UserCalendarTO();
		converted.setCalendar(convertToTO(userCalendar.getCalendar()));
		converted.setUser(BeOneUserUtil.convertToTO(userCalendar.getUser()));
		converted.setCreatedAt(userCalendar.getCreatedAt());
		converted.setUpdatedAt(userCalendar.getUpdatedAt());
		
		return converted;
	}

}