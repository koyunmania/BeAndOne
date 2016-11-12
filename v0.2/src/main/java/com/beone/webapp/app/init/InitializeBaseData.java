package com.beone.webapp.app.init;

import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.beone.webapp.model.User;
import com.beone.webapp.persistence.NewsFeedDao;
import com.beone.webapp.persistence.ProfileEntryDao;
import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.persistence.UserFriendDao;
import com.beone.webapp.persistence.UserTokenDao;

public class InitializeBaseData {
	
	public static SessionFactory sessionFactory;
	
	//@Transactional
	public static void main(String []args) {
		System.out.println("Spring initializing...");
		ApplicationContext context =
			    new FileSystemXmlApplicationContext(new String[] {
			    		"src/main/webapp/WEB-INF/spring/root-context.xml"});
		

		sessionFactory = (SessionFactory)context.getBean("localSessionFactory");
		sessionFactory.getCurrentSession().beginTransaction();
		//Session session = sessionFactory.openSession();
		//session.beginTransaction();
		
		
		NewsFeedDao newsFeedDao = (NewsFeedDao)context.getBean("newsFeedDao");
		ProfileEntryDao profileEntryDao = (ProfileEntryDao)context.getBean("profileEntryDao");
		UserDao userDao = (UserDao)context.getBean("userDao");
		UserFriendDao userFriendDao = (UserFriendDao)context.getBean("userFriendDao");
		UserTokenDao userTokenDao = (UserTokenDao)context.getBean("userTokenDao");
		
		User []users = new User[100];
		createUsers(userDao, users);
		
		sessionFactory.getCurrentSession().getTransaction().commit();
		sessionFactory.close();
		System.out.println("Spring initialized");
	}

	private static void createUsers(UserDao userDao, User[] users) {
		for(int i=1; i <= users.length; i++) {
			User usr = new User();
			usr.setBirthday("1980-01-01");
			usr.setEmail("user"+i+"@spocial.com");
			usr.setFirstname("User"+i);
			usr.setGender("Male");
			usr.setLastname("Test");
			usr.setPassword("1234");
			usr.setProvider("spocial");
			usr.setUsername("user"+i);
			users[i-1] = usr;
			userDao.insertNew(usr);
		}
	}
}
