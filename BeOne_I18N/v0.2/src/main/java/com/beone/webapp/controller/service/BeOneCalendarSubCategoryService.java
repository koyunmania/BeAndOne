package com.beone.webapp.controller.service;

import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.persistence.CalendarSubCategoryDao;

public class BeOneCalendarSubCategoryService {
	private static final Logger logger = LoggerFactory.getLogger(BeOneCalendarSubCategoryService.class);

	@Autowired
	private CalendarSubCategoryDao calendarSubCategoryDao;

	public CalendarSubCategoryDao getCalendarSubCategoryDao() {
		return calendarSubCategoryDao;
	}
	public void setCalendarSubCategoryDao(CalendarSubCategoryDao calendarSubCategoryDao) {
		this.calendarSubCategoryDao = calendarSubCategoryDao;
	}

	@Transactional
	public BeOneCalendarSubCategory getSubCategoryById(int subCategoryId){
		BeOneCalendarSubCategory subCat = calendarSubCategoryDao.findByKey(subCategoryId);
		return subCat;
	}
	
	@Transactional
	public void addSubCategoryIfNotExists(BeOneCalendarSubCategory subCategory) {
		BeOneCalendarSubCategory existingSubCategory =
				calendarSubCategoryDao.findByCalendarAndName(subCategory.getCalendar(), subCategory.getCalendarSubCategory());
		if(existingSubCategory == null) {
			logger.debug("The calendar subCategory does not exist, creating it.");
			calendarSubCategoryDao.insertNew(subCategory);
		} else {
			logger.debug("Calendar subCategory already exists.");
		}
	}
	 
	@Transactional
	public Set<BeOneCalendarSubCategory> getAllSubCategoriesOfCalendar(BeOneCalendar calendar) {
		Set<BeOneCalendarSubCategory> allSubCategories = calendarSubCategoryDao.getSubCategoriesOfCalendar(calendar);
		return allSubCategories;
	}
	
	/* @Transactional
	public Set<BeOneCalendarSubCategory> getSubcategoriesOfUserCalendars() {
		Set<BeOneCalendarSubCategory> allSubCategories = new HashSet<BeOneCalendarSubCategory>();
		// calendarSubCategoryDao.getSubcategoriesOfUserCalendars();
		return allSubCategories;
	} */
	
	@Transactional
	public Set<BeOneCalendarSubCategory> getAllSubCategories(){
		Set<BeOneCalendarSubCategory> allSubCategories = calendarSubCategoryDao.getAll();
		return allSubCategories;
	}
	
	@Transactional
	public BeOneCalendarSubCategory getSubCategoryByCalendarAndName(BeOneCalendarSubCategory subCategory) {
		BeOneCalendarSubCategory existingSubCategory =
				calendarSubCategoryDao.findByCalendarAndName(subCategory.getCalendar(), subCategory.getCalendarSubCategory());
		return existingSubCategory;
	}
}
