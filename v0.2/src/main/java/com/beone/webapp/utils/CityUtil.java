package com.beone.webapp.utils;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.City;
import com.beone.webapp.services.v1.model.CityTO;

public class CityUtil {
	public static CityTO convertToTO(City ci) {
		CityTO converted = new CityTO();
		converted.setCityId(ci.getCityId());
		converted.setCityName(ci.getCityName());
//		converted.setCountry(CountryUtil.convertToTO(ci.getCountry()));
		return converted;
	}
	public static Set<CityTO> convertToTOSet(Set<City> cities){
		Set<CityTO> converted = new HashSet<CityTO>();
		for(City city: cities) {
			converted.add(convertToTO(city));
		}
		return converted;
	}
	public static City convertToModel(CityTO ci) {
		City converted = new City();
		converted.setCityId(ci.getCityId());
		converted.setCityName(ci.getCityName());
		return converted;
	}
	public static Set<City> convertToModelSet(Set<CityTO> cities) {
		Set<City> converted = new HashSet<City>();
		
		for(CityTO c : cities) {
			converted.add(convertToModel(c));
		}
		
		return converted;
	}
}