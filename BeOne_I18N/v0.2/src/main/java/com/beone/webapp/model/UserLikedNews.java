package com.beone.webapp.model;

import java.sql.Timestamp;

public class UserLikedNews {
	private int entryId;
	private User user;	
	private Timestamp createdAt;
	private Timestamp updatedAt;
	private NewsFeed news;
	
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
	public NewsFeed getNews() {
		return news;
	}
	public void setNews(NewsFeed news) {
		this.news = news;
	}
}
