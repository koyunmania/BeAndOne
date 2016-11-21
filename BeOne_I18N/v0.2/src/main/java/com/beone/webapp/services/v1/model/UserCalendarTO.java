package com.beone.webapp.services.v1.model;

import java.sql.Timestamp;

public class UserCalendarTO {
	private UserTO user;
	private BeOneCalendarTO calendar;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	public UserTO getUser() {
		return user;
	}
	public void setUser(UserTO user) {
		this.user = user;
	}
	public BeOneCalendarTO getCalendar() {
		return calendar;
	}
	public void setCalendar(BeOneCalendarTO calendar) {
		this.calendar = calendar;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
}
