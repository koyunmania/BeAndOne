package com.beone.webapp.services.v1.model;

import java.util.Set;

import com.beone.webapp.model.City;

public class CountryTO {
	
	private String countryName;
	private int countryId;
	private Set<CityTO> cities;
	
	public String getCountryName() {
		return countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}

	public int getCountryId() {
		return countryId;
	}

	public void setCountryId(int countryId) {
		this.countryId = countryId;
	}

	public Set<CityTO> getCities() {
		return cities;
	}

	public void setCities(Set<CityTO> cities) {
		this.cities = cities;
	}
}

