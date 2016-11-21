package com.beone.webapp.model;

import java.io.Serializable;
import java.sql.Date;

public class UserFriend implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3109261686340861037L;
	private int userId;
	private int friendUserId;
	private String friendshipStatus;
	private Date createdAt;
	private Date updatedAt;
	
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getFriendUserId() {
		return friendUserId;
	}
	public void setFriendUserId(int friendUserId) {
		this.friendUserId = friendUserId;
	}
	public String getFriendshipStatus() {
		return friendshipStatus;
	}
	public void setFriendshipStatus(String friendshipStatus) {
		this.friendshipStatus = friendshipStatus;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public Date getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
}
