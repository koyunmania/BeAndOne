package com.beone.webapp.persistence;

import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.encrypt.TextEncryptor;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.ConnectionKey;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.ConnectionSignUp;
import org.springframework.social.connect.UsersConnectionRepository;

import com.beone.webapp.controller.service.ProfileService;
import com.beone.webapp.controller.service.UserCalendarSubCategoryService;

/**
 * Important entry point for social network authentication.
 * handles connection persistence methods across all users; 
 * this will be a normal singleton bean in your application context
 * @author Selcuk
 *
 */
public class SocialUsersConnectionRepository implements UsersConnectionRepository {
	
	private static final Logger logger = LoggerFactory.getLogger(SocialUsersConnectionRepository.class);
	
	private ConnectionSignUp connectionSignUp;
	
	private UserDao usersDao;
	
	private UserTokenDao userTokenDao;
	
	private ConnectionFactoryLocator connectionFactoryLocator;
	
	private TextEncryptor textEncryptor;
	
	private ProfileService profileService;
	
	private UserCalendarSubCategoryService userCalendarSubCategoryService;
	
	public UserCalendarSubCategoryService getUserCalendarSubCategoryService() {
		return userCalendarSubCategoryService;
	}

	public void setUserCalendarSubCategoryService(
			UserCalendarSubCategoryService userCalendarSubCategoryService) {
		this.userCalendarSubCategoryService = userCalendarSubCategoryService;
	}

	public ProfileService getProfileService() {
		return profileService;
	}

	public void setProfileService(ProfileService profileService) {
		this.profileService = profileService;
	}
	
	public SocialUsersConnectionRepository(
			UserDao usersDao, 
			UserTokenDao userTokenDao,
			ConnectionFactoryLocator connectionFactoryLocator, 
			TextEncryptor textEncryptor) {
		
		this.usersDao = usersDao;
		this.userTokenDao = userTokenDao;
		this.connectionFactoryLocator = connectionFactoryLocator;
		this.textEncryptor = textEncryptor;
	}

	@Override
	public List<String> findUserIdsWithConnection(Connection<?> connection) {
		logger.info("findUserIdsWithConnection called");
//		ArrayList<String> foundUsers = new ArrayList<String>();
		
		ConnectionKey key = connection.getKey();
		logger.debug(String.format("ProviderId: %s and Provider UserId: %s", 
				key.getProviderId(), 
				key.getProviderUserId()));
		
		List<String> localUserIds = 
				usersDao.getLocalUsernamesForConnection(key.getProviderId(), key.getProviderUserId());
		
		// this method returns the localIDs for the remote user
		// if there is no user until now, then the signup page is shown by controller
		// read the documentation of the method parent
		// the {@link JdbcUsersConnectionRepository} implements auto-create of user
//		if (localUserIds.size() == 0 && connectionSignUp != null) {
//			logger.debug("There is no local user for the remote user, signup the user");
//			String localUserId = connectionSignUp.execute(connection);
//			if (localUserId != null && localUserId.length() > 0 && !"".equals(localUserId)) {
//				logger.debug("Local user created created for the remote user with the id: " + localUserId);
//				createConnectionRepository(localUserId).addConnection(connection);
//				return Arrays.asList(localUserId);
//			}
//		}
		return localUserIds;
		
		//return foundUsers;
	}

	@Override
	public Set<String> findUserIdsConnectedTo(String providerId,
			Set<String> providerUserIds) {
		logger.info("findUserIdsConnectedTo called");
		return null;
	}

	/**
	 * This creates a new instance of {@link SocialConnectionRepository}
	 */
	@Override
	public ConnectionRepository createConnectionRepository(String localUserId) {
		logger.info("createConnectionRepository called");
		if (localUserId == null || localUserId.equals("")) {
			throw new IllegalArgumentException("userId cannot be null");
		}
		
		SocialConnectionRepository conRep = new SocialConnectionRepository(
				localUserId,
				usersDao, 
				userTokenDao, 
				connectionFactoryLocator, 
				textEncryptor);
		
		conRep.setProfileService(profileService);
		conRep.setUserCalendarSubCategoryService(userCalendarSubCategoryService);
		
		return conRep;
	}
	
	/**
	 * The command to execute to create a new local user profile in the event no user id could be mapped to a connection.
	 * Allows for implicitly creating a user profile from connection data during a provider sign-in attempt.
	 * Defaults to null, indicating explicit sign-up will be required to complete the provider sign-in attempt.
	 * @see #findUserIdWithConnection(Connection)
	 */
	public void setConnectionSignUp(ConnectionSignUp connectionSignUp) {
		logger.info("setConnectionSignUp called");
		this.connectionSignUp = connectionSignUp;
	}

}
