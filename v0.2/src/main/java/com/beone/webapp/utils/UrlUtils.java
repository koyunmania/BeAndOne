package com.beone.webapp.utils;

import java.util.ResourceBundle;

import com.beone.constants.Constants;
import com.beone.webapp.model.User;

public class UrlUtils {
	
	public static String getUserLocaleIfExists(final User user, String url)
	{
		if(GeneralUtils.isNotBlankOrNull(user.getLocale()) && GeneralUtils.isNotBlankOrNull(url))
		{
			String userLocale = user.getLocale();
//			ResourceBundle appProperties =  ResourceBundle.getBundle(Constants.CONFIG);
//			
//			String tempUrl = GeneralUtils.isBlankOrNull(userLocale) ? (Constants.LOCALE_PREFIX + appProperties.getString(Constants.DEFAULT_LOCALE_KEY)) : (Constants.LOCALE_PREFIX + userLocale);
//			url = url + tempUrl;
			
			return Constants.LOCALE_PREFIX + userLocale;
		}
		return url;
	}
	public static final String getUserLocale(final User user, final String securityToken, String url) {
		// if the user has the locale information, then add it to the URL, otherwise use the default settings
//		url = getUserLocaleIfExists(user, url);
		if(user != null && GeneralUtils.isNotBlankOrNull(user.getLocale()) && GeneralUtils.isNotBlankOrNull(url)) {
			String userLocale = user.getLocale();
			url = url + Constants.LOCALE_PREFIX + userLocale;
		} else {
			ResourceBundle appProperties =  ResourceBundle.getBundle(Constants.CONFIG);
			url = url + Constants.LOCALE_PREFIX + appProperties.getString(Constants.DEFAULT_LOCALE_KEY);
		}
		
		// if the security token exists, then append it to the URL
		// this way, the url is always localed
		if(GeneralUtils.isNotBlankOrNull(securityToken)) {
			if(GeneralUtils.isNotBlankOrNull(url) && url.contains(Constants.LOCALE_PREFIX)) {
				url = url + Constants.TOKEN_VALUE_SEPERATOR + securityToken;
			}
		}
		return url;
	}
}
