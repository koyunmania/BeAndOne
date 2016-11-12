package com.beone.webapp.utils;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.Country;
import com.beone.webapp.services.v1.model.CountryTO;

public class CountryUtil {
	public static CountryTO convertToTO(Country co) {
		if(co == null) {
			return null;
		} else {
			CountryTO converted = new CountryTO();
			converted.setCities(CityUtil.convertToTOSet(co.getCities()));
			converted.setCountryId(co.getCountryId());
			converted.setCountryName(co.getCountryName());
			return converted;
		}
	}
	public static Set<CountryTO> convertToTOSet(Set<Country> countries) {
		Set<CountryTO> converted = new HashSet<CountryTO>();
		for(Country country: countries) {
			converted.add(convertToTO(country));
		}
		return converted;
	}
	public static Country convertToModel(CountryTO co) {
		Country converted = new Country();
		converted.setCities(CityUtil.convertToModelSet(co.getCities()));
		converted.setCountryId(co.getCountryId());
		converted.setCountryName(co.getCountryName());
		return converted;
	}
}