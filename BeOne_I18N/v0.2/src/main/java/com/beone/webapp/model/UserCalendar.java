package com.beone.webapp.model;

import java.io.Serializable;
import java.sql.Timestamp;

import com.beone.webapp.model.User;
import com.beone.webapp.model.BeOneCalendar;

public class UserCalendar implements Serializable{

	private static final long serialVersionUID = 7954484159087264358L;

	//private int entryId;
	private User user;
	private BeOneCalendar calendar;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public BeOneCalendar getCalendar() {
		return calendar;
	}
	public void setCalendar(BeOneCalendar calendar) {
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