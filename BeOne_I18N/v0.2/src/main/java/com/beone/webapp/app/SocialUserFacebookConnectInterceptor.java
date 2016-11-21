package com.beone.webapp.app;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionFactory;
import org.springframework.social.connect.web.ConnectInterceptor;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.util.MultiValueMap;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestScope;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;

import com.beone.webapp.controller.service.LoginService;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserToken;
import com.beone.webapp.utils.SecurityUtils;


public class SocialUserFacebookConnectInterceptor implements ConnectInterceptor<Facebook> {
	
	private static final Logger logger = LoggerFactory.getLogger(SocialUserFacebookConnectInterceptor.class);

	@Autowired
	private LoginService loginService;

	public LoginService getLoginService() {
		return loginService;
	}

	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}
	
	@Override
	public void preConnect(ConnectionFactory<Facebook> connectionFactory,
			MultiValueMap<String, String> parameters, WebRequest request) {
		logger.info("preConnect has been called but it's implementation is empty");
	}

	@Override
	public void postConnect(Connection<Facebook> connection, WebRequest request) {
		logger.info("postConnect is called");
		
		String providerUserId = connection.getKey().getProviderUserId();
		
		List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority("AUTHENTICATED"));

		String token = SecurityUtils.generateToken();
		
		loginService.checkSocialUsersExistsAndAssignToken(
				connection,
				authorities,
				request,
				token);
		
		request.setAttribute(User.ATTR_PROVIDER_USERID, providerUserId, RequestAttributes.SCOPE_SESSION);
		request.setAttribute(User.ATTR_TOKEN, token, RequestAttributes.SCOPE_SESSION);
		
		logger.info("Token assigned to the user");
	}
}
