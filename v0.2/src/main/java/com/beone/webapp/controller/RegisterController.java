package com.beone.webapp.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.beone.webapp.controller.service.CityService;
import com.beone.webapp.controller.service.CountryService;
import com.beone.webapp.controller.service.ProfileService;
import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.User;
import com.beone.webapp.model.exceptions.ControllerServiceException;
import com.beone.webapp.model.exceptions.ValidationError;
import com.beone.webapp.utils.MessageTranslator;


@Controller
public class RegisterController extends AbstractController {
	
	private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private CountryService countryService;
	
	@Autowired
	private CityService cityService;
	
	@Autowired
	private ReloadableResourceBundleMessageSource messageSource;


	public ProfileService getProfileService() {
		return profileService;
	}

	public void setProfileService(ProfileService profileService) {
		this.profileService = profileService;
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register(Locale locale, Model model) {
		logger.info("register has been called");		
		return "register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPost(@ModelAttribute("user") User user, Locale locale, Model model) {
		logger.info("Register has been called with user data: {}", user.getLogRepresentation());
		
		List<ValidationError> validationErrors = validateFields(model, user, locale);
		if(validationErrors.size() == 0) {
			try {
				user.setProvider(User.USER_PROVIDER_BEONE);
				profileService.registerUser(user, messageSource, locale);
				logger.info("User has been created");
				model.addAttribute(
						"creationResultMessage", 
						MessageTranslator.getStatusMessageTranslation(messageSource, StatusCode.REGISTRATION_SUCCESSFUL, locale));
				model.addAttribute("creationResultIsSuccess", true);
				
			} catch (ControllerServiceException e) {
				logger.warn("Error occured during registration");
				model.addAttribute(
						"creationResultMessage",
						MessageTranslator.getStatusMessageTranslation(messageSource, e.getStatusCode(), locale));
				model.addAttribute("creationResultIsSuccess", false);
			}
		} else {
			model.addAttribute(
					"creationResultMessage",
					MessageTranslator.getStatusMessageTranslation(messageSource, StatusCode.REGISTRATION_FAILED, locale));
			model.addAttribute("creationResultIsSuccess", false);
			model.addAttribute("validationErrors", validationErrors);
		}
		
		return "register";
	}
	
	private List<ValidationError> validateFields(Model model, User user, Locale locale) {
		List<ValidationError> validationErrors = new ArrayList<ValidationError>();
		
		if(user.getEmail() == null || user.getEmail().length() == 0) {
			ValidationError error = new ValidationError();
			error.setFieldName("email");
			error.setValidationMessage(MessageTranslator.getStatusMessageTranslation(messageSource, StatusCode.MISSING_MANDATORY_FIELD, locale));
			validationErrors.add(error);
		}
		if(user.getUsername() == null || user.getUsername().length() == 0) {
			ValidationError error = new ValidationError();
			error.setFieldName("username");
			error.setValidationMessage(MessageTranslator.getStatusMessageTranslation(messageSource, StatusCode.MISSING_MANDATORY_FIELD, locale));
			validationErrors.add(error);
		}
		if(user.getPassword() == null || user.getPassword().length() == 0) {
			ValidationError error = new ValidationError();
			error.setFieldName("password");
			error.setValidationMessage(MessageTranslator.getStatusMessageTranslation(messageSource, StatusCode.MISSING_MANDATORY_FIELD, locale));
			validationErrors.add(error);
		}
		if(user.getPassword() == null || !user.getPassword().equals(user.getPasswordRepeat())) {
			ValidationError error = new ValidationError();
			error.setFieldName("email");
			error.setValidationMessage(MessageTranslator.getStatusMessageTranslation(
					messageSource, 
					StatusCode.PASSWORD_REPETITION_DOESNT_MATCH, 
					locale));
			validationErrors.add(error);
		}
		
		return validationErrors;
	}
}
