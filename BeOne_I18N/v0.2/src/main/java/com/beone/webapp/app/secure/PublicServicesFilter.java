package com.beone.webapp.app.secure;

import java.io.IOException;
import java.util.Map;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.filter.GenericFilterBean;


public class PublicServicesFilter extends GenericFilterBean {
	
	private static final Logger logger = LoggerFactory.getLogger(PublicServicesFilter.class);
	
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
		
		@SuppressWarnings("unchecked")
		Map<String, String[]> parms = request.getParameterMap();

		
		// continue thru the filter chain
		chain.doFilter(request, response);
	}

}
