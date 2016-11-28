package com.beone.webapp.model;


public class BeOneCalendarEventTranslation {
	private int translationId;
	private int languageId;
	private String eventName;
	private String eventDescription;
	private String eventLocation;
	private int eventId;
	
	private String designNumber;
	private String plusCMessageNumber;
	private String plusCToWeb;
	private String plusCToWall;
	private String plusCToPrint;
	private String plusCToApp;
	
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	public int getLanguageId() {
		return languageId;
	}
	public void setLanguageId(int languageId) {
		this.languageId = languageId;
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
	public int getEventId() {
		return eventId;
	}
	public void setEventId(int eventId) {
		this.eventId = eventId;
	}
	public int getTranslationId() {
		return translationId;
	}
	public void setTranslationId(int translationId) {
		this.translationId = translationId;
	}
	public String getDesignNumber() {
		return designNumber;
	}
	public void setDesignNumber(String designNumber) {
		this.designNumber = designNumber;
	}
	public String getPlusCMessageNumber() {
		return plusCMessageNumber;
	}
	public void setPlusCMessageNumber(String plusCMessageNumber) {
		this.plusCMessageNumber = plusCMessageNumber;
	}
	public String getPlusCToWeb() {
		return plusCToWeb;
	}
	public void setPlusCToWeb(String plusCToWeb) {
		this.plusCToWeb = plusCToWeb;
	}
	public String getPlusCToWall() {
		return plusCToWall;
	}
	public void setPlusCToWall(String plusCToWall) {
		this.plusCToWall = plusCToWall;
	}
	public String getPlusCToPrint() {
		return plusCToPrint;
	}
	public void setPlusCToPrint(String plusCToPrint) {
		this.plusCToPrint = plusCToPrint;
	}
	public String getPlusCToApp() {
		return plusCToApp;
	}
	public void setPlusCToApp(String plusCToApp) {
		this.plusCToApp = plusCToApp;
	}
}
