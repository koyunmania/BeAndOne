package com.beone.webapp.controller.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.social.connect.Connection;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.context.request.WebRequest;

import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserToken;
import com.beone.webapp.model.exceptions.ControllerServiceException;
import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.persistence.UserTokenDao;
import com.beone.webapp.services.v1.RestResult;
import com.beone.webapp.utils.GeneralUtils;
import com.beone.webapp.utils.SecurityUtils;

public class LoginService {
	private static final Logger logger = LoggerFactory.getLogger(LoginService.class);
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private UserTokenDao tokenDao;
	
	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	public UserTokenDao getTokenDao() {
		return tokenDao;
	}

	public void setTokenDao(UserTokenDao tokenDao) {
		this.tokenDao = tokenDao;
	}
	
	@Transactional
	public UserToken authenticate(
			User user,
			HttpServletRequest request,
			HttpServletResponse response,
			Model model,
			TimeZone timezone) throws ControllerServiceException {
		
		User foundUser = userDao.checkLoginAndReturnUser(
				user.getEmail(), 
				user.getPassword(), 
				User.USER_PROVIDER_BEONE);
		if(foundUser != null) {
			logger.info("Login with credentials is successful, loading user.");
			boolean status=checkUserStatus(user);
			if(!status){
				logger.info("Checking status of user. Send verification mail");
			}
			logger.debug("Creating token for user");
			UserToken token = new UserToken();
			token.setUser(foundUser);
			String securityToken = SecurityUtils.generateToken();
			token.setToken(securityToken);
			Timestamp currentTime = GeneralUtils.getCurrentTimestamp(timezone);
			token.setCreatedAt(currentTime);
			token.setUpdatedAt(currentTime);
			
			tokenDao.insertNew(token);
			response.setHeader("LoginAuthToken", securityToken);
			
			logger.debug("Creating authentication session for user");
			
			// we need to set the context authentication otherwise user context is not created
			List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
			authorities.add(new SimpleGrantedAuthority("AUTHENTICATED"));
			
			UsernamePasswordAuthenticationToken authToken = 
				new UsernamePasswordAuthenticationToken(
					foundUser, 
					foundUser.getPassword(), 
					authorities);
			
			authToken.setDetails(new WebAuthenticationDetails(request));
			
			SecurityContext context = SecurityContextHolder.getContext();
			context.setAuthentication(authToken);
			
			logger.info("Login was successful.");
			return token;
		} else {
			logger.info("Login was unsuccessful");
			
			throw new ControllerServiceException(
					StatusCode.LOGIN_FAILED ,
					"No user could be found with given username and password combination.");
		}
	}
	
	@Transactional
	public RestResult loginSubmitAddToken(
			User usr,
			HttpServletRequest request, 
			HttpServletResponse response) {
		ArrayList<String> errorMessages = new ArrayList<String>();
		RestResult result = new RestResult();
		
		if(usr.getEmail() == null || usr.getEmail().length() == 0) {
			errorMessages.add("Email has to be entered");
		} else if(usr.getPassword() == null || usr.getPassword().length() == 0) {
			errorMessages.add("Password has to be entered");
		} else {
			User foundUser = userDao.checkLoginAndReturnUser(
					usr.getEmail(), 
					usr.getPassword(), 
					User.USER_PROVIDER_BEONE);
			if(foundUser != null) {
				userDao.update(foundUser);
				
				UserToken token = new UserToken();
				token.setUser(foundUser);
				token.setToken(SecurityUtils.generateToken());
				tokenDao.insertNew(token);
				
				// token is inserted into header
				response.setHeader("LoginAuthToken", token.getToken());
				
				// we need to set the context authentication otherwise user context is not created
				List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
				authorities.add(new SimpleGrantedAuthority("AUTHENTICATED"));
				
				UsernamePasswordAuthenticationToken authToken = 
						new UsernamePasswordAuthenticationToken(foundUser, foundUser.getPassword(), authorities);
				
				authToken.setDetails(new WebAuthenticationDetails(request));
				
				SecurityContext context = SecurityContextHolder.getContext();
				context.setAuthentication(authToken);
				result.setMessage("Login is successful");
				result.setStatus(true);
				//result.setData(token.getToken());
				response.setHeader("LoginAuthToken", token.getToken());
				
			} else {
				errorMessages.add("Login was unsuccessful");
				result.setData(errorMessages.toArray());
				result.setMessage("Login was unsuccessful");
				result.setStatus(false);
			}
		}
		
		return result;
	}
	
