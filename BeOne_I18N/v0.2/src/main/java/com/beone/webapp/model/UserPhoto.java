package com.beone.webapp.model;

public class UserPhoto {
	private int albumPhotoId;
	private UserAlbum album;
	private String randomFilename;
	private String originalFilename;
	private boolean isActive;
	public int getAlbumPhotoId() {
		return albumPhotoId;
	}
	public void setAlbumPhotoId(int albumPhotoId) {
		this.albumPhotoId = albumPhotoId;
	}
	public UserAlbum getAlbum() {
		return album;
	}
	public void setAlbum(UserAlbum album) {
		this.album = album;
	}
	public String getRandomFilename() {
		return randomFilename;
	}
	public void setRandomFilename(String randomFilename) {
		this.randomFilename = randomFilename;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}
	public boolean getIsActive() {
		return isActive;
	}
	public void setIsActive(boolean isActive) {
		this.isActive = isActive;
	}
	
}
