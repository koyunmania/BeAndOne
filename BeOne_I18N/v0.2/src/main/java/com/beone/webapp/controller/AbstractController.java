package com.beone.webapp.controller;

import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserFriend;
import com.beone.webapp.app.ApplicationSettings;

public abstract class AbstractController {
	
	private static final Logger logger = LoggerFactory.getLogger(AbstractController.class);
	
	protected User currentUser;
	
	@Autowired
	protected ApplicationSettings applicationSettings;
	
	public ApplicationSettings getApplicationSettings() {
		return applicationSettings;
	}

	public void setApplicationSettings(ApplicationSettings applicationSettings) {
		this.applicationSettings = applicationSettings;
	}
	
	public User getCurrentAuthUser() {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication auth = context.getAuthentication();
		
		if(auth != null && auth.getPrincipal() != null && auth.getAuthorities() != null &&  
				auth.getAuthorities().contains(new SimpleGrantedAuthority("AUTHENTICATED"))) {
			if(auth instanceof AnonymousAuthenticationToken) {
				return null;
			} else {
				User usr = (User) auth.getPrincipal();
				return usr;
			}
		} else {
			return null;
		}
	}
	
	protected void initializeBasics(Model model) {
		currentUser = getCurrentAuthUser();
		if(currentUser != null) {
			logger.info("Current authenticated user found: " + currentUser.getEmail());
			
			model.addAttribute("username", currentUser.getUsername());
			
			UserFriend[] userFriends = currentUser.getUserFriends();
			model.addAttribute("userfriends", userFriends);
			
//			Set<UserSport> userSports = currentUser.getUserSports();
//			model.addAttribute("usersports", userSports);
//			
//			Set<UserTeam> userTeams = currentUser.getUserTeams();
//			model.addAttribute("userteam", userTeams);
		} else {
			logger.info("Current authenticated user could not be found.");
		}
	}
}
