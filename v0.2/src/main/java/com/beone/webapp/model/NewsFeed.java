package com.beone.webapp.model;

import java.sql.Timestamp;

public class NewsFeed {
	
	private int feedId;
	private String feedTitle;
	private String feedContent;
	private User feedAuthor;
	private Timestamp feedPublishDate;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	
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
	public User getFeedAuthor() {
		return feedAuthor;
	}
	public void setFeedAuthor(User feedAuthor) {
		this.feedAuthor = feedAuthor;
	}
	public Timestamp getFeedPublishDate() {
		return feedPublishDate;
	}
	public void setFeedPublishDate(Timestamp feedPublishDate) {
		this.feedPublishDate = feedPublishDate;
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
