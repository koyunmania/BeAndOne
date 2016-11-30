package com.beone.webapp.services.v1.model;

import com.beone.webapp.model.Country;

public class CityTO {
	
	private int cityId;
	private String cityName;
	
	public int getCityId() {
		return cityId;
	}
	public void setCityId(int cityId) {
		this.cityId = cityId;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
}
