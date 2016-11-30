package com.beone.webapp.utils;

import java.util.ResourceBundle;

import com.beone.constants.Constants;
import com.beone.webapp.model.User;

public class UrlUtils 
{
	public static String getUserLocale(final User user, String url)
	{
		if(GeneralUtils.isNotBlankOrNull(user.getLocale()) && GeneralUtils.isNotBlankOrNull(url))
		{
			String localStr = Constants.LOCALE_PREFIX;
			String userLocale = user.getLocale();
			ResourceBundle appProperties =  ResourceBundle.getBundle(Constants.CONFIG);
			
			String tempUrl = GeneralUtils.isBlankOrNull(userLocale) ? (localStr + appProperties.getString(Constants.DEFAULT_LOCALE_KEY)) : (localStr + userLocale);
			url = url + tempUrl;			
		}
		return url;
	}
	public static final String getUserLocale(final User user, final String securityToken, String url)
	{
		url = getUserLocale(user, url);
		if(GeneralUtils.isNotBlankOrNull(securityToken))
		{
			if(GeneralUtils.isNotBlankOrNull(url) && url.contains(Constants.LOCALE_PREFIX))
			{
				url = url + Constants.TOKEN_VALUE_SEPERATOR + securityToken;
			}
			else
			{
				url = url + Constants.LOCALE_PREFIX + securityToken;
			}
		}
		return url;
	}
}
