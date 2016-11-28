package com.beone.webapp.model;

import java.util.Set;

public class BeOneCalendar {
	
	public static final String CALENDAR_NAME_TRANSLATION_MISSING = "Name Missing";
	public static final String CALENDAR_DESC_TRANSLATION_MISSING = "Translation Missing";
	//	private String calendarName;
//	private String description;
	private int calendarId;
	private String colorCode;
	private String calendarIcon;
	private String buttonClass;
	private int sortOrder;
	private Set<BeOneCalendarTranslation> translations;
	
//	public String getCalendarName() {
//		return calendarName;
//	}
//	public void setCalendarName(String calendarName) {
//		this.calendarName = calendarName;
//	}
//	public String getDescription() {
//		return description;
//	}
//	public void setDescription(String description) {
//		this.description = description;
//	}
	public int getCalendarId() {
		return calendarId;
	}
	public void setCalendarId(int calendarId) {
		this.calendarId = calendarId;
	}
	public String getColorCode() {
		return colorCode;
	}
	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}
	public String getCalendarIcon() {
		return calendarIcon;
	}
	public void setCalendarIcon(String calendarIcon) {
		this.calendarIcon = calendarIcon;
	}
	public String getButtonClass() {
		return buttonClass;
	}
	public void setButtonClass(String buttonClass) {
		this.buttonClass = buttonClass;
	}
	public int getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(int sortOrder) {
		this.sortOrder = sortOrder;
	}
	public Set<BeOneCalendarTranslation> getTranslations() {
		return translations;
	}
	public void setTranslations(Set<BeOneCalendarTranslation> translations) {
		this.translations = translations;
	}
	
	
}