	@Transactional
	public RestResult logoutToken(UserToken token) {
		ArrayList<String> errorMessages = new ArrayList<String>();
		RestResult result = new RestResult();
		
		logger.info("logoutToken-post is called with token: {}", token.getToken());
		
		if(token == null || token.getToken().length() == 0) {
			errorMessages.add("Email has to be entered");
		} else {
			User foundUser = tokenDao.getUserByToken(token);
			if(foundUser != null) {
				tokenDao.delete(token);
				result.setMessage("Token invalidated");
				result.setStatus(true);
			} else {
				errorMessages.add("Token could not be found");
				result.setData(errorMessages.toArray());
				result.setMessage("Token could not be found");
				result.setStatus(true);
			}
			
		}
		
		return result;
	}
	
	@Transactional
	public RestResult checkToken(
			UserToken token,
			HttpServletRequest request) {
		ArrayList<String> errorMessages = new ArrayList<String>();
		RestResult result = new RestResult();
		
		if(token == null || token.getToken().length() == 0) {
			errorMessages.add("Email has to be entered");
			result.setData(errorMessages.toArray());
			result.setMessage("Token is not delivered");
			result.setStatus(false);
		} else {
			User foundUser = tokenDao.getUserByToken(token);
			if(foundUser != null) {
				// we need to set the context authentication otherwise user context is not created
				List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
				authorities.add(new SimpleGrantedAuthority("AUTHENTICATED"));
				
//				org.springframework.security.core.userdetails.User authUser = 
//						new org.springframework.security.core.userdetails.User(
//								foundUser.getEmail(), foundUser.getPassword(), authorities);
				
				UsernamePasswordAuthenticationToken authToken = 
						new UsernamePasswordAuthenticationToken(foundUser, foundUser.getPassword(), authorities);
				
				authToken.setDetails(new WebAuthenticationDetails(request));
				
				SecurityContext context = SecurityContextHolder.getContext();
				context.setAuthentication(authToken);
				result.setMessage("Token is stil valid");
				result.setStatus(true);
			} else {
				errorMessages.add("Token is not valid");
				result.setData(errorMessages.toArray());
				result.setMessage("Token is not valid");
				result.setStatus(false);
			}
		}
		
		return result;
	}

	
	
	@Transactional
	public void checkSocialUsersExistsAndAssignToken(
			Connection<Facebook> connection,
			List<SimpleGrantedAuthority> authorities,
			WebRequest request, 
			String securityToken) {
		
		List<User> localUsersForProvider = 
				userDao.getLocalUsersForConnection(
						connection.getKey().getProviderId(), 
						connection.getKey().getProviderUserId());
		
		if(localUsersForProvider.size() == 1) {
			logger.info("Social remote user could be found locally.");
			
			User localUser = localUsersForProvider.get(0);
			userDao.update(localUser);
			
			// here we have to use the local user and not a userdetails user
			UsernamePasswordAuthenticationToken authToken = 
					new UsernamePasswordAuthenticationToken(
							localUser, "", authorities);
			
			SecurityContext context = SecurityContextHolder.getContext();
			context.setAuthentication(authToken);
			
			UserToken token = new UserToken();
			token.setUser(localUser);
			token.setToken(securityToken);
			Timestamp current = GeneralUtils.getCurrentTimestamp(null);
			token.setCreatedAt(current);
			token.setUpdatedAt(current);
			tokenDao.insertNew(token);
		} else {
			logger.warn("There is an error occured.");
			logger.error("The just inserted remote user could not be found again.");
		}
	}

	public boolean checkUserStatus(User user){
		//TODO
		return false;
	}
}
