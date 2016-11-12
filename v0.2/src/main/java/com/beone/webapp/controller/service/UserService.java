package com.beone.webapp.controller.service;

//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import com.beone.webapp.model.City;
import com.beone.webapp.model.Country;
import com.beone.webapp.model.User;
import com.beone.webapp.persistence.CityDao;
import com.beone.webapp.persistence.CountryDao;
import com.beone.webapp.persistence.UserDao;

public class UserService {
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private CityDao cityDao;
	
	@Autowired
	private CountryDao countryDao;
	
	public UserDao getUserDao() {
		return this.userDao;
	}
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
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
	public void updateUser(User user, int cityId, int countryId){
		City foundCity = cityDao.findByKey(cityId);
		Country foundCountry = countryDao.findByKey(countryId);
		if(foundCity != null) {
			user.setCurrentCity(foundCity);
		}
		if(foundCountry != null) {
			user.setCurrentCountry(foundCountry);
		}
		userDao.update(user);
	}
}