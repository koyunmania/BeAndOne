package com.beone.webapp.services.v1.model;

import java.sql.Timestamp;

public class NewsFeedTO {
	private int feedId;
	private String feedTitle;
	private String feedContent;
	private Timestamp feedPublishDate;
	private int userId;
	private String feedPicture;
	private String username;
	
	public int getFeedId() {
		return feedId;
	}
	public void setFeedId(int feedId) {
		this.feedId = feedId;
	}
	public String getFeedTitle() {
		return feedTitle;
	}
	public void setFeedTitle(String feedTitle) {
		this.feedTitle = feedTitle;
	}
	public String getFeedContent() {
		return feedContent;
	}
	public void setFeedContent(String feedContent) {
		this.feedContent = feedContent;
	}
	public Timestamp getFeedPublishDate() {
		return feedPublishDate;
	}
	public void setFeedPublishDate(Timestamp feedPublishDate) {
		this.feedPublishDate = feedPublishDate;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getFeedPicture() {
		return feedPicture;
	}
	public void setFeedPicture(String feedPicture) {
		this.feedPicture = feedPicture;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
}
