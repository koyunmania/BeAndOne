package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.UserCalendar;
import com.beone.webapp.model.User;

public class CalendarDao extends AbstractDao {
	
	public BeOneCalendar findByKey (int calendarId) {
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("from BeOneCalendar ca where ca.calendarId=:calendarId")
                .setParameter("calendarId", calendarId)
                .list();
		
		if(result.size() > 0) {
			return (BeOneCalendar)result.get(0);
		} else {
			return null;
		}
	}
	
	/**
	 * This returns the calendar with the given calendar name.<br/>
	 * @param calendarName
	 * @return
	 */
	public BeOneCalendar findByName (String calendarName) {
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("from BeOneCalendar ca where upper(ca.calendarName)=upper(:calendarName)")
                .setParameter("calendarName", calendarName)
                .list();
		if(result.size() == 1) {
			return (BeOneCalendar)result.get(0);
		} else if(result.size() > 1) {
			return null;
		} else {
			return null;
		}
	}
	
//	/**
//	 * This returns the calendar item with the given calendar name and category<br/>
//	 * There has to be a single calendar with the given name and category. Therefore, it either returns the found 
//	 * object or it returns NULL.
//	 * @param calendarName
//	 * @param category
//	 * @return
//	 */
//	public BeOneCalendar findByNameAndCategory (String calendarName, String category) {
//		List result = this.localSessionFactory.getCurrentSession()
//				.createQuery("from BeOneCalendar ca where ca.calendarName=:calendarName "
//						+ "and ca.calendarCategory=:calendarCategory")
//                .setParameter("calendarName", calendarName)
//                .setParameter("calendarCategory", category)
//                .list();
//		
//		if(result.size() == 1) {
//			return (BeOneCalendar)result.get(0);
//		} else if(result.size() > 1) {
//			return null;
//		} else {
//			return null;
//		}
//	}
	
	public void insertNew (BeOneCalendar calendar) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(calendar);
	}
	
	public void delete (BeOneCalendar calendar) {
		this.localSessionFactory.getCurrentSession().delete(calendar);
	}
	
	@SuppressWarnings("unchecked")
	public Set<BeOneCalendar> getAll () {
		Set<BeOneCalendar> result = new HashSet<BeOneCalendar>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from BeOneCalendar ca").list());
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public Set<BeOneCalendar> getAllSorted (String sortAttribute, String sortDirection) {
		// Start of user code special Implementation getAll
		if(sortAttribute== null || sortAttribute.length() == 0) {
			sortAttribute = "calendarName";
		}
		
		if(sortDirection== null || sortDirection.length() == 0) {
			sortDirection = "ASC";
		}
		
		Set<BeOneCalendar> result = new HashSet<BeOneCalendar>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"from BeOneCalendar ORDER BY "+ sortAttribute+ " " + sortDirection).list());
		return result;
 		// End of user code
	}
	
	public void update (BeOneCalendar calendar) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(calendar);
	}

	public Set<UserCalendar> getAllUserCalendars(User user) {
		Set<UserCalendar> result = new HashSet<UserCalendar>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"select cal from UserCalendar regs inner join regs.calendar cal "
				+ "where regs.user.userId=:userid "
				+ "ORDER BY cal.calendarName")
			.setParameter("userid", user.getUserId())
			.list());
		return result;
	}
	
	public void addUserCalendar(UserCalendar userCalendar) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(userCalendar);
	}
	
	public void deleteUserCalendar(User user, int calendarId) {
		UserCalendar userCalendar = getUserCalendarById(user.getUserId(), calendarId);
		this.localSessionFactory.getCurrentSession().delete(userCalendar);
	}
	
	public UserCalendar getUserCalendarById(int userId, int calendarId){
		UserCalendar result = (UserCalendar)this.localSessionFactory.getCurrentSession().createQuery("from UserCalendar ca where ca.calendar.calendarId=:calendarId and ca.user.userId=:userId")
				.setParameter("userId", userId)
				.setParameter("calendarId", calendarId)
				.list().get(0); 
		return result;
	}
	
	public BeOneCalendar getCalendarById(int calendarId){
		BeOneCalendar result = (BeOneCalendar) this.localSessionFactory.getCurrentSession().createQuery("from BeOneCalendar ca where ca.calendarId=:calendarId")
				.setParameter("calendarId", calendarId)
				.list().get(0); 
		return result;	
		}
}
