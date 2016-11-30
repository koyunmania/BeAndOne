package com.beone.webapp.services.v1;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.beone.webapp.controller.service.LoginService;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserToken;

@RestController
public class AuthController {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	
	@Autowired
	private LoginService loginService;

	public LoginService getLoginService() {
		return loginService;
	}

	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}

	@RequestMapping(
			value = "/public/api/login", 
			produces = "application/json",
			method = RequestMethod.POST)
	public RestResult loginSubmit(
			@RequestBody User usr,
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("loginSubmit-post is called with email: {}", usr.getEmail());
		
		return loginService.loginSubmitAddToken(usr, request, response);
	}
	
	@RequestMapping(
			value = "/public/api/checkToken", 
			produces = "application/json",
			method = RequestMethod.POST)
	public RestResult checkToken(
			@RequestBody UserToken token,
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("checkToken-post is called with token: {}", token.getToken());
		
		return loginService.checkToken(token, request);
	}
	
	@RequestMapping(
			value = "/public/api/logout", 
			produces = "application/json",
			method = RequestMethod.POST)
	public RestResult logoutToken(
			@RequestBody UserToken token,
			HttpServletRequest request, 
			HttpServletResponse response) {
		logger.info("logoutToken-post is called with token: {}", token.getToken());
		
		return loginService.logoutToken(token);
	}
}
