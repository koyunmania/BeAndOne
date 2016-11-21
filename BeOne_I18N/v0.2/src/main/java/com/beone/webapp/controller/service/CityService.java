package com.beone.webapp.controller.service;

import java.util.ArrayList;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.City;
import com.beone.webapp.model.Country;
import com.beone.webapp.persistence.CityDao;
import com.beone.webapp.persistence.CountryDao;

public class CityService {
	private static final Logger logger = LoggerFactory.getLogger(LoginService.class);
	
	@Autowired
	private CityDao cityDao;
	
	@Autowired
	private CountryDao countryDao;

	public CityDao getCityDao() {
		return cityDao;
	}

	public void setCityDao(CityDao cityDao) {
		this.cityDao = cityDao;
	}
	
	public CountryDao getCountryDao() {
		return countryDao;
	}

	public void setCountryDao(CountryDao countryDao) {
		this.countryDao = countryDao;
	}

	@Transactional
	public ArrayList<City> getAllCities() {
		ArrayList<City> result = new ArrayList<City>();
		
		result.addAll(cityDao.getAll());
		
		return result;
	}
	
    @Transactional
    public ArrayList<City> getAllCitiesWithCountries() {
            ArrayList<City> result = new ArrayList<City>();

            Set<Country> allCountries = countryDao.getAll();

            for(Country ct : allCountries) {
            		Set<City> cities = cityDao.getCitiesOfCountry(ct);
                    for(City ci : cities) {
                            ci.setCountry(ct);
                            result.add(ci);
                    }
            }

            return result;
    }
	
	@Transactional
	public Set<City> getCitiesOfCountry(Country country) {
		Set<City> result = cityDao.getCitiesOfCountry(country);
		
		return result;
	}
	
	@Transactional
	public void insertNew(City city) {
		cityDao.insertNew(city);
	}
	
	@Transactional
	public City findByName(String cityName){
		City result = cityDao.findByName(cityName);
		return result;
	}
}
