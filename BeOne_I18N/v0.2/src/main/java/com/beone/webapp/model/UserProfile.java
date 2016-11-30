package com.beone.webapp.model;

import java.io.Serializable;

public class UserProfile implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8934183490269443702L;
	private User user;
	private String providerId;
	private String provideruserId;
	private int rank;
	private String displayname;
	private String profileurl;
	private String imageurl;
	private String accesstoken;
	private String secret;
	private String refreshtoken;
	private int expiretime;
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getProviderId() {
		return providerId;
	}
	public void setProviderId(String providerId) {
		this.providerId = providerId;
	}
	public String getProvideruserId() {
		return provideruserId;
	}
	public void setProvideruserId(String provideruserId) {
		this.provideruserId = provideruserId;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public String getDisplayname() {
		return displayname;
	}
	public void setDisplayname(String displayname) {
		this.displayname = displayname;
	}
	public String getProfileurl() {
		return profileurl;
	}
	public void setProfileurl(String profileurl) {
		this.profileurl = profileurl;
	}
	public String getImageurl() {
		return imageurl;
	}
	public void setImageurl(String imageurl) {
		this.imageurl = imageurl;
	}
	public String getAccesstoken() {
		return accesstoken;
	}
	public void setAccesstoken(String accesstoken) {
		this.accesstoken = accesstoken;
	}
	public String getSecret() {
		return secret;
	}
	public void setSecret(String secret) {
		this.secret = secret;
	}
	public String getRefreshtoken() {
		return refreshtoken;
	}
	public void setRefreshtoken(String refreshtoken) {
		this.refreshtoken = refreshtoken;
	}
	public int getExpiretime() {
		return expiretime;
	}
	public void setExpiretime(int expiretime) {
		this.expiretime = expiretime;
	}
}
