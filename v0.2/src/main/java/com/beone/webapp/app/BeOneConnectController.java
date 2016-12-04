package com.beone.webapp.app;

import java.util.Calendar;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.social.connect.ConnectionFactoryLocator;
import org.springframework.social.connect.ConnectionRepository;
import org.springframework.social.connect.UsersConnectionRepository;
import org.springframework.social.connect.web.ConnectController;
import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.beone.webapp.controller.service.LoginService;
import com.beone.webapp.model.User;
import com.beone.webapp.utils.GeneralUtils;
import com.beone.webapp.utils.SecurityUtils;

public class BeOneConnectController extends ConnectController {
	private static final Logger logger = LoggerFactory.getLogger(BeOneConnectController.class);
	
	private ConnectionFactoryLocator connectionFactoryLocator;
	private UsersConnectionRepository usersConnectionRepository;
	
	@Autowired
	private LoginService loginService;

	public LoginService getLoginService() {
		return loginService;
	}

	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}

	public BeOneConnectController(
			ConnectionFactoryLocator connectionFactoryLocator,
			ConnectionRepository connectionRepository,
			UsersConnectionRepository usersConnectionRepository) {
		
		super(connectionFactoryLocator, connectionRepository);
		
		this.connectionFactoryLocator = connectionFactoryLocator;
		this.usersConnectionRepository = usersConnectionRepository;
	}
	
	
	@Override
	protected String connectedView(String providerId) {
		//return "/home";
		return "forward:/home";
	}
	
	@Override
	protected String connectView(String providerId) {
		return "forward:/login";		
	}
	
	@Override
	protected RedirectView connectionStatusRedirect(String providerId, NativeWebRequest request) {
		HttpServletRequest servletRequest = request.getNativeRequest(HttpServletRequest.class);
		
		Model model = new ExtendedModelMap();
				
		Calendar calendar = Calendar.getInstance(servletRequest.getLocale());  
		TimeZone clientTimeZone = calendar.getTimeZone();
		
		SecurityContext context = SecurityContextHolder.getContext();
		
		String token = (String)request.getAttribute(User.ATTR_TOKEN, RequestAttributes.SCOPE_SESSION);
		
		model.addAttribute("token", token);
		
		RedirectView view = new RedirectView("/home", true);
		view.setExposeModelAttributes(true);
		view.setAttributesMap(model.asMap());
		return view;
	}

	@Override
	public String connectionStatus(@PathVariable String providerId, NativeWebRequest request, Model model) {
//		setNoCache(request);
//		processFlash(request, model);
//		List<Connection<?>> connections = connectionRepository.findConnections(providerId);
//		setNoCache(request);
//		if (connections.isEmpty()) {
//			return connectView(providerId); 
//		} else {
//			model.addAttribute("connections", connections);
//			return connectedView(providerId);			
//		}
		return "forward:/";
	}
}
