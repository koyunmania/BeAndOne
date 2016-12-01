package com.beone.webapp.model;

import java.util.Set;

public class BeOneCalendarSubCategory {
	private int subcategoryId;
	private BeOneCalendar calendar;
	private Set<BeOneCalendarSubCategoryTranslation> translations;
	private String calendarIcon;
	
	
	public int getSubcategoryId() {
		return subcategoryId;
	}
	public void setSubcategoryId(int subcategoryId) {
		this.subcategoryId = subcategoryId;
	}
//	public String getCalendarSubCategory() {
//		return calendarSubCategory;
//	}
//	public void setCalendarSubCategory(String calendarSubCategory) {
//		this.calendarSubCategory = calendarSubCategory;
//	}
//	public String getDescription() {
//		return description;
//	}
//	public void setDescription(String description) {
//		this.description = description;
//	}
	public BeOneCalendar getCalendar() {
		return calendar;
	}
	public void setCalendar(BeOneCalendar calendar) {
		this.calendar = calendar;
	}
	public Set<BeOneCalendarSubCategoryTranslation> getTranslations() {
		return translations;
	}
	public void setTranslations(Set<BeOneCalendarSubCategoryTranslation> translations) {
		this.translations = translations;
	}
	public String getCalendarIcon() {
		return calendarIcon;
	}
	public void setCalendarIcon(String calendarIcon) {
		this.calendarIcon = calendarIcon;
	}
	
	
}
