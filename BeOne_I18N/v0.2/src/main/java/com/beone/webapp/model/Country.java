package com.beone.webapp.model;

import java.util.HashSet;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Country {
	
	private String countryName;
	
	private int countryId;
	
	//private List<City> cities;
	
	@JsonBackReference
	private Set<City> cities = new HashSet<City>();
	
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

	public Set<City> getCities() {
		return cities;
	}

	public void setCities(Set<City> cities) {
		this.cities = cities;
	}

//	public List<City> getCities() {
//		return cities;
//	}
//
//	public void setCities(List<City> cities) {
//		this.cities = cities;
//	}

}
