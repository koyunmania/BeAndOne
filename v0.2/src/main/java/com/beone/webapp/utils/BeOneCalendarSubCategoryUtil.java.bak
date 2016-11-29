package com.beone.webapp.utils;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.services.v1.model.BeOneCalendarSubCategoryTO;

public class BeOneCalendarSubCategoryUtil {
	public static BeOneCalendarSubCategoryTO convertToTO(BeOneCalendarSubCategory calendarSubCategory) {
		BeOneCalendarSubCategoryTO converted = new BeOneCalendarSubCategoryTO();
		converted.setCalendar(BeOneCalendarUtil.convertToTO(calendarSubCategory.getCalendar()));
		converted.setCalendarSubCategory(calendarSubCategory.getCalendarSubCategory());
		converted.setDescription(calendarSubCategory.getDescription());
		converted.setSubcategoryId(calendarSubCategory.getSubcategoryId());
		return converted;
	}
	
	public static Set<BeOneCalendarSubCategoryTO> convertToTOSet(Set<BeOneCalendarSubCategory> calendarSubCategorySet){
		Set<BeOneCalendarSubCategoryTO> converted = new HashSet<BeOneCalendarSubCategoryTO>();
		for(BeOneCalendarSubCategory calendarSubCategory: calendarSubCategorySet){
			converted.add(convertToTO(calendarSubCategory));
		}
		return converted;
	}
}