package com.beone.webapp.utils;

import com.beone.webapp.model.User;
import com.beone.webapp.services.v1.model.UserTO;

public class BeOneUserUtil {

	public static UserTO convertToTO(User user) {
		UserTO converted = new UserTO();
		
		converted.setBirthday(user.getBirthday());
		// convertion assures the existence of City+Country objects as well as their IDs in the result
		converted.setCurrentCity(CityUtil.convertToTO(user.getCurrentCity()));
		converted.setCurrentCountry(CountryUtil.convertToTO(user.getCurrentCountry()));
		if(user.getCurrentCity() != null)
			converted.setCurrentCityId(user.getCurrentCity().getCityId());
		if(user.getCurrentCountry() != null)
			converted.setCurrentCountryId(user.getCurrentCountry().getCountryId());
		converted.setEmail(user.getEmail());
		converted.setFirstname(user.getFirstname());
		converted.setGender(user.getGender());
		converted.setLastname(user.getLastname());
		converted.setUsername(user.getUsername());
		
		return converted;
	}
}
