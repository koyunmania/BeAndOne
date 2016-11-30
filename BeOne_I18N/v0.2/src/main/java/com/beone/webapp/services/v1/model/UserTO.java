package com.beone.webapp.services.v1.model;

public class UserTO {
	private String username;
	private String email;
	private String firstname;
	private String lastname;
	private String birthday;
	private String gender;
	private CityTO currentCity;
	private CountryTO currentCountry;
	private int currentCityId;
	private int currentCountryId;

	public int getCurrentCityId() {
		return currentCityId;
	}
	public void setCurrentCityId(int currentCityId) {
		this.currentCityId = currentCityId;
	}
	public int getCurrentCountryId() {
		return currentCountryId;
	}
	public void setCurrentCountryId(int currentCountryId) {
		this.currentCountryId = currentCountryId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public CityTO getCurrentCity() {
		return currentCity;
	}
	public void setCurrentCity(CityTO currentCity) {
		this.currentCity = currentCity;
	}
	public CountryTO getCurrentCountry() {
		return currentCountry;
	}
	public void setCurrentCountry(CountryTO currentCountry) {
		this.currentCountry = currentCountry;
	}
}
