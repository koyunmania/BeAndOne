/*
 * Copyright 2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.beone.webapp.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 
 * @author Selcuk
 */
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class User implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -4889162244805841068L;
	
	public static final String USER_PROVIDER_BEONE = "beone";
	public static final String USER_PROVIDER_TWITTER = "twitter";
	public static final String USER_PROVIDER_FACEBOOK = "facebook";

	public static final String ATTR_PROVIDER_USERID = "providerUserId";

	public static final String ATTR_TOKEN = "token";
	
	private int userId;
	private String username;
	private String email;
	private String password;
	private String passwordRepeat;
	private String firstname;
	private String lastname;
	private String birthday;
	private String gender;
	private String provider;
	private String locale;
	private String status;
	private Timestamp createdAt;
	
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

	private Timestamp updatedAt;

	private Set<UserProfile> externalConnections;
	
	private City currentCity;
	private Country currentCountry;
	private int language;
	
	/**
	 * User's sport social connections
	 */
	private UserFriend[] userFriends;
	private ProfileEntry[] profileEntries;
	
	public User() {
		this.username = "";
	}
	
	public User(String username) {
		this.username = username;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordRepeat() {
		return passwordRepeat;
	}

	public void setPasswordRepeat(String passwordRepeat) {
		this.passwordRepeat = passwordRepeat;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}


	public String getLogRepresentation() {
		StringBuilder rep = new StringBuilder();
		
		rep.append("[username: ");
		rep.append(this.username);
		rep.append("]");
		rep.append("[email: ");
		rep.append(this.email);
		rep.append("]");
		rep.append("[firstname: ");
		rep.append(this.firstname);
		rep.append("]");
		rep.append("[lastname: ");
		rep.append(this.lastname);
		rep.append("]");
		
		return rep.toString();
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public Set<UserProfile> getExternalConnections() {
		return externalConnections;
	}

	public void setExternalConnections(Set<UserProfile> externalConnections) {
		this.externalConnections = externalConnections;
	}

	public UserFriend[] getUserFriends() {
		return userFriends;
	}

	public void setUserFriends(UserFriend[] userFriends) {
		this.userFriends = userFriends;
	}

	public ProfileEntry[] getProfileEntries() {
		return profileEntries;
	}

	public void setProfileEntries(ProfileEntry[] profileEntries) {
		this.profileEntries = profileEntries;
	}

	public City getCurrentCity() {
		return currentCity;
	}

	public void setCurrentCity(City currentCity) {
		this.currentCity = currentCity;
	}

	public Country getCurrentCountry() {
		return currentCountry;
	}

	public void setCurrentCountry(Country currentCountry) {
		this.currentCountry = currentCountry;
	}

	public int getLanguage() {
		return language;
	}

	public void setLanguage(int language) {
		this.language = language;
	}

	public String getLocale() {
		return locale;
	}

	public void setLocale(String locale) {
		this.locale = locale;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}
