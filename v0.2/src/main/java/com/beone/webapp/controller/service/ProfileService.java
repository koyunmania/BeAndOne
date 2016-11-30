package com.beone.webapp.controller.service;

import java.sql.Timestamp;
import java.util.Locale;

import javax.persistence.EntityExistsException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.transaction.annotation.Transactional;

import com.beone.webapp.model.City;
import com.beone.webapp.model.Country;
import com.beone.webapp.model.Email;
import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.User;
import com.beone.webapp.model.exceptions.ControllerServiceException;
import com.beone.webapp.persistence.CityDao;
import com.beone.webapp.persistence.CountryDao;
import com.beone.webapp.persistence.ProfileEntryDao;
import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.persistence.UserTokenDao;
import com.beone.webapp.utils.GeneralUtils;
import com.beone.webapp.utils.MessageTranslator;

public class ProfileService {
    private static final Logger logger = LoggerFactory.getLogger(ProfileService.class);

    @Autowired
    private ProfileEntryDao profileEntryDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserTokenDao tokenDao;

    @Autowired
    private CountryDao countryDao;

    @Autowired
    EmailService emailService;

    @Autowired
    private CityDao cityDao;

    private Email email;

//	@Autowired
//	private UserCalendarSubCategoryDao userCalendarSubCategoryDao;

    public EmailService getEmailService() {
        return emailService;
    }

    public void setEmailService(EmailService emailService) {
        this.emailService = emailService;
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

    public ProfileEntryDao getProfileEntryDao() {
        return profileEntryDao;
    }

    public void setProfileEntryDao(ProfileEntryDao profileEntryDao) {
        this.profileEntryDao = profileEntryDao;
    }

    public CountryDao getCountryDao() {
        return countryDao;
    }

    public void setCountryDao(CountryDao countryDao) {
        this.countryDao = countryDao;
    }

    public CityDao getCityDao() {
        return cityDao;
    }

    public void setCityDao(CityDao cityDao) {
        this.cityDao = cityDao;
    }

//	public UserCalendarSubCategoryDao getUserCalendarSubCategoryDao() {
//		return userCalendarSubCategoryDao;
//	}
//
//	public void setUserCalendarSubCategoryDao(
//			UserCalendarSubCategoryDao userCalendarSubCategoryDao) {
//		this.userCalendarSubCategoryDao = userCalendarSubCategoryDao;
//	}

    @Transactional
    public String registerUser(User user, ReloadableResourceBundleMessageSource messageSource, Locale locale) 
    		throws ControllerServiceException {
    	
        logger.info("registerUser has been called with user data: {}", user.getLogRepresentation());

        if (validateRegistrationFields(user)) {
        	Timestamp current = GeneralUtils.getCurrentTimestamp(null);
        	user.setCreatedAt(current);
        	user.setUpdatedAt(current);
        	
            try {
                if (user.getCurrentCity() == null) {
                    Country defaultCountry = new Country();
                    City defaultCity = new City();

                    if (countryDao.findByName("Turkey") == null) {
                        logger.info("Country Turkey is not existing in DB and will be created...");
                        try {
                            defaultCountry.setCountryName("Turkey");
                            countryDao.insertNew(defaultCountry);
                            defaultCountry = countryDao.findByName("Turkey");
                            user.setCurrentCountry(defaultCountry);
                        } catch (Exception e1) {
                            logger.info("Country Turkey could not be created!!!");
                            throw new ControllerServiceException(StatusCode.REGISTRATION_FAILED, "There was an error during the creation of user country");
                        }
                    } else {
                        defaultCountry = countryDao.findByName("Turkey");
                        user.setCurrentCountry(defaultCountry);
                    }

                    if (cityDao.findByName("Istanbul") == null) {
                        logger.info("City Istanbul is not existing in DB and will be created...");
                        try {
                            defaultCity.setCityName("Istanbul");
                            defaultCity.setCountry(defaultCountry);
                            cityDao.insertNew(defaultCity);
                            defaultCity = cityDao.findByName("Istanbul");
                        } catch (Exception e1) {
                            logger.info("City Istanbul could not be created!!!");
                            throw new ControllerServiceException(StatusCode.REGISTRATION_FAILED, "There was an error during the creation of user city");
                        }
                    } else {
                        defaultCity = cityDao.findByName("Istanbul");
                        defaultCity.setCountry(defaultCountry);
                        cityDao.insertNew(defaultCity);
                        defaultCity = cityDao.findByName("Istanbul");
                    }

                    user.setCurrentCity(defaultCity);
                    logger.info("Default city is set to be Istanbul...");
                }

                if (userDao.checkExistingInsertNewFromProfile(user)) {
                    logger.info("Sending verification mail to user");
                    Email email = new Email();
                    email.setFrom(MessageTranslator.getMessage(
                    		messageSource, 
                    		MessageTranslator.REGISTRATION_EMAIL_VERIFICATION_SENDER, 
                    		locale));
                    email.setTo(user.getEmail());
                    email.setSubject(
                    	MessageTranslator.getMessage(
                    		messageSource, 
                    		MessageTranslator.REGISTRATION_EMAIL_VERIFICATION_SUBJECT, 
                    		locale));
                    email.setLocale(user.getLocale());
                    email.setUserName(user.getEmail());
                    emailService.sendVerificationEmail(user, email);
                }
                logger.info("User has been created, assigning him all of the subcategories.");

//				userCalendarSubCategoryDao.assignAllSubcategoriesToUser(user);
                logger.info("Subcategories assigned");
            } catch (EntityExistsException ex) {
                logger.warn("Requested user entry already exists");
                throw new ControllerServiceException(
                        StatusCode.USER_ALREADY_EXISTS,
                        "There is already a user with the given data");
            }
        }

        return "register";
    }

    private boolean validateRegistrationFields(User user) throws ControllerServiceException {
        if (user.getEmail() == null || user.getEmail().length() == 0) {
            throw new ControllerServiceException(StatusCode.MISSING_MANDATORY_FIELD, "Email cannot be empty");
        } else if (user.getUsername() == null || user.getUsername().length() == 0) {
            throw new ControllerServiceException(StatusCode.MISSING_MANDATORY_FIELD, "Username cannot be empty");
        } else if (user.getPassword() == null || user.getPassword().length() == 0) {
            throw new ControllerServiceException(StatusCode.MISSING_MANDATORY_FIELD, "Password cannot be empty");
        } else if (user.getPassword() == null || !user.getPassword().equals(user.getPasswordRepeat())) {
            throw new ControllerServiceException(StatusCode.MISSING_MANDATORY_FIELD, "Password fields do not match");
        } else {
            return true;
        }
    }
}
