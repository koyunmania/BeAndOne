package com.beone.webapp.controller.service;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.beone.webapp.model.CoverPhoto;
import com.beone.webapp.persistence.CoverPhotoDao;

public class CoverPhotoService {
	private static final Logger logger = LoggerFactory.getLogger(CoverPhotoService.class);
	
	@Autowired
	private CoverPhotoDao coverPhotoDao;

	public CoverPhotoDao getCoverPhotoDao() {
		return coverPhotoDao;
	}

	public void setCoverPhotoDao(CoverPhotoDao coverPhotoDao) {
		this.coverPhotoDao = coverPhotoDao;
	}
	
	@Transactional
	public CoverPhoto getCoverPhotoOfDay(String day) {
		CoverPhoto existing = coverPhotoDao.findByDisplayDay(day);
		if(existing == null) {
			existing = new CoverPhoto();
			
			existing.setIsActive(true);
			existing.setPhotoDisplayDay(day);
			existing.setPhotoFileName("default.jpg");
		}
		
		return existing;
	}
}
