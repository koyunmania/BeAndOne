package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserCalendarSubCategory;

public class UserCalendarSubCategoryDao extends AbstractDao{
	
	@SuppressWarnings("unchecked")
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

	public UserCalendarSubCategory findByUserAndSubcategory(
			User user,
			BeOneCalendarSubCategory beOneCalendarSubCategory) {
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("select usub from UserCalendarSubCategory usub "
						+ "inner join usub.user usr "
						+ "inner join usub.beOneCalendarSubCategory subCat "
						+ "where usr.userId=:userId and subCat.subcategoryId=:subcategoryId")
                .setParameter("userId", user.getUserId())
                .setParameter("subcategoryId", beOneCalendarSubCategory.getSubcategoryId())
                .list();
		if(result.size() == 1) {
			return (UserCalendarSubCategory)result.get(0);
		} else if(result.size() > 1) {
			return null;
		} else {
			return null;
		}
	}
}