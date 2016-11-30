package com.beone.webapp.controller.service;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserCalendarSubCategory;
import com.beone.webapp.persistence.UserCalendarSubCategoryDao;

public class UserCalendarSubCategoryService {
	@Autowired
	private UserCalendarSubCategoryDao userCalendarSubCategoryDao; 
	
	public UserCalendarSubCategoryDao getUserCalendarSubCategoryDao() {
		return userCalendarSubCategoryDao;
	}
	public void setUserCalendarSubCategoryDao(UserCalendarSubCategoryDao userCalendarSubCategoryDao) {
		this.userCalendarSubCategoryDao = userCalendarSubCategoryDao;
	}
	
	@Transactional
	public Set<UserCalendarSubCategory> getAllUserCalendarSubCategories(User user){
		Set<UserCalendarSubCategory> allUserCalendarSubCategories = new HashSet<UserCalendarSubCategory>();
		allUserCalendarSubCategories = userCalendarSubCategoryDao.getAll(user);
		return allUserCalendarSubCategories;
	}
	@Transactional
	public void addUserCalendarSubCategory(UserCalendarSubCategory ucsc){
		userCalendarSubCategoryDao.addUserCalendarSubCategory(ucsc);
	}
	public void deleteUserCalendarSubCategory(UserCalendarSubCategory ucsc){
		userCalendarSubCategoryDao.deleteUserCalendarSubCategory(ucsc);
	}
	
	@Transactional
	public void assignAllSubcategoriesToUser(User user) {
		userCalendarSubCategoryDao.assignAllSubcategoriesToUser(user);
	}
	
	@Transactional
	public UserCalendarSubCategory getUserSubCategoryIfExists(
			UserCalendarSubCategory sub) {
		return userCalendarSubCategoryDao.findByUserAndSubcategory(sub.getUser(), sub.getBeOneCalendarSubCategory());
	}
}