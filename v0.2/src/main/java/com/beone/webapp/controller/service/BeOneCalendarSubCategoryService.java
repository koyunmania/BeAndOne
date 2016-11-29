package com.beone.webapp.controller.service;

import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.BeOneCalendarSubCategoryTranslation;
import com.beone.webapp.model.BeOneLanguage;
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
	public BeOneCalendarSubCategory addSubCategoryIfNotExists(
			BeOneCalendarSubCategory subCategory, 
			String subCatName) {
		
		BeOneCalendarSubCategory existingSubCategory =
				calendarSubCategoryDao.findByCalendarAndName(
						subCategory.getCalendar(), 
						subCatName);
		
		if(existingSubCategory == null) {
			logger.debug("The calendar subCategory does not exist, creating it.");
			calendarSubCategoryDao.insertNew(subCategory);
			return subCategory;
		} else {
			logger.debug("Calendar subCategory already exists.");
			return existingSubCategory;
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
	public BeOneCalendarSubCategory getSubCategoryByCalendarAndName(BeOneCalendar calendar, String subCategoryName) {
		BeOneCalendarSubCategory existingSubCategory =
				calendarSubCategoryDao.findByCalendarAndName(
						calendar, 
						subCategoryName);
		return existingSubCategory;
	}
	
	@Transactional
	public void addTranslationIfNotExists(
			BeOneCalendarSubCategoryTranslation subCatTrans) {
		
		BeOneCalendarSubCategoryTranslation existingSubCategoryTrans =
				calendarSubCategoryDao.getSubCategoryTranslation(subCatTrans);
		
		if(existingSubCategoryTrans != null) {
			//
		} else {
			calendarSubCategoryDao.insertNewTranslation(subCatTrans);
		}
	}
}
