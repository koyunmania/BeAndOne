package com.beone.webapp.model;

import java.sql.Timestamp;

public class CoverPhoto {
	
	private int photoId;
	private String photoFileName;
	private String photoDisplayDay;
	private boolean isActive;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	
	public int getPhotoId() {
		return photoId;
	}
	public void setPhotoId(int photoId) {
		this.photoId = photoId;
	}
	public String getPhotoFileName() {
		return photoFileName;
	}
	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}
	public String getPhotoDisplayDay() {
		return photoDisplayDay;
	}
	public void setPhotoDisplayDay(String photoDisplayDay) {
		this.photoDisplayDay = photoDisplayDay;
	}
	public boolean getIsActive() {
		return isActive;
	}
	public void setIsActive(boolean isActive) {
		this.isActive = isActive;
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
