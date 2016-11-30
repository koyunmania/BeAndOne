package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserCalendarSubCategory;

public class UserCalendarSubCategoryDao extends AbstractDao{
	public Set<UserCalendarSubCategory> getAll(User user){
		Set<UserCalendarSubCategory> result = new HashSet<UserCalendarSubCategory>();
		result.addAll(this.localSessionFactory.getCurrentSession()
				.createQuery("from UserCalendarSubCategory where userid=:userid ")
				.setParameter("userid", user.getUserId())
				.list());
		return result;
	}
	
	public void addUserCalendarSubCategory(UserCalendarSubCategory ucsc){
		this.localSessionFactory.getCurrentSession().saveOrUpdate(ucsc);
	}
	public void deleteUserCalendarSubCategory(UserCalendarSubCategory ucsc){
		this.localSessionFactory.getCurrentSession().delete(ucsc);
	}

	public void assignAllSubcategoriesToUser(User user) {
		this.localSessionFactory.getCurrentSession()
			.createSQLQuery("insert into UserCalendarSubCategories "
					+ "("
					+ "select u.userid, s.subcategoryid "
					+ "from users u "
					+ "cross join beonecalendarsubcategories s "
					+ "where u.userId=:userId"
					+ ")")
				.setParameter("userId", user.getUserId())
				.executeUpdate();
	}
}