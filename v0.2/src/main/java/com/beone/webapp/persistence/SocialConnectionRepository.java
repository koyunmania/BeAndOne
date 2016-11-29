package com.beone.webapp.persistence;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.encrypt.TextEncryptor;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.ConnectionKey;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.support.OAuth2Connection;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.UserOperations;
import org.springframework.util.MultiValueMap;

import com.beone.webapp.controller.service.ProfileService;
import com.beone.webapp.controller.service.UserCalendarSubCategoryService;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserProfile;
import com.beone.webapp.model.UserToken;
import com.beone.webapp.model.exceptions.ControllerServiceException;
import com.beone.webapp.utils.GeneralUtils;
import com.beone.webapp.utils.SecurityUtils;

/**
 * An important entry point for the social network authentication.
 * handles connection persistence methods for one specific user; 
 * the implementation bean will be request scoped, created for logged 
 * in users of your application
 * @author Selcuk
 *
 */
public class SocialConnectionRepository implements ConnectionRepository{

	private static final Logger logger = LoggerFactory.getLogger(SocialConnectionRepository.class);
	
	private UserDao usersDao;
	private UserTokenDao userTokenDao;
	
	private ProfileService profileService;
	
	private UserCalendarSubCategoryService userCalendarSubCategoryService;
	
	public ProfileService getProfileService() {
		return profileService;
	}

	public void setProfileService(ProfileService profileService) {
		this.profileService = profileService;
	}
	
	public UserCalendarSubCategoryService getUserCalendarSubCategoryService() {
		return userCalendarSubCategoryService;
	}

	public void setUserCalendarSubCategoryService(
			UserCalendarSubCategoryService userCalendarSubCategoryService) {
		this.userCalendarSubCategoryService = userCalendarSubCategoryService;
	}

	private ConnectionFactoryLocator connectionFactoryLocator;
	private TextEncryptor textEncryptor;
	private String remoteUserId;
	private String localUserId;
	
	public SocialConnectionRepository(
			String localUserId,
			UserDao usersDao, 
			UserTokenDao userTokenDao,
			ConnectionFactoryLocator connectionFactoryLocator, 
			TextEncryptor textEncryptor) {
		this.usersDao = usersDao;
		this.userTokenDao = userTokenDao;
		this.connectionFactoryLocator = connectionFactoryLocator;
		this.textEncryptor = textEncryptor;
		this.localUserId = localUserId;
	}
	
	@Override
	public MultiValueMap<String, Connection<?>> findAllConnections() {
		logger.info("findAllConnections called");
		return null;
	}

	@Override
	public List<Connection<?>> findConnections(String providerId) {
		logger.info("findConnections called");
		int i_localUserId = Integer.parseInt(localUserId);
		List<Connection<?>> con2 = usersDao.getAllExternalProfilesToUserByUserId(i_localUserId, connectionFactoryLocator);
		logger.debug("Number of connections for the provider and user(from context): " + con2.size());
		return con2;
		//return connections;
	}

	@Override
	public <A> List<Connection<A>> findConnections(Class<A> apiType) {
		logger.info("findConnections(Class<A> apiType) called");
		return null;
	}

	@Override
	public MultiValueMap<String, Connection<?>> findConnectionsToUsers(
			MultiValueMap<String, String> providerUserIds) {
		logger.info("findConnectionsToUsers called");
		return null;
	}

	@Override
	public Connection<?> getConnection(ConnectionKey connectionKey) {
		logger.info("getConnection called");
		return null;
	}

	@Override
	public <A> Connection<A> getConnection(Class<A> apiType,
			String providerUserId) {
		logger.info("getConnection2 called");
		return null;
	}

	@Override
	public <A> Connection<A> getPrimaryConnection(Class<A> apiType) {
		logger.info("getPrimaryConnection called");
		return null;
	}

	@Override
	public <A> Connection<A> findPrimaryConnection(Class<A> apiType) {
		logger.info("findPrimaryConnection called");
		return null;
	}

	@Override
	public void addConnection(Connection<?> connection) {
		logger.info("addConnection called");
		
		org.springframework.social.connect.UserProfile socialProfile = 
				connection.fetchUserProfile();
		logger.debug("Remote UserProfile retrieved");
		
		String username = connection.getKey().getProviderUserId();
		String providerId = connection.getKey().getProviderId();
		
		logger.debug("Remote username   : " + username);
		logger.debug("Remote provider id: " + providerId);
		logger.debug("Remote firstname  : " + socialProfile.getFirstName());
		logger.debug("Remote lastname   : " + socialProfile.getLastName());
		logger.debug("Remote email      : " + socialProfile.getEmail());
		
		//int i_localUserId = Integer.parseInt(localUserId);
		User user = new User();
		//user.setUserId(i_localUserId);
		user.setUsername(username);
		user.setProvider(providerId);
		user.setFirstname(socialProfile.getFirstName());
		user.setLastname(socialProfile.getLastName());
		user.setEmail(socialProfile.getEmail());
		user.setPassword("NOT_AVAILABLE_FOR_REMOTE_USERS");
		user.setPasswordRepeat("NOT_AVAILABLE_FOR_REMOTE_USERS");
		Timestamp current = GeneralUtils.getCurrentTimestamp(null);
    	user.setCreatedAt(current);
    	user.setUpdatedAt(current);
		
		if(connection instanceof OAuth2Connection) {
			Facebook fbData = (Facebook)connection.getApi();
			UserOperations userOper = fbData.userOperations();
			String fbBirthDay = userOper.getUserProfile().getBirthday();
			user.setBirthday(fbBirthDay);
		}
		
		
		// local profile for the remote user
		// not local user, it had been created earlier in {@link SimpleConnectionSignUp.execute}
		HashSet<UserProfile> externalConnections = new HashSet<UserProfile>();
		UserProfile prof = new UserProfile();
		
		prof.setDisplayname(connection.getDisplayName());
		prof.setImageurl(connection.getImageUrl());
		prof.setProfileurl(connection.getProfileUrl());
		prof.setProviderId(providerId);
		prof.setProvideruserId(username);
		prof.setDisplayname(connection.getDisplayName());
		
		
		if(connection instanceof OAuth2Connection) {
			OAuth2Connection o2Conn = (OAuth2Connection)connection;
			prof.setAccesstoken(o2Conn.createData().getAccessToken());
		} else {
			prof.setAccesstoken("");
		}
		
		prof.setRank(1);
		prof.setUser(user);
		
		externalConnections.add(prof);
		user.setExternalConnections(externalConnections);
		logger.debug("The external connection is assigned to the local user");
		try {
			profileService.registerUser(user);
			userCalendarSubCategoryService.assignAllSubcategoriesToUser(user);
		} catch (ControllerServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.debug("Social user has been inserted into DB");
	}

	@Override
	public void updateConnection(Connection<?> connection) {
		logger.info("updateConnection called");
		
		List<User> localUsers = 
				usersDao.getLocalUsersForConnection(
						connection.getKey().getProviderId(), 
						connection.getKey().getProviderUserId());
		
		UserToken token = new UserToken();
		token.setUser(localUsers.get(0));
		token.setToken(SecurityUtils.generateToken());
		userTokenDao.insertNew(token);
	}

	@Override
	public void removeConnections(String providerId) {
		logger.info("removeConnections called");
	}

	@Override
	public void removeConnection(ConnectionKey connectionKey) {
		logger.info("removeConnection called");
	}

}
