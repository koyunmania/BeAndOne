package com.beone.webapp.persistence;

import java.util.ArrayList;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserExperience;

public class UserExperienceDao extends AbstractDao {

	public ArrayList<UserExperience> getLast10UserExperiences(User usr) {
		ArrayList<UserExperience> result = new ArrayList<UserExperience>();
		result.addAll(
			this.localSessionFactory.getCurrentSession()
				.createQuery("from UserExperience")
				.list());
		
		return result;
	}
	
	public UserExperience createOrAddUserExperience(UserExperience userExperience) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(userExperience);
		return userExperience;
	}

	public ArrayList<UserExperience> getLast10UserExperiencesOfDate(
			User currentUser, String date) {
		ArrayList<UserExperience> result = new ArrayList<UserExperience>();
		result.addAll(
			this.localSessionFactory.getCurrentSession()
				.createQuery("from UserExperience where userid=:userid and experiencedate=:experiencedate")
				.setParameter("userid", currentUser.getUserId())
				.setParameter("experiencedate", date)
				.list());
		/*User emptyUser = new User();
		for( int i = 0; i < result.size(); i++ ) {
			if(result.get(i) != null) {
				result.get(i).setUser(emptyUser);
			}
		}*/
		return result;
	}

	public UserExperience getUserExperienceById(User currentUser, int id) {
		UserExperience result = (UserExperience)this.localSessionFactory.getCurrentSession()
			.createQuery("from UserExperience where userexperienceid=:id and userid=:userid")
			.setParameter("id", id)
			.setParameter("userid", currentUser.getUserId())
			.list().get(0);
		User emptyUser = new User();
		result.setUser(emptyUser);
		return result;
	}

	public boolean deleteUserExperience(User currentUser, int experienceId) {
		UserExperience userExperience = getUserExperienceById(currentUser, experienceId);
		this.localSessionFactory.getCurrentSession().delete(userExperience);
		return true;
	}

}
