package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarSubCategory;

public class CalendarSubCategoryDao extends AbstractDao {
	/*public Set<BeOneCalendarSubCategory> getSubcategoriesOfUserCalendars(){
		
	}*/
	public BeOneCalendarSubCategory findByKey (int subcategoryId) {
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("from BeOneCalendarSubCategory ca where ca.subcategoryId=:subcategoryId")
                .setParameter("subcategoryId", subcategoryId)
                .list();
		
		if(result.size() > 0) {
			return (BeOneCalendarSubCategory)result.get(0);
		} else {
			return null;
		}
	}
	
	/**
	 * This returns the calendar with the given calendar name.<br/>
	 * @param calendarName
	 * @return
	 */
	public BeOneCalendarSubCategory findByCalendarAndName (BeOneCalendar calendar, String subCategoryName) {
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("Select cat from BeOneCalendarSubCategory cat inner join cat.calendar cal "
						+  "where upper(cat.calendarSubCategory)=upper(:subCategoryName) and cal.calendarId=:calendarId")
                .setParameter("subCategoryName", subCategoryName)
                .setParameter("calendarId", calendar.getCalendarId())
                .list();
		if(result.size() == 1) {
			return (BeOneCalendarSubCategory)result.get(0);
		} else if(result.size() > 1) {
			return null;
		} else {
			return null;
		}
	}
	
	
	public void insertNew (BeOneCalendarSubCategory subCategory) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(subCategory);
	}
	
	public void delete (BeOneCalendarSubCategory subCategory) {
		this.localSessionFactory.getCurrentSession().delete(subCategory);
	}
	
	@SuppressWarnings("unchecked")
	public Set<BeOneCalendarSubCategory> getAll () {
		Set<BeOneCalendarSubCategory> result = new HashSet<BeOneCalendarSubCategory>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from BeOneCalendarSubCategory ca").list());
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public Set<BeOneCalendarSubCategory> getAllSorted (String sortAttribute, String sortDirection) {
		// Start of user code special Implementation getAll
		if(sortAttribute== null || sortAttribute.length() == 0) {
			sortAttribute = "calendarSubCategory";
		}
		
		if(sortDirection== null || sortDirection.length() == 0) {
			sortDirection = "ASC";
		}
		
		Set<BeOneCalendarSubCategory> result = new HashSet<BeOneCalendarSubCategory>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"from BeOneCalendarSubCategory ORDER BY calendarId ASC, "+ sortAttribute+ " " + sortDirection).list());
		return result;
 		// End of user code
	}
	
	public void update (BeOneCalendarSubCategory subCategory) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(subCategory);
	}

	public Set<BeOneCalendarSubCategory> getSubCategoriesOfCalendar(BeOneCalendar calendar) {
		Set<BeOneCalendarSubCategory> result = new HashSet<BeOneCalendarSubCategory>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"select cat from BeOneCalendarSubCategory cat inner join cat.calendar cal "
				+ "where cal.calendarId=:calendarId "
				+ "ORDER BY cat.calendarSubCategory")
			.setParameter("calendarId", calendar.getCalendarId())
			.list());
		return result;
	}
}
