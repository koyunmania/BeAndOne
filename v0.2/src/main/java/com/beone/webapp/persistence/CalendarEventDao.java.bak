package com.beone.webapp.persistence;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarEvent;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.UserCalendar;
import com.beone.webapp.model.UserCalendarSubCategory;

public class CalendarEventDao extends AbstractDao {
	
	@SuppressWarnings("rawtypes")
	public BeOneCalendarEvent findByKey (int eventId) {
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("from BeOneCalendarEvent ca where ca.eventId=:eventId")
                .setParameter("eventId", eventId)
                .list();
		
		if(result.size() > 0) {
			return (BeOneCalendarEvent)result.get(0);
		} else {
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<BeOneCalendarEvent> findEventsByCalendarName (String calendarName) {
		List<BeOneCalendarEvent> result = (List<BeOneCalendarEvent>)this.localSessionFactory.getCurrentSession()
				.createQuery("from BeOneCalendarEvent ev where ev.calendar.calendarName=:calendarName")
                .setParameter("calendarName", calendarName)
                .list();
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<BeOneCalendarEvent> findEventsByCalendarNameAndCategory (String calendarName, String category) {
		List<BeOneCalendarEvent> result = (List<BeOneCalendarEvent>)this.localSessionFactory.getCurrentSession()
				.createQuery("from BeOneCalendarEvent ca where ca.calendarName=:calendarName "
						+ "and ca.calendarCategory=:calendarCategory")
                .setParameter("calendarName", calendarName)
                .setParameter("calendarCategory", category)
                .list();

		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<BeOneCalendarEvent> findEventsOfCalendar (BeOneCalendar calendar) {
		List<BeOneCalendarEvent> result = (List<BeOneCalendarEvent>)this.localSessionFactory.getCurrentSession()
				.createQuery("from BeOneCalendarEvent ca where ca.calendar=:calendar")
                .setParameter("calendar", calendar)
                .list();

		return result;
	}
	
	@SuppressWarnings("unchecked")
	public BeOneCalendarEvent findBySubcategoryAndEventName(BeOneCalendarSubCategory subCategory, String eventName) {
		List<BeOneCalendarEvent> result = (List<BeOneCalendarEvent>)this.localSessionFactory.getCurrentSession()
				.createQuery("from BeOneCalendarEvent ev where ev.subCategory=:subCategory and upper(ev.eventName)=upper(:eventName)")
                .setParameter("subCategory", subCategory)
                .setParameter("eventName", eventName)
                .list();

		if(result.size() > 0) {
			return (BeOneCalendarEvent)result.get(0);
		} else {
			return null;
		}
	}
	
	public void insertNew (BeOneCalendarEvent calendar) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(calendar);
	}
	
	public void delete (BeOneCalendarEvent calendar) {
		this.localSessionFactory.getCurrentSession().delete(calendar);
	}
	
	@SuppressWarnings("unchecked")
	public Set<BeOneCalendarEvent> getAll () {
		Set<BeOneCalendarEvent> result = new HashSet<BeOneCalendarEvent>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from BeOneCalendar ca").list());
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public Set<BeOneCalendarEvent> getAllSorted (String sortAttribute, String sortDirection) {
		// Start of user code special Implementation getAll
		if(sortAttribute== null || sortAttribute.length() == 0) {
			sortAttribute = "calendarName";
		}
		
		if(sortDirection== null || sortDirection.length() == 0) {
			sortDirection = "ASC";
		}
		
		Set<BeOneCalendarEvent> result = new HashSet<BeOneCalendarEvent>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"from BeOneCalendarEvent ORDER BY "+ sortAttribute+ " " + sortDirection).list());
		return result;
 		// End of user code
	}
	
	public void update (BeOneCalendarEvent calendar) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(calendar);
	}

	public Set<BeOneCalendarEvent> findEventsByUserId(int userId) {
		Set<BeOneCalendarEvent> result = new HashSet<BeOneCalendarEvent>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"select ev from BeOneCalendarEvent ev inner join ev.calendar cal inner join RegisteredCalendar regs "
				+ "where regs.user.userId=:userid and regs.calendar.calendarId=cal.calendarId "
				+ "ORDER BY cal.calendarName, cal.calendarCategory ")
			.setParameter("userid", userId)
			.list());
		return result;
	}
	
	public Set<BeOneCalendarEvent> findEventsByUserIdAndDate(Set<UserCalendarSubCategory> subs, String userCity, int userId, Timestamp startDate, Timestamp endDate) {
		Set<BeOneCalendarEvent> result = new HashSet<BeOneCalendarEvent>();
		
		String query = new String();
		int counter = 0;
		if(subs.size() > 0){
			query = "(";
			for(UserCalendarSubCategory sub: subs){
				counter++;
				if(counter < subs.size()){
					query = query + "subCat.subcategoryId = " + sub.getBeOneCalendarSubCategory().getSubcategoryId() + " OR ";
				} else {
					query = query + "subCat.subcategoryId = " + sub.getBeOneCalendarSubCategory().getSubcategoryId() + ") AND ";
				}
			}
			
	        result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
	            	"SELECT ev FROM BeOneCalendarEvent AS ev INNER JOIN ev.subCategory as subCat INNER JOIN subCat.calendar AS cal WHERE "
	        			+ query
	        			+ "(eventLocation = :userCity OR eventLocation = 'Universal') AND "
	        			+ "eventDate >= :eventStart AND eventDate < :eventEnd "
	        			+ "ORDER BY cal.calendarName, subCat.calendarSubCategory ")
	        			.setParameter("eventStart", startDate)
	        			.setParameter("eventEnd", endDate)
	        			.setParameter("userCity", userCity)
	        			.list());
		}
        return result;
	}
}
