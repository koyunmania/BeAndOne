package com.beone.webapp.app.secure;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserToken;
import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.persistence.UserTokenDao;

public class TokenUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(TokenUtils.class);
	
//	@Autowired
	private UserTokenDao userTokenDao;

	public UserTokenDao getUserTokenDao() {
		return userTokenDao;
	}

	public void setUserTokenDao(UserTokenDao userTokenDao) {
		this.userTokenDao = userTokenDao;
	}

	public String getToken(UserDetails userDetails) {
		return "";
	}
	
	public String getToken(UserDetails userDetails, Long expiration) {
		return "";
	}
	
	public boolean validate(String token, UserDao userDao) {
		return true;
	}
	
	public org.springframework.security.core.userdetails.User getSpringUserFromToken(String token, UserTokenDao tokenDao) {
		logger.debug("getSpringUserFromToken called");
		
		logger.debug("Provided token: " + token);
		
		UserToken usrToken = new UserToken();
		usrToken.setToken(token);
		User usr = tokenDao.getUserByToken(usrToken);
		
		if(usr != null) {
		
			List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
			authorities.add(new SimpleGrantedAuthority("AUTHENTICATED"));
			if(usr.getProvider().equals(User.USER_PROVIDER_BEONE)) {
				return new org.springframework.security.core.userdetails.User(
					usr.getUsername(), usr.getPassword(), authorities);
			} else {
				return new org.springframework.security.core.userdetails.User(
					usr.getUsername(), "", authorities);
			}
		} else {
			return null;
		}
	}
	
	public User getBeOneUserFromToken(String token) {
		logger.debug("getBeOneUserFromToken called");
		
		logger.debug("Provided token: " + token);
		
		UserToken usrToken = new UserToken();
		usrToken.setToken(token);
		User usr = userTokenDao.getUserByToken(usrToken);
		
		return usr;
	}
}
