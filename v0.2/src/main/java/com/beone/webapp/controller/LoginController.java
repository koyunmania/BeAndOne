package com.beone.webapp.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.social.connect.support.ConnectionFactoryRegistry;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.connect.FacebookConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.beone.constants.Constants;
import com.beone.webapp.controller.service.LoginService;
import com.beone.webapp.controller.service.UserAlbumService;
import com.beone.webapp.controller.service.UserService;
import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserToken;
import com.beone.webapp.model.exceptions.ControllerServiceException;
import com.beone.webapp.model.exceptions.ValidationError;
import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.persistence.UserTokenDao;
import com.beone.webapp.utils.MessageTranslator;
import com.beone.webapp.utils.UrlUtils;


@Controller
public class LoginController extends AbstractController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	public LoginController() {
		System.out.println("LoginController created");
	}
	
	@Autowired
	protected SessionFactory localSessionFactory;
	
	public SessionFactory getLocalSessionFactory() {
		return localSessionFactory;
	}

	public void setLocalSessionFactory(SessionFactory localSessionFactory) {
		this.localSessionFactory = localSessionFactory;
	}
	
	@Autowired
	protected ConnectionFactoryRegistry connectionFactoryLocator;

//	private Facebook facebook;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private UserTokenDao tokenDao;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private UserAlbumService albumService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ReloadableResourceBundleMessageSource messageSource;
	
	public UserAlbumService getAlbumService() {
		return albumService;
	}

	public void setAlbumService(UserAlbumService albumService) {
		this.albumService = albumService;
	}
	
	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	public UserTokenDao getTokenDao() {
		return tokenDao;
	}

	public void setTokenDao(UserTokenDao tokenDao) {
		this.tokenDao = tokenDao;
	}

	public LoginService getLoginService() {
		return loginService;
	}

	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}

//	@Inject
//	public LoginController(Facebook facebook) {
//		this.facebook = facebook;
//	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(
			HttpServletRequest request, 
			HttpServletResponse response,
			Locale locale, 
			Model model) {
		logger.info("login-get is called");
		
		if(request.getParameter("error") != null) {
			if("noaccount".equals(request.getParameter("error"))) {
				model.addAttribute("loginResultIsSuccess", false);
				model.addAttribute(
						"loginResultMessage", 
						"You have not registered with your social network account yet.");
			}
		}
		return "landing";
	}
	
//	@RequestMapping(value = "/face-login", method = RequestMethod.GET)
//	public ModelAndView login(ModelAndView mv,
//			HttpServletRequest httpServletRequest) {
//		
//		FacebookConnectionFactory facebookConnectionFactory = (FacebookConnectionFactory)
//				connectionFactoryLocator.getConnectionFactory(Facebook.class);
//
//		OAuth2Operations oauthOperations = facebookConnectionFactory.getOAuthOperations();
//		OAuth2Parameters params = new OAuth2Parameters();
//
//		params.setRedirectUri("http://localhost:8080/signin/facebook");
//		params.setScope("public_profile,email,user_birthday,publish_actions");
//		String authorizeUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, params);
//		
//		RedirectView rv = new RedirectView(authorizeUrl);
//		logger.info("url= {}", authorizeUrl);
//		mv.setView(rv);
//		return mv;
//	}
	
	/**
	 * When user logs in, then insert new entries for each wish of the user<br/>
	 * It sets some attributes to model:
	 * <ul>
	 * <li>loginResultIsSuccess</li>
	 * <li>validationErrors</li>
	 * <li>loginResultMessage</li>
	 * </ul>
	 * @param user
	 * @param request
	 * @param response
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginSubmit(
			@ModelAttribute("user") User user, 
			HttpServletRequest request, 
			HttpServletResponse response,
			Locale locale, 
			Model model,
			TimeZone timezone) {
		
		logger.info("loginSubmit is called with credentials: {}", user.getLogRepresentation());
		
		String url = Constants.LANDING;
		if(user.getEmail() == null || user.getEmail().length() == 0) {
			logger.warn("Email is not provided");
			
			model.addAttribute("loginResultIsSuccess", false);
			
			ValidationError err = new ValidationError();
			err.setFieldName("email");
			err.setValidationMessage(
					MessageTranslator.getStatusMessageTranslation(
							messageSource, 
							StatusCode.MISSING_MANDATORY_FIELD, 
							locale));
			List<ValidationError> validationErrors = new ArrayList<ValidationError>();
			validationErrors.add(err);
			model.addAttribute("validationErrors", validationErrors);
			return url;
		} else if(user.getPassword() == null || user.getPassword().length() == 0) {
			logger.warn("Password is not provided: " + user.getEmail());

			model.addAttribute("loginResultIsSuccess", false);
			
			ValidationError err = new ValidationError();
			err.setFieldName("password");
			err.setValidationMessage(
					MessageTranslator.getStatusMessageTranslation(
							messageSource, 
							StatusCode.MISSING_MANDATORY_FIELD, 
							locale));
			List<ValidationError> validationErrors = new ArrayList<ValidationError>();
			validationErrors.add(err);
			model.addAttribute("validationErrors", validationErrors);
			return url;
		} else {
			try {
				UserToken securityToken = this.loginService.authenticate(user, request, response, model, timezone);
				
				logger.info("User has been authenticated successfully: " + user.getEmail());
//				if(GeneralUtils.isBlankOrNull(user.getLocale()))
//				{
//					userService.fetchUserLocale(user);
//				}
//				GeneralUtils.addSuccessfulLoginAttributesToModel(locale, model, timezone,
//						securityToken.getToken());
				url = UrlUtils.getUserLocale(
						user, 
						securityToken.getToken(),
						Constants.HOME_REDIRECT);
				
				return url;
				/*return Constants.HOME
						+ "?token="+securityToken.getToken();*/
			} catch (ControllerServiceException e) {
				logger.warn("User authentication failed: " + user.getEmail() + " with reason: " + e.getMessage());
				model.addAttribute(
						"loginResultMessage",
						MessageTranslator.getStatusMessageTranslation(messageSource, e.getStatusCode(), locale));
				model.addAttribute("loginResultIsSuccess", false);
				return "landing";
			}
		}
	}

	
	
	@RequestMapping(value = "/login/facebook", method = RequestMethod.POST)
	public String loginFacebook(Locale locale, Model model) {
		logger.info("/login/facebook called");
		
		return "landing";
	}
	
	@RequestMapping(value = "/login/twitter", method = RequestMethod.POST)
	public String loginTwitter(Locale locale, Model model) {
		logger.info("/login/twitter called");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "landing";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Locale locale, Model model) {
		logger.info("/logout called");
		
		List<GrantedAuthority> authorities = 
				AuthorityUtils.createAuthorityList("ROLE_ANONYMOUS");
		
		AnonymousAuthenticationToken anonym = new AnonymousAuthenticationToken(
				"anonymous", 
				"anonymous", 
				authorities);
		
		SecurityContextHolder.getContext().setAuthentication(anonym);
		
		return "redirect:/";
	}
	
}
