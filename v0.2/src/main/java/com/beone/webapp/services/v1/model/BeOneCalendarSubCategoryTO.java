package com.beone.webapp.services.v1.model;

public class BeOneCalendarSubCategoryTO {
	private int subcategoryId;
	private String calendarSubCategory;
	private String description;
	private BeOneCalendarTO calendar;
	
	public int getSubcategoryId() {
		return subcategoryId;
	}
	public void setSubcategoryId(int subcategoryId) {
		this.subcategoryId = subcategoryId;
	}
	public String getCalendarSubCategory() {
		return calendarSubCategory;
	}
	public void setCalendarSubCategory(String calendarSubCategory) {
		this.calendarSubCategory = calendarSubCategory;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public BeOneCalendarTO getCalendar() {
		return calendar;
	}
	public void setCalendar(BeOneCalendarTO calendar) {
		this.calendar = calendar;
	}
	
	
}
