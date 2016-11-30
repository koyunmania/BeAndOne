package com.beone.webapp.model;

public class BeOneCalendarSubCategory {
	private int subcategoryId;
	private String calendarSubCategory;
	private String description;
	private BeOneCalendar calendar;
	
	
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
	public BeOneCalendar getCalendar() {
		return calendar;
	}
	public void setCalendar(BeOneCalendar calendar) {
		this.calendar = calendar;
	}
	
	
}
