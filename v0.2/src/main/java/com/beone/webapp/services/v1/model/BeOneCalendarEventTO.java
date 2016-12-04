package com.beone.webapp.services.v1.model;

import java.sql.Timestamp;

public class BeOneCalendarEventTO {
	private String eventName;
	private Timestamp eventDate;
	private String eventDescription;
	private String eventLocation;
	private String eventType;
	private int eventId;
	private BeOneCalendarSubCategoryTO subCategory;
	private String eventHappeningPhotoUrl;
	private String eventTimeDisplayable;
	
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	public Timestamp getEventDate() {
		return eventDate;
	}
	public void setEventDate(Timestamp eventDate) {
		this.eventDate = eventDate;
	}
	public String getEventDescription() {
		return eventDescription;
	}
	public void setEventDescription(String eventDescription) {
		this.eventDescription = eventDescription;
	}
	public String getEventLocation() {
		return eventLocation;
	}
	public void setEventLocation(String eventLocation) {
		this.eventLocation = eventLocation;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public int getEventId() {
		return eventId;
	}
	public void setEventId(int eventId) {
		this.eventId = eventId;
	}
	public BeOneCalendarSubCategoryTO getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(BeOneCalendarSubCategoryTO subCategory) {
		this.subCategory = subCategory;
	}
	public String getEventHappeningPhotoUrl() {
		return eventHappeningPhotoUrl;
	}
	public void setEventHappeningPhotoUrl(
			String eventHappeningPhotoUrl) {
		this.eventHappeningPhotoUrl = eventHappeningPhotoUrl;
	}
	public String getEventTimeDisplayable() {
		return eventTimeDisplayable;
	}
	public void setEventTimeDisplayable(String eventTimeDisplayable) {
		this.eventTimeDisplayable = eventTimeDisplayable;
	}
}
