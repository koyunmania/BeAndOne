package com.beone.webapp.model;

import java.sql.Timestamp;

public class UserFollowingUser {
	private int entryId;
	private User user;	
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private User followingUser;
	
	public int getEntryId() {
		return entryId;
	}
	public void setEntryId(int entryId) {
		this.entryId = entryId;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
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
	public User getFollowingUser() {
		return followingUser;
	}
	public void setFollowingUser(User followingUser) {
		this.followingUser = followingUser;
	}
}
