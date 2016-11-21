package com.beone.webapp.controller.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserExperience;
import com.beone.webapp.persistence.UserExperienceDao;

public class ExperienceService {
	
	@Autowired
	private UserExperienceDao userExperienceDao;

	public UserExperienceDao getUserExperienceDao() {
		return userExperienceDao;
	}

	public void setUserExperienceDao(UserExperienceDao userExperienceDao) {
		this.userExperienceDao = userExperienceDao;
	}

	@Transactional
	public UserExperience createOrAddUserExperience(UserExperience userExperience) {
		return userExperienceDao.createOrAddUserExperience(userExperience);
	}

	public ArrayList<UserExperience> getLast10UserExperiences(User usr) {
		return userExperienceDao.getLast10UserExperiences(usr);
	}

	public boolean deleteUserExperience(User currentUser, int experienceId) {
		return userExperienceDao.deleteUserExperience(currentUser, experienceId);
	}

	public ArrayList<UserExperience> getLast10UserExperiencesOfDate(
			User currentUser, String date) {
		return userExperienceDao.getLast10UserExperiencesOfDate(currentUser, date);
	}
	public UserExperience getUserExperienceById(User currentUser, int id) {
		return userExperienceDao.getUserExperienceById(currentUser, id);
	}
}
