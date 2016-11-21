package com.beone.webapp.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class UserCalendarSubCategory implements Serializable {

	private static final long serialVersionUID = -3773222476839580352L;
	
	private BeOneCalendarSubCategory beOneCalendarSubCategory;
	private User user;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	
	public BeOneCalendarSubCategory getBeOneCalendarSubCategory(){
		return beOneCalendarSubCategory;
	}
	public void setBeOneCalendarSubCategory(BeOneCalendarSubCategory beOneCalendarSubCategory){
		this.beOneCalendarSubCategory = beOneCalendarSubCategory;
	}
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
	}
	public Timestamp getCreatedAt(){
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt){
		this.createdAt = createdAt;
	}
	public Timestamp getUpdatedAt(){
		return updatedAt;
	}
	public void setUpdatedAt(Timestamp updatedAt){
		this.updatedAt = updatedAt;
	}
}
