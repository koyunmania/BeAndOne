package com.beone.webapp.utils;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.UserCalendarSubCategory;
import com.beone.webapp.services.v1.model.BeOneCalendarSubCategoryTO;
import com.beone.webapp.services.v1.model.UserCalendarSubCategoryTO;

public class UserCalendarSubCategoryUtil {
	public static UserCalendarSubCategoryTO convertToTO(UserCalendarSubCategory userCalendarSubCategory) {
		UserCalendarSubCategoryTO converted = new UserCalendarSubCategoryTO();
		converted.setBeOneCalendarSubCategory(BeOneCalendarSubCategoryUtil.convertToTO(userCalendarSubCategory.getBeOneCalendarSubCategory()));
		converted.setCreatedAt(userCalendarSubCategory.getCreatedAt());
		converted.setUpdatedAt(userCalendarSubCategory.getUpdatedAt());
		converted.setUser(UserUtil.convertToTO(userCalendarSubCategory.getUser()));
		return converted;
	}
	
	
	public static Set<UserCalendarSubCategoryTO> convertToTOSet(Set<UserCalendarSubCategory> userCalendarSubCategorySet){
		Set<UserCalendarSubCategoryTO> converted = new HashSet<UserCalendarSubCategoryTO>();
		for(UserCalendarSubCategory userCalendarSubCategory: userCalendarSubCategorySet){
			converted.add(convertToTO(userCalendarSubCategory));
		}
		return converted;
	}
}