package com.beone.webapp.persistence;

import java.util.List;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserToken;



public class UserTokenDao extends AbstractDao
{
	private static final Logger logger = LoggerFactory.getLogger(UserTokenDao.class);
	
	@Transactional
	public void insertNew (UserToken token) {
		// Start of user code special Implementation insertNew
		this.localSessionFactory.getCurrentSession().saveOrUpdate(token);
 		// End of user code
	}
	
	public void delete (UserToken token) {
		// Start of user code special Implementation delete
		this.localSessionFactory.getCurrentSession().delete(token);
 		// End of user code
	}
	
	public void update (UserToken token) {
		// Start of user code special Implementation update
		this.localSessionFactory.getCurrentSession().saveOrUpdate(token);
 		// End of user code
	}
	
	/**
	 * Retrieves the registered user from db if the given token is valid
	 * @param token the token string for the authentication
	 * @return either null or the user for which the token is registered
	 */
	public User getUserByToken (UserToken token) {
		// Start of user code special Implementation checkLogin
		@SuppressWarnings("rawtypes")
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("from UserToken where token=:token")
                .setParameter("token", token.getToken())
                .list();
		if(result != null && result.size() > 0) {
			UserToken savedToken = (UserToken)result.get(0);
			return savedToken.getUser();
		} else {
			return null;
		}
		
 		// End of user code
	}
	
	public boolean checkTokenLogin (UserToken token) {
		// Start of user code special Implementation checkLogin
		@SuppressWarnings("rawtypes")
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("from UserToken where token=:token")
                .setParameter("token", token.getToken())
                .list();
		return (result != null && result.size() > 0);
 		// End of user code
	}

	public boolean getUserByTokenAndUser(UserToken token) {
		//Start of mail verification based on token
		@SuppressWarnings("rawtypes")
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("from UserToken where token=:token and userid=:userid")
				.setParameter("token", token.getToken())
				.setParameter("userid",token.getUser().getUserId())
				.list();
		return (result != null && result.size() > 0);
		// End of user code
	}
}
