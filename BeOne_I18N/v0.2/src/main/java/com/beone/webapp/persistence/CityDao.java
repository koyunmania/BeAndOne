package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.City;
import com.beone.webapp.model.Country;

public class CityDao extends AbstractDao
{
	public City findByKey (int cityId) {
		List<City> result = (List<City>)this.localSessionFactory.getCurrentSession()
				.createQuery("from City cit where cit.cityId=:cityId")
                .setParameter("cityId", cityId)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
	
	public City findByName (String cityName) {
		List<City> result = (List<City>)this.localSessionFactory.getCurrentSession()
				.createQuery("from City cit where cit.cityName=:cityName")
                .setParameter("cityName", cityName)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
	
	public void insertNew (City city) {
		// Start of user code special Implementation insertNew
		this.localSessionFactory.getCurrentSession().saveOrUpdate(city);
 		// End of user code
	}
	
	public void delete (City city) {
		// Start of user code special Implementation delete
		this.localSessionFactory.getCurrentSession().delete(city);
 		// End of user code
	}
	
	public Set<City> getAll () {
		// Start of user code special Implementation getAll
		Set<City> result = new HashSet<City>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from City cit").list());
		return result;
 		// End of user code
	}
	
	public Set<City> getAllSorted (String sortAttribute, String sortDirection) {
		// Start of user code special Implementation getAll
		if(sortAttribute== null || sortAttribute.length() == 0) {
			sortAttribute = "cityName";
		}
		
		if(sortDirection== null || sortDirection.length() == 0) {
			sortDirection = "ASC";
		}
		
		Set<City> result = new HashSet<City>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"from City ORDER BY "+ sortAttribute+ " " + sortDirection).list());
		return result;
 		// End of user code
	}
	
	public void update (City city) {
		// Start of user code special Implementation update
		this.localSessionFactory.getCurrentSession().saveOrUpdate(city);
 		// End of user code
	}
	
	public Set<City> getCitiesOfCountry (Country country) {
		// Start of user code special Implementation getCitiesOfCountry
		Set<City> result = new HashSet<City>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from City cit where cit.country.countryId=:countryId") //from City cit where cit.country.countryId=:countryId
				.setParameter("countryId", country.getCountryId())
				.list());
		return result;
 		// End of user code
	}
}
