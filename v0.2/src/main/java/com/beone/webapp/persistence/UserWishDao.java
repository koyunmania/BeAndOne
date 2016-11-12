package com.beone.webapp.persistence;

import java.util.ArrayList;
import java.util.Date;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserWish;

public class UserWishDao extends AbstractDao {

	public UserWish createOrAddUserWish(UserWish userWish) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(userWish);
		return userWish;
	}

	public ArrayList<UserWish> getActiveUserWishes(User usr) {
		ArrayList<UserWish> result = new ArrayList<UserWish>();
		result.addAll(
			this.localSessionFactory.getCurrentSession()
				.createQuery("from UserWish where user=:user and isactive=true")
				.setParameter("user", usr)
				.list());
		
		return result;
	}

	public boolean deleteUserWish(UserWish userWish) {
		this.localSessionFactory.getCurrentSession().delete(userWish);
		return true;
	}

	public ArrayList<UserWish> getUserWishesOfDate(User currentUser, Date date) {
		ArrayList<UserWish> result = new ArrayList<UserWish>();
		result.addAll(
			this.localSessionFactory.getCurrentSession()
				.createQuery("from UserWish as uw inner join uw.wishDailyChecks as dc "+
						"where uw.user=:user and dc.targetDate=:targetDate")
				.setParameter("user", currentUser)
				.setParameter("targetDate", date)
				.list());
		
		return result;
	}

}
