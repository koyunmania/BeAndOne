package com.beone.webapp.model;

import java.sql.Date;
import java.util.Set;

public class UserWish {
	
	private User user;
	private int userWishId;
	private String wishText;
	private Date createdAt;
	private Date updatedAt;
	private boolean active;
	private Set<UserWishDailyCheck> wishDailyChecks;
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	/**
	 * @return the updatedAt
	 */
	public Date getUpdatedAt() {
		return updatedAt;
	}
	/**
	 * @param updatedAt the updatedAt to set
	 */
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	/**
	 * @return the createdAt
	 */
	public Date getCreatedAt() {
		return createdAt;
	}
	/**
	 * @param createdAt the createdAt to set
	 */
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	/**
	 * @return the wishText
	 */
	public String getWishText() {
		return wishText;
	}
	/**
	 * @param wishText the wishText to set
	 */
	public void setWishText(String wishText) {
		this.wishText = wishText;
	}
	/**
	 * @return the userWishId
	 */
	public int getUserWishId() {
		return userWishId;
	}
	/**
	 * @param userWishId the userWishId to set
	 */
	public void setUserWishId(int userWishId) {
		this.userWishId = userWishId;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	public Set<UserWishDailyCheck> getWishDailyChecks() {
		return wishDailyChecks;
	}
	public void setWishDailyChecks(Set<UserWishDailyCheck> wishDailyChecks) {
		this.wishDailyChecks = wishDailyChecks;
	}
}
