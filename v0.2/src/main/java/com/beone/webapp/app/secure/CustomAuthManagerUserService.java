package com.beone.webapp.app.secure;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.User;
import com.beone.webapp.persistence.UserDao;

public class CustomAuthManagerUserService implements UserDetailsService {
	private static final Logger logger = LoggerFactory.getLogger(CustomAuthManagerUserService.class);

	@Autowired
	private UserDao userDao;

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

//	@Override
//	public Authentication authenticate(Authentication authentication)
//			throws AuthenticationException {
//		String name = authentication.getName();
//		String password = authentication.getCredentials().toString();
//
//		// use the credentials to try to authenticate against the third party
//		// system
//		if (userDao.checkLogin(name, password)) {
//			List<GrantedAuthority> grantedAuths = new ArrayList<GrantedAuthority>();
//			return new UsernamePasswordAuthenticationToken(
//					name,
//					password,
//					grantedAuths);
//		} else {
//			throw new AuthenticationServiceException(
//					"Count not authenticate against DB");
//		}
//	}

	@Transactional
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		logger.info("CustomerUserService.loadUserByUsername called");
		// use the credentials to try to authenticate against the third party
		// system
		final User foundByUsername = userDao.findByUsername(username);
//        final Set<Authority> authorities = foundByUsername.getAuthorities();
//        final List<GrantedAuthority> authoritiesForSpring = SecurityUtil.convertAuthorityEntieiesIntoSpringAuthorities(authorities);

		final ArrayList<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new SimpleGrantedAuthority("AUTHENTICATED"));
        return new org.springframework.security.core.userdetails.User(
        		username, 
        		foundByUsername.getPassword(), 
        		authorities);
	}
}