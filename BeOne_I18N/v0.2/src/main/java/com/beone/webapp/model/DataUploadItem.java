package com.beone.webapp.model;

import org.springframework.web.multipart.MultipartFile;

public class DataUploadItem {
	
	private City city;
	private Country country;
	private MultipartFile uploadFile;
	public City getCity() {
		return city;
	}
	public void setCity(City city) {
		this.city = city;
	}
	public Country getCountry() {
		return country;
	}
	public void setCountry(Country country) {
		this.country = country;
	}
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	
		
}
