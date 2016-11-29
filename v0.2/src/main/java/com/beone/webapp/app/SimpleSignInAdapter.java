/*
 * Copyright 2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.beone.webapp.app;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

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
import org.springframework.social.connect.web.SignInAdapter;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.ServletWebRequest;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserToken;
import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.persistence.UserTokenDao;
import com.beone.webapp.utils.GeneralUtils;
import com.beone.webapp.utils.SecurityUtils;

/**
 * Checks whether a local user exists and if yes then create a session for that
 * Signs the user in by setting the currentUser property on the {@link SecurityContext}.
 * Remembers the sign-in after the current request completes by storing the user's id in a cookie.
 * This is cookie is read in {@link UserInterceptor#preHandle(HttpServletRequest, HttpServletResponse, Object)} on subsequent requests.
 * @author Keith Donald
 * @see UserInterceptor
 */
public final class SimpleSignInAdapter implements SignInAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(SimpleSignInAdapter.class);

	private final UserCookieGenerator userCookieGenerator = new UserCookieGenerator();
	
	private UserDao userDao;
	
	private UserTokenDao tokenDao;
	
	public UserTokenDao getTokenDao() {
		return tokenDao;
	}

	public void setTokenDao(UserTokenDao tokenDao) {
		this.tokenDao = tokenDao;
	}

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	@Override
	public String signIn(String userId, Connection<?> connection, NativeWebRequest request) {
		logger.info("signIn called");
		
		List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority("AUTHENTICATED"));
		
		List<User> localUsersForProvider = 
				userDao.getLocalUsersForConnection(
						connection.getKey().getProviderId(), 
						connection.getKey().getProviderUserId());
		if(localUsersForProvider.size() == 1) {
			logger.info("Social remote user could be found locally.");
			
			User localUser = localUsersForProvider.get(0);
		
			// password cannot be set to null, exception thrown
			org.springframework.security.core.userdetails.User usr = 
					new org.springframework.security.core.userdetails.User(
							userId, "", authorities);
			
			UsernamePasswordAuthenticationToken authToken = 
					new UsernamePasswordAuthenticationToken(
							localUser, null, authorities);
			
			ServletWebRequest re = (ServletWebRequest)request;
			authToken.setDetails(new WebAuthenticationDetails(re.getRequest()));
			
			SecurityContext context = SecurityContextHolder.getContext();
			context.setAuthentication(authToken);
			
			userCookieGenerator.addCookie(
				userId, 
				request.getNativeResponse(HttpServletResponse.class));
			
			UserToken token = new UserToken();
			token.setUser(localUser);
			String securityToken = SecurityUtils.generateToken();
			token.setToken(securityToken);
			Timestamp currentTime = GeneralUtils.getCurrentTimestamp(null);
			token.setCreatedAt(currentTime);
			token.setUpdatedAt(currentTime);
			
			tokenDao.insertNew(token);
			request.getNativeResponse(HttpServletResponse.class).setHeader("LoginAuthToken", securityToken);

			logger.info("Authentication with social account successful. Returning to home page.");
			
			return "/home?token="+token.getToken();
		}
		logger.info("signIn exiting");
		
		return null;
	}

}
