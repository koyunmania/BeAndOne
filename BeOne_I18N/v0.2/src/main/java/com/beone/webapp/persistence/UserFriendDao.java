package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserFriend;


public class UserFriendDao extends AbstractDao {
	
	public UserFriend findByKey (int userFriendId)
	{
		// Start of user code special Implementation findByKey
		UserFriend result = (UserFriend)this.localSessionFactory.getCurrentSession()
				.createQuery("from UserFriend where userFriendId=?")
                .setParameter(0, userFriendId)
                .list().get(0);
		return result;
 		// End of user code
	}
	
	public User findUserByKey (int userFriendId)
	{
		// Start of user code special Implementation findByKey
		User friend = (User)this.localSessionFactory.getCurrentSession()
				.createQuery("from User where userId=?")
                .setParameter(0, userFriendId)
                .list().get(0);
		return friend;
 		// End of user code
	}
	
	public void insertNew (UserFriend userFriend)
	{
		// Start of user code special Implementation insertNew
		this.localSessionFactory.getCurrentSession().saveOrUpdate(userFriend);
 		// End of user code
	}
	
	public void delete (UserFriend userFriend)
	{
		// Start of user code special Implementation delete
		this.localSessionFactory.getCurrentSession().delete(userFriend);
 		// End of user code
	}
	
	public Set<UserFriend> getAll ()
	{
		// Start of user code special Implementation getAll
		Set<UserFriend> result = new HashSet<UserFriend>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from UserFriend").list());
		return result;
 		// End of user code
	}
	
	public void update (UserFriend userFriend)
	{
		// Start of user code special Implementation update
		this.localSessionFactory.getCurrentSession().saveOrUpdate(userFriend);
 		// End of user code
	}
}
