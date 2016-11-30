package com.beone.webapp.model;

public class UserAlbum {
	private int albumId;
	private User user;
	private String albumName;
	private String albumFoldername;
	public int getAlbumId() {
		return albumId;
	}
	public void setAlbumId(int albumId) {
		this.albumId = albumId;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getAlbumName() {
		return albumName;
	}
	public void setAlbumName(String albumName) {
		this.albumName = albumName;
	}
	public String getAlbumFoldername() {
		return albumFoldername;
	}
	public void setAlbumFoldername(String albumFoldername) {
		this.albumFoldername = albumFoldername;
	}
	
}
