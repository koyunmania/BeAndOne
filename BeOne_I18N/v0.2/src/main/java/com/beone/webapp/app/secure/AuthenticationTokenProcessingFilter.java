package com.beone.webapp.app.secure;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.filter.GenericFilterBean;

import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.persistence.UserTokenDao;

public class AuthenticationTokenProcessingFilter extends GenericFilterBean {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthenticationTokenProcessingFilter.class);
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	TokenUtils tokenUtils;
	
	@Autowired
	UserTokenDao tokenDao;

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public TokenUtils getTokenUtils() {
		return tokenUtils;
	}

	public void setTokenUtils(TokenUtils tokenUtils) {
		this.tokenUtils = tokenUtils;
	}

	public UserTokenDao getTokenDao() {
		return tokenDao;
	}

	public void setTokenDao(UserTokenDao tokenDao) {
		this.tokenDao = tokenDao;
	}

	@Transactional
	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		logger.info("doFilter called");
		
		HttpServletResponse resp=(HttpServletResponse) response;
		resp.setHeader("Access-Control-Allow-Origin", "*");
		resp.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        resp.setHeader("Access-Control-Max-Age", "3600");
        resp.setHeader("Access-Control-Allow-Headers", "Origin, Accept, X-AUTH-TOKEN, X-Requested-With, "
        		+ "Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers");
        resp.setHeader("Access-Control-Expose-Headers", "X-AUTH-TOKEN, LoginAuthToken");
        
        if (((HttpServletRequest)request).getMethod()!="OPTIONS") {
        	@SuppressWarnings("unchecked")
    		Map<String, String[]> parms = request.getParameterMap();

    		String strToken = "";
    		
    		if (parms.containsKey("token")) {
    			strToken = parms.get("token")[0]; // grab the first "token" parameter
    			logger.debug("Token: " + strToken);
    		} else {
    			logger.info("no token found in parameters - checking header");
    			Enumeration en = ((HttpServletRequest)request).getHeaderNames();
    			while(en.hasMoreElements()) {
    				Object obj = en.nextElement();
    				if(((String)obj).equals("token")) {
    					logger.debug("Token found in header");
    					strToken = ((HttpServletRequest)request).getHeader("token");
    				}
    			}
    			
    			if (parms.containsKey("x-auth-token")) {
    				strToken = parms.get("x-auth-token")[0]; // grab the first "token" parameter
    				logger.debug("X-AUTH-TOKEN: " + strToken);
    			} else {
    				logger.info("no X-AUTH-TOKEN found in parameters - checking header");
    				en = ((HttpServletRequest)request).getHeaderNames();
    				while(en.hasMoreElements()) {
    					Object obj = en.nextElement();
    					if(((String)obj).equals("x-auth-token")) {
    						logger.debug("X-AUTH-TOKEN found in header");
    						strToken = ((HttpServletRequest)request).getHeader("x-auth-token");
    					}
    				}
    			}
    		}
    		
    		
    		if (!strToken.equals("")) {
    			if (tokenUtils.validate(strToken, userDao)) {
    				authenticateContext(request, strToken);
    			} else {
    				logger.debug("Invalid token provided: " + strToken);
    			}
    		} else {
    			logger.debug("Token not found in parameters or header");
    		}
    		// continue thru the filter chain
    		chain.doFilter(request, response);
        } else {
        }
	}

	private void authenticateContext(ServletRequest request, String strToken) {
		logger.info("authenticateContext called with: valid token found");
		
		//User usr = tokenUtils.getSpringUserFromToken(strToken, tokenDao);
		com.beone.webapp.model.User usr = tokenUtils.getBeOneUserFromToken(strToken);
		
		if(usr != null) {
			List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
			authorities.add(new SimpleGrantedAuthority("AUTHENTICATED"));
	
			UsernamePasswordAuthenticationToken token = 
					new UsernamePasswordAuthenticationToken(
							usr,
							usr.getPassword(),
							authorities);
			
			token.setDetails(new WebAuthenticationDetails((HttpServletRequest) request));
			
			SecurityContext context = SecurityContextHolder.getContext();
			context.setAuthentication(token);
	
			logger.info("User retrieved by token" + usr.getLogRepresentation());
		} else {
			logger.info("User could not retrieved by token");
		}
	}
}
