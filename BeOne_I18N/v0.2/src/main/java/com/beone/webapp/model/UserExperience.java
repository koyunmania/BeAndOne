package com.beone.webapp.model;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class UserExperience {
	
	private User user;
	private int userExperienceId;
	private String experienceDescription;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	/**
	 * For which date is this experience registered
	 */
	private String experienceDate;
	
	public User getUser() {
		return user;
	}
	@JsonIgnore
	public void setUser(User user) {
		this.user = user;
	}
	public int getUserExperienceId() {
		return userExperienceId;
	}
	public void setUserExperienceId(int userExperienceId) {
		this.userExperienceId = userExperienceId;
	}
	public String getExperienceDescription() {
		return experienceDescription;
	}
	public void setExperienceDescription(String experienceDescription) {
		this.experienceDescription = experienceDescription;
	}
	/**
	 * @return the updatedAt
	 */
	public Timestamp getUpdatedAt() {
		return updatedAt;
	}
	/**
	 * @param updatedAt the updatedAt to set
	 */
	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}
	/**
	 * @return the createdAt
	 */
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	/**
	 * @param createdAt the createdAt to set
	 */
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	/**
	 * @return the experienceDate
	 */
	public String getExperienceDate() {
		return experienceDate;
	}
	/**
	 * @param experienceDate the experienceDate to set
	 */
	public void setExperienceDate(String experienceDate) {
		this.experienceDate = experienceDate;
	}
}
