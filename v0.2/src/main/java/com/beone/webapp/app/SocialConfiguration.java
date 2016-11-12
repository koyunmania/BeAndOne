package com.beone.webapp.app;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.encrypt.Encryptors;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.connect.support.ConnectionFactoryRegistry;
import org.springframework.social.connect.web.ConnectController;
import org.springframework.social.connect.web.ProviderSignInController;
import org.springframework.social.facebook.api.Facebook;

import com.beone.webapp.controller.service.LoginService;
import com.beone.webapp.controller.service.ProfileService;
import com.beone.webapp.controller.service.UserCalendarSubCategoryService;
import com.beone.webapp.persistence.SocialUsersConnectionRepository;
import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.persistence.UserTokenDao;


/**
 * This is initialized at root-context and is responsible of social configuration
 * @author Selcuk
 *
 */
@Configuration
public class SocialConfiguration {
	private static final Logger logger = LoggerFactory.getLogger(SocialConfiguration.class);
	
	/**
	 * this is the core interface of Spring Social, it provides access to 
	 * connection factories for all the providers (e.g. Facebook, Twitter, 
	 * etc.) that you have configured for your app
	 */
	@Autowired
	private ConnectionFactoryRegistry connectionFactoryLocator;
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private UserDao usersDao;
	
	@Autowired
	private UserTokenDao userTokenDao;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private UserCalendarSubCategoryService userCalendarSubCategoryService;
	
	public ProfileService getProfileService() {
		return profileService;
	}

	public void setProfileService(ProfileService profileService) {
		this.profileService = profileService;
	}
	
	public DataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public ConnectionFactoryRegistry getConnectionFactoryLocator() {
		return connectionFactoryLocator;
	}

	public void setConnectionFactoryLocator(
			ConnectionFactoryRegistry connectionFactoryLocator) {
		this.connectionFactoryLocator = connectionFactoryLocator;
	}

	public UserDao getUsersDao() {
		return usersDao;
	}

	public void setUsersDao(UserDao usersDao) {
		this.usersDao = usersDao;
	}

	public LoginService getLoginService() {
		return loginService;
	}

	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}

	public UserCalendarSubCategoryService getUserCalendarSubCategoryService() {
		return userCalendarSubCategoryService;
	}

	public void setUserCalendarSubCategoryService(
			UserCalendarSubCategoryService userCalendarSubCategoryService) {
		this.userCalendarSubCategoryService = userCalendarSubCategoryService;
	}

	/**
	 * handles connection persistence methods across all users; 
	 * this will be a normal singleton bean in your application context
	 * @return
	 */
	@Bean
	public UsersConnectionRepository usersConnectionRepository() {
		logger.info("usersConnectionRepository is called.");
		SocialUsersConnectionRepository repository = 
				new SocialUsersConnectionRepository(
						usersDao, 
						userTokenDao,
						connectionFactoryLocator, 
						Encryptors.noOpText());
		
		SimpleConnectionSignUp signUp = new SimpleConnectionSignUp();
		signUp.setUsersDao(usersDao);
	    repository.setConnectionSignUp(signUp);
	    repository.setProfileService(profileService);
	    repository.setUserCalendarSubCategoryService(userCalendarSubCategoryService);
	    
	    return repository;
	}


	/**
	 * Handles connection persistence methods for one specific user; the 
	 * implementation bean will be request scoped, 
	 * created for logged in users of your application
	 * @return
	 */
	@Bean
	@Scope(value="request", proxyMode=ScopedProxyMode.INTERFACES)
	public ConnectionRepository connectionRepository() {
		logger.info("connectionRepository is called.");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth == null) {
			throw new IllegalStateException(
				"Unable to get a ConnectionRepository: no user signed in");
		}
		
	    return usersConnectionRepository().createConnectionRepository(auth.getName());
	}
	
	@Bean
	@Scope(value="request", proxyMode=ScopedProxyMode.INTERFACES)   
	public Facebook facebook() {
		logger.info("facebook is called.");
	    return connectionRepository().getPrimaryConnection(Facebook.class).getApi();
	}
	
	@Bean
	public ProviderSignInController providerSignInController() {
		// this controller is required to support the provider specific login url
		logger.info("providerSignInController is called.");
		SimpleSignInAdapter signInAdapter = new SimpleSignInAdapter();
		signInAdapter.setUserDao(usersDao);
		ProviderSignInController cont = new ProviderSignInController(
		    	connectionFactoryLocator, 
		    	usersConnectionRepository(), 
		    	signInAdapter);
		cont.setSignUpUrl("/login?error=noaccount&");
		cont.setPostSignInUrl("/home");
	    return cont;
	}
	
	@Bean
	public ConnectController connectController() {
		logger.info("connectController is called.");
		
		SocialUserFacebookConnectInterceptor inter = 
				new SocialUserFacebookConnectInterceptor();
		inter.setLoginService(loginService);
		
		BeOneConnectController cont = new BeOneConnectController(
				connectionFactoryLocator,
				connectionRepository(),
				usersConnectionRepository());
		cont.addInterceptor(inter);
		cont.setViewPath("/");		
		cont.setLoginService(loginService);
		
	    return cont;
	}
}
