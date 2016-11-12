package com.beone.webapp.services.v1.model;

import java.sql.Timestamp;

import com.beone.webapp.model.User;

public class UserCalendarSubCategoryTO {
	private BeOneCalendarSubCategoryTO beOneCalendarSubCategoryTO;
	private UserTO userTO;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	
	public BeOneCalendarSubCategoryTO getBeOneCalendarSubCategory(){
		return beOneCalendarSubCategoryTO;
	}
	public void setBeOneCalendarSubCategory(BeOneCalendarSubCategoryTO beOneCalendarSubCategoryTO){
		this.beOneCalendarSubCategoryTO = beOneCalendarSubCategoryTO;
	}
	public UserTO getUser(){
		return userTO;
	}
	public void setUser(UserTO userTO){
		this.userTO = userTO;
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
