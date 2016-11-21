package com.beone.webapp.controller.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.Country;
import com.beone.webapp.persistence.CountryDao;
import com.beone.webapp.persistence.CityDao;

public class CountryService {
	private static final Logger logger = LoggerFactory.getLogger(LoginService.class);
	
	@Autowired
	private CountryDao countryDao;
	
	@Autowired
	private CityDao cityDao;

	public CountryDao getCountryDao() {
		return countryDao;
	}

	public void setCountryDao(CountryDao countryDao) {
		this.countryDao = countryDao;
	}
	
	public CityDao getCityDao() {
		return this.cityDao;
	}
	
	public void setCityDao(CityDao cityDao){
		this.cityDao = cityDao;
	}
	
	@Transactional
	public ArrayList<Country> getAllCountries() {
		ArrayList<Country> result = new ArrayList<Country>();
		
		result.addAll(countryDao.getAll());
		
		return result;
	}
	
	@Transactional
	public Set<Country> getAllCountriesWithCities() {
		Set<Country> result = new HashSet<Country>();
		
		Set<Country> allCountries = countryDao.getAll();
		
		/*for(Country ct : allCountries) {
			Set<City> cities = cityDao.getCitiesOfCountry(ct);
			City[] cities_array = cities.toArray(new City[cities.size()]); 
			ct.setCities(cities_array);
		}*/
		result.addAll(allCountries);
		return result;
	}
	
	@Transactional
	public Country findByName(String countryName) {
		Country result = new Country();
		
		result = countryDao.findByName(countryName);
		
		return result;
	}
	
	@Transactional
	public void insertNew(Country country) {
		countryDao.insertNew(country);
	}
}
