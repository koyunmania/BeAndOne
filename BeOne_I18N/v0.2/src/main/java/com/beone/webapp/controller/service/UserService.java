package com.beone.webapp.controller.service;

//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.City;
import com.beone.webapp.model.Country;
import com.beone.webapp.model.User;
import com.beone.webapp.persistence.CityDao;
import com.beone.webapp.persistence.CountryDao;
import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.utils.GeneralUtils;

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
	
	@Transactional
	public void fetchUserLocale(User user)
	{				
		String userLocale = (GeneralUtils.isNotBlankOrNull(user.getUsername())) ? userDao.findUserLocaleByUsername(user.getUsername()) : userDao.findUserLocaleByUserEmail(user.getEmail(), user.getPassword());
		if(GeneralUtils.isNotBlankOrNull(userLocale))
		{			
			user.setLocale(userLocale);		
		}
	}
	
	@Transactional
	public void updateUserLocale(User user)
	{	
		if(GeneralUtils.isNotBlankOrNull(user.getUsername()))
		{			
			userDao.updateUserLocale(user);		
		}
	}
}