package com.beone.webapp.persistence;

import java.util.ArrayList;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserWishDailyCheck;

public class WishDailyCheckDao extends AbstractDao {

	public UserWishDailyCheck createOrUpdateWishDailyCheck(UserWishDailyCheck userWishCheck) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(userWishCheck);
		return userWishCheck;
	}

	public ArrayList<UserWishDailyCheck> getActiveUserWishes(User usr) {
		ArrayList<UserWishDailyCheck> result = new ArrayList<UserWishDailyCheck>();
		result.addAll(
			this.localSessionFactory.getCurrentSession()
				.createQuery("from UserWishDailyCheck where userid=:userid and isactive=true")
				.setParameter("userid", usr.getUserId())
				.list());
		
		return result;
	}

	public boolean deleteWishDailyCheck(UserWishDailyCheck userWishCheck) {
		this.localSessionFactory.getCurrentSession().delete(userWishCheck);
		return true;
	}

	public ArrayList<UserWishDailyCheck> getUserWishChecksOfDate(User currentUser, String date) {
		ArrayList<UserWishDailyCheck> result = new ArrayList<UserWishDailyCheck>();
		result.addAll(
			this.localSessionFactory.getCurrentSession()
				.createQuery("from UserWish as uw inner join UserWishDailyCheck dc on dc.userwishid=uw.userwishid"+
						"where uw.userid=:userid and dc.targetDate=:targetDate")
				.setParameter("userid", currentUser.getUserId())
				.setParameter("targetDate", date)
				.list());
		
		return result;
	}

}
