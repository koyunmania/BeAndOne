package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.CoverPhoto;

public class CoverPhotoDao extends AbstractDao
{
	@SuppressWarnings("unchecked")
	public CoverPhoto findByKey (int photoId) {
		List<CoverPhoto> result = (List<CoverPhoto>)this.localSessionFactory.getCurrentSession()
				.createQuery("select cf from CoverPhoto cf where cf.photoId=:photoId")
                .setParameter("photoId", photoId)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	public CoverPhoto findByDisplayDay (String displayDay) {
		List<CoverPhoto> result = (List<CoverPhoto>)this.localSessionFactory.getCurrentSession()
				.createQuery("select cf from CoverPhoto cf where cf.photoDisplayDay=:displayDay")
                .setParameter("displayDay", displayDay)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
	
//	public void insertNew (Country country) {
//		this.localSessionFactory.getCurrentSession().save(country);
//	}
//	
//	public void delete (Country country) {
//		this.localSessionFactory.getCurrentSession().delete(country);
//	}
//	
//	public Set<Country> getAll () {
//		Set<Country> result = new HashSet<Country>();
//		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from Country co").list());
//		return result;
//	}
//	
//	public Set<Country> getAllSorted (String sortAttribute, String sortDirection) {
//		if(sortAttribute== null || sortAttribute.length() == 0) {
//			sortAttribute = "countryName";
//		}
//		
//		if(sortDirection== null || sortDirection.length() == 0) {
//			sortDirection = "ASC";
//		}
//		
//		Set<Country> result = new HashSet<Country>();
//		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
//			"from Country ORDER BY "+ sortAttribute+ " " + sortDirection).list());
//		return result;
//	}
//	
//	public void update (Country country) {
//		this.localSessionFactory.getCurrentSession().saveOrUpdate(country);
//	}
}
