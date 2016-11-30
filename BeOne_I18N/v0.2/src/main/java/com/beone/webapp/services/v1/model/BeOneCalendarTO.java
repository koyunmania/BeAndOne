package com.beone.webapp.services.v1.model;

public class BeOneCalendarTO {
	private String calendarName;
	private String description;
	private int calendarId;
	private String colorCode;
	private String calendarIcon;
	private String buttonClass;
	private int sortOrder;
	
	public String getCalendarName() {
		return calendarName;
	}
	public void setCalendarName(String calendarName) {
		this.calendarName = calendarName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
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
	
}
