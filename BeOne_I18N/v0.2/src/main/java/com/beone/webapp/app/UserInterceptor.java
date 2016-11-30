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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.view.RedirectView;

import com.beone.webapp.model.User;

/**
 * Before a request is handled:
 * 1. sets the current User in the {@link SecurityContext} from a cookie, if present 
 * and the user is still connected to Facebook.
 * 2. requires that the user sign-in if he or she hasn't already.
 * @author Keith Donald
 */
public final class UserInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(UserInterceptor.class);

	private final UsersConnectionRepository connectionRepository;
	
	private final UserCookieGenerator userCookieGenerator = new UserCookieGenerator();

	public UserInterceptor(UsersConnectionRepository connectionRepository) {
		this.connectionRepository = connectionRepository;
	}
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		logger.info("preHandle called");
		rememberUser(request, response);
		handleSignOut(request, response);
		
		SecurityContext context = SecurityContextHolder.getContext();
		
		if (context.getAuthentication().getAuthorities().contains(new SimpleGrantedAuthority("AUTHENTICATED")) || requestForSignIn(request)) {
			return true;
		} else {
			return requireSignIn(request, response);
		}
	}
	
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		logger.info("afterCompletion called");
		SecurityContext context = SecurityContextHolder.getContext();
		context.setAuthentication(null);
//		SecurityContext.remove();
	}

	// internal helpers

	private void rememberUser(HttpServletRequest request, HttpServletResponse response) {
		logger.info("rememberUser called");
		String userId = userCookieGenerator.readCookieValue(request);
		if (userId == null) {
			return;
		}
		if (!userNotFound(userId)) {
			userCookieGenerator.removeCookie(response);
			return;
		}
		UsernamePasswordAuthenticationToken authToken = 
				new UsernamePasswordAuthenticationToken(userId, new User(userId));
		
		authToken.setDetails(new WebAuthenticationDetails(request));
		
		SecurityContext context = SecurityContextHolder.getContext();
		context.setAuthentication(authToken);
		
//		SecurityContext.setCurrentUser(new User(userId));
	}

	private void handleSignOut(HttpServletRequest request, HttpServletResponse response) {
		logger.info("handleSignOut called");
		SecurityContext context = SecurityContextHolder.getContext();
		if (context.getAuthentication().getAuthorities().contains(new SimpleGrantedAuthority("AUTHENTICATED")) && request.getServletPath().startsWith("/signout")) {
			connectionRepository.createConnectionRepository(context.getAuthentication().getName()).removeConnections("facebook");
			userCookieGenerator.removeCookie(response);
//			SecurityContext.remove();
			context.setAuthentication(null);
		}
	}
		
	private boolean requestForSignIn(HttpServletRequest request) {
		logger.info("requestForSignIn called");
		return request.getServletPath().startsWith("/signin");
	}
	
	private boolean requireSignIn(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("requireSignIn called");
		new RedirectView("/signin", true).render(null, request, response);
		return false;
	}

	
	private boolean userNotFound(String userId) {
		logger.info("userNotFound called");
		// doesn't bother checking a local user database: simply checks if the userId is connected to Facebook
		return connectionRepository.createConnectionRepository(userId).findPrimaryConnection(Facebook.class) != null;
	}
	
}
