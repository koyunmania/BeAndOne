package com.beone.webapp.utils;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.BeOneCalendarSubCategoryTranslation;
import com.beone.webapp.model.BeOneLanguage;
import com.beone.webapp.services.v1.model.BeOneCalendarSubCategoryTO;

public class BeOneCalendarSubCategoryUtil {
	public static BeOneCalendarSubCategoryTO convertToTO(
			BeOneCalendarSubCategory calendarSubCategory, BeOneLanguage language) {
		
		Set<BeOneCalendarSubCategoryTranslation> translations = calendarSubCategory.getTranslations();
		BeOneCalendarSubCategoryTranslation trans = null;
		for(BeOneCalendarSubCategoryTranslation tr : translations) {
			if(tr.getLanguageId() == language.ordinal()) {
				trans = tr;
			}
		}
		
		BeOneCalendarSubCategoryTO converted = new BeOneCalendarSubCategoryTO();
		converted.setCalendar(BeOneCalendarUtil.convertToTO(calendarSubCategory.getCalendar(), language));
		converted.setCalendarSubCategory(trans == null ? "Missing Translation" : trans.getCalendarSubCategoryTrans());
		converted.setDescription(trans == null ? "Missing Translation" : trans.getDescriptionTrans());
		converted.setSubcategoryId(calendarSubCategory.getSubcategoryId());
		return converted;
	}
	
	public static Set<BeOneCalendarSubCategoryTO> convertToTOSet(
			Set<BeOneCalendarSubCategory> calendarSubCategorySet, BeOneLanguage language){
		Set<BeOneCalendarSubCategoryTO> converted = new HashSet<BeOneCalendarSubCategoryTO>();
		for(BeOneCalendarSubCategory calendarSubCategory: calendarSubCategorySet){
			converted.add(convertToTO(calendarSubCategory, language));
		}
		return converted;
	}

	public static BeOneCalendarSubCategory convertFromTO(BeOneCalendarSubCategoryTO beOneCalendarSub) {
		BeOneCalendarSubCategory converted = new BeOneCalendarSubCategory();
		converted.setSubcategoryId(beOneCalendarSub.getSubcategoryId());
		converted.setCalendar(BeOneCalendarUtil.convertFromTO(beOneCalendarSub.getCalendar()));
		
		return converted;
	}
}