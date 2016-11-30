package com.beone.webapp.controller.service;

import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserWish;
import com.beone.webapp.persistence.UserWishDao;

public class WishService {
	
	private static final Logger logger = LoggerFactory.getLogger(WishService.class);
	
	@Autowired
	private UserWishDao userWishDao;

	public UserWishDao getUserWishDao() {
		return userWishDao;
	}

	public void setUserWishDao(UserWishDao userWishDao) {
		this.userWishDao = userWishDao;
	}

	public UserWish createOrAddUserWish(UserWish userWish,
			HttpServletRequest request, HttpServletResponse response) {
		return userWishDao.createOrAddUserWish(userWish);
	}

	public ArrayList<UserWish> getActiveUserWishes(User usr) {
		return userWishDao.getActiveUserWishes(usr);
	}

	public boolean deleteUserWish(UserWish userWish,
			HttpServletRequest request, HttpServletResponse response) {
		return userWishDao.deleteUserWish(userWish);
	}

	public ArrayList<UserWish> getUserWishesOfDate(
			User currentUser, Date date) {
		return userWishDao.getUserWishesOfDate(currentUser, date);
	}

}
