package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.Country;

public class CountryDao extends AbstractDao
{
	@SuppressWarnings("unchecked")
	public Country findByKey (int id) {
		List<Country> result = (List<Country>)this.localSessionFactory.getCurrentSession()
				.createQuery("from Country co where co.countryId=?")
                .setParameter(0, id)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	public Country findByName (String countryName) {
		List<Country> result = (List<Country>)this.localSessionFactory.getCurrentSession()
				.createQuery("from Country co where co.countryName=?")
                .setParameter(0, countryName)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
	
	public void insertNew (Country country) {
		this.localSessionFactory.getCurrentSession().save(country);
	}
	
	public void delete (Country country) {
		this.localSessionFactory.getCurrentSession().delete(country);
	}
	
	public Set<Country> getAll () {
		Set<Country> result = new HashSet<Country>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from Country co").list());
		return result;
	}
	
	public Set<Country> getAllSorted (String sortAttribute, String sortDirection) {
		if(sortAttribute== null || sortAttribute.length() == 0) {
			sortAttribute = "countryName";
		}
		
		if(sortDirection== null || sortDirection.length() == 0) {
			sortDirection = "ASC";
		}
		
		Set<Country> result = new HashSet<Country>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"from Country ORDER BY "+ sortAttribute+ " " + sortDirection).list());
		return result;
	}
	
	public void update (Country country) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(country);
	}
}
