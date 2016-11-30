package com.beone.webapp.persistence;

import java.util.List;

import com.beone.webapp.model.Question;
import com.beone.webapp.model.RegisterToken;
import com.beone.webapp.model.User;

public class RegisterTokenDao extends AbstractDao {

	public void insertNew(RegisterToken registerToken) {
		this.localSessionFactory.getCurrentSession().save(registerToken);
	}

	@SuppressWarnings("unchecked")
	public User getUserByToken(String registrationToken) {
		List<User> result = (List<User>)this.localSessionFactory.getCurrentSession()
				.createQuery("select usr from RegisterToken tk "
						+ "inner join tk.user usr "
						+ "where "
						+ "tk.token=:token")
                .setParameter("token", registrationToken)
                .list();
		
		if(result.size() > 0) {
			return (User)result.get(0);
		} else {
			return null;
		}
	}

	public void update(RegisterToken registerToken) {
		this.localSessionFactory.getCurrentSession().update(registerToken);
	}
}
