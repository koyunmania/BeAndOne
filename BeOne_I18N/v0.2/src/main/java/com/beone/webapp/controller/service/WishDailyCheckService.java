package com.beone.webapp.controller.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.beone.webapp.model.UserWish;
import com.beone.webapp.model.UserWishDailyCheck;
import com.beone.webapp.model.WishCheckStatus;
import com.beone.webapp.persistence.WishDailyCheckDao;

public class WishDailyCheckService {
	private static final Logger logger = LoggerFactory.getLogger(WishDailyCheckService.class);
	
	@Autowired
	private WishDailyCheckDao checkDao;

	public WishDailyCheckDao getCheckDao() {
		return checkDao;
	}

	public void setCheckDao(WishDailyCheckDao checkDao) {
		this.checkDao = checkDao;
	}

	public void addDailyCheckForWish(UserWish userWish) {
		UserWishDailyCheck check = new UserWishDailyCheck();
		check.setWish(userWish);
		check.setTargetDate(userWish.getCreatedAt());
		check.setCheckStatus(WishCheckStatus.NOT_REALIZED);
		
		checkDao.createOrUpdateWishDailyCheck(check);
	}
	

}
