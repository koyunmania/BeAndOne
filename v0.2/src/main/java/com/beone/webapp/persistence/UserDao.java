package com.beone.webapp.persistence;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityExistsException;
import javax.transaction.Transactional;

import com.beone.webapp.model.Email;
import org.hibernate.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionData;
import org.springframework.social.connect.ConnectionFactory;
import org.springframework.social.connect.ConnectionFactoryLocator;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserProfile;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao extends AbstractDao {
	private static final Logger logger = LoggerFactory.getLogger(UserDao.class);
	
	public UserDao() {
		System.out.println("UserDao created");
	}
	
	public User findByKey (int id) {
		// Start of user code special Implementation findByKey
		User result = (User)(this.localSessionFactory.getCurrentSession()
				.createQuery("from User user where user.userId=?")
                .setParameter(0, id)
                .list().get(0));
		return result;
 		// End of user code
	}
	
	public User findByUsername(String username) {
		// Start of user code special Implementation findByKey
		User result = (User)(this.localSessionFactory.getCurrentSession()
				.createQuery("from User where username=:username")
                .setParameter("username", username)
                .list().get(0));
		return result;
 		// End of user code
	}
	
	public User findByEmailAndProvider(String email, String provider) {
		// Start of user code special Implementation findByKey
		User result = (User)(this.localSessionFactory.getCurrentSession()
				.createQuery("from User where email=:email and provider=:provider")
                .setParameter("email", email)
                .setParameter("provider", provider)
                .list().get(0));
		return result;
 		// End of user code
	}
	
	public void insertNew (User user) {
		// Start of user code special Implementation insertNew
		this.localSessionFactory.getCurrentSession().saveOrUpdate(user);
 		// End of user code
	}
	
//	public void checkExistingInsertNew (User user) throws EntityExistsException {
//		Session session = this.localSessionFactory.getCurrentSession();
//		List items = session.createQuery("from User where username=:username or email=:email")
//				.setParameter("username", user.getUsername())
//				.setParameter("email", user.getEmail())
//				.list();
//		
//		if(items == null || items.size() == 0) {
//			session.saveOrUpdate(user);
//		} else {
//			throw new EntityExistsException("There is already a user with given parameters");
//		}
//	}
	
	public boolean checkExistingInsertNewFromProfile (User user) throws EntityExistsException {
		Session session = this.localSessionFactory.getCurrentSession();
		List items = session.createQuery("from User where (username=:username or email=:email) and provider=:provider")
				.setParameter("username", user.getUsername())
				.setParameter("email", user.getEmail())
				.setParameter("provider", user.getProvider())
				.list();

		boolean querySuccess=false;
		
		if(items == null || items.size() == 0) {
			//session.saveOrUpdate(user);
			user.setStatus("pending"); //setting the default value to active user as false for email verification
			session.save(user);
			querySuccess=true;
		}
		
		if(user.getExternalConnections() != null && user.getExternalConnections().size() > 0) {
			for(UserProfile pro : user.getExternalConnections()) {
				pro.setUser(user);
				session.save(pro);
			}
			querySuccess=true;
		}
		return querySuccess;
	}
	
	public void addExternalProfileToUser (User user) throws EntryDoesNotExistException {
		Session session = this.localSessionFactory.getCurrentSession();
		List items = session.createQuery("from User where (username=:username or email=:email) and provider=:provider")
				.setParameter("username", user.getUsername())
				.setParameter("email", user.getEmail())
				.setParameter("provider", user.getProvider())
				.list();
		
		if(items == null || items.size() == 1) {
			
			session.saveOrUpdate(user);
		} else {
			throw new EntryDoesNotExistException("The user does not exist");
		}
	}
	
	public List<Connection<?>> getAllExternalProfilesToUserByUserId (
			int localUserId, ConnectionFactoryLocator connectionFactoryLocator) {
		Session session = this.localSessionFactory.getCurrentSession();
		List items = session.createQuery("from UserProfile where userId=:localUserId")
				.setParameter("localUserId", localUserId)
				.list();
		
		List<Connection<?>> connections = 
				new ArrayList<Connection<?>>();
		
		for(Object pr : items) {
			UserProfile profile = (UserProfile)pr;
			ConnectionFactory<?> factory = 
					connectionFactoryLocator.getConnectionFactory(profile.getProviderId());
			
			ConnectionData data = new ConnectionData(
					profile.getProviderId(), 
					profile.getProvideruserId(),
					profile.getDisplayname(),
					profile.getProfileurl(),
					profile.getImageurl(),
					profile.getAccesstoken(), 
					profile.getSecret(),
					profile.getRefreshtoken(), 
					Long.parseLong(""+profile.getExpiretime()));
			Connection conn = factory.createConnection(data);

			connections.add(conn);
		}
		
		return connections;
	}
	
	/**
	 * Returns a list of local usernames registered with an external profile
	 * @param providerId
	 * @param providerUserId
	 * @return
	 */
	@Transactional
	public List<String> getLocalUsernamesForConnection (
			String providerId,
			String providerUserId) {
		Session session = this.localSessionFactory.getCurrentSession();
		List items = session.createQuery("from UserProfile where provideruserid=:providerUserId and providerid=:providerId")
				.setParameter("providerUserId", providerUserId)
				.setParameter("providerId", providerId)
				.list();
		
		List<String> localUsers = new ArrayList<String>();
		
		for(Object pr : items) {
			UserProfile profile = (UserProfile)pr;
			List localProfileItems = session.createQuery("from User where userId=:userId")
					.setParameter("userId", profile.getUser().getUserId())
					.list();
			for(Object loPro : localProfileItems) {
				User usr = (User)loPro;
				localUsers.add(usr.getUsername());
			}
		}
		
		return localUsers;
	}
	
	public List<User> getLocalUsersForConnection (
			String providerId,
			String providerUserId) {
		Session session = this.localSessionFactory.getCurrentSession();
		List items = session.createQuery("from UserProfile where provideruserid=:providerUserId and providerid=:providerId")
				.setParameter("providerUserId", providerUserId)
				.setParameter("providerId", providerId)
				.list();
		
		List<User> localUsers = new ArrayList<User>();
		
		for(Object pr : items) {
			UserProfile profile = (UserProfile)pr;
			List localProfileItems = session.createQuery("from User where userId=:userId")
					.setParameter("userId", profile.getUser().getUserId())
					.list();
			for(Object loPro : localProfileItems) {
				User usr = (User)loPro;
				localUsers.add(usr);
			}
		}
		
		return localUsers;
	}
	
	public void delete (User user) {
		// Start of user code special Implementation delete
		this.localSessionFactory.getCurrentSession().delete(user);
 		// End of user code
	}
	
	public void update (User user) {
		// Start of user code special Implementation update
		this.localSessionFactory.getCurrentSession().saveOrUpdate(user);
 		// End of user code
	}
	
	public Set<User> getAll () {
		// Start of user code special Implementation getAll
		Set<User> result = new HashSet<User>();
		result.addAll(this.localSessionFactory.getCurrentSession()
				.createQuery("from User user")
				.list());
		return result;
 		// End of user code
	}
	
	public User checkLoginAndReturnUser (String email, String password, String provider) {
		// Start of user code special Implementation checkLogin
		List result = this.localSessionFactory.getCurrentSession()
				.createQuery("from User user where user.email=:email and password=:password and provider=:provider")
                .setParameter("email", email)
                .setParameter("password", password)
                .setParameter("provider", provider)
                .list();
		if(result != null && result.size() > 0) {
			return (User)result.get(0);
		} else {
			return null;
		}
 		// End of user code
	}
}
