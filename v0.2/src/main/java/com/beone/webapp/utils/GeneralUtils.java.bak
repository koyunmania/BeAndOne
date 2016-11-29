package com.beone.webapp.utils;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

import org.springframework.ui.Model;

import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.UserToken;

public class GeneralUtils {

	public static Timestamp getCurrentDaysTimestamp(TimeZone userTimezone) {
		Calendar cal = GregorianCalendar.getInstance(userTimezone);	
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		String date =
			year 
			+"-"
			+ (month<9 ? ("0"+(month+1)):(""+(month+1)))
			+"-"
			+ (day<10 ? ("0"+day) : (day))
			+ " 00:00:00";
		
		Timestamp result = Timestamp.valueOf(date);
		
		return result;
	}

//	/**
//	 * @param locale
//	 * @param model
//	 * @param timezone
//	 * @param securityToken
//	 */
//	public static void addSuccessfulLoginAttributesToModel(Locale locale,
//		Model model, TimeZone timezone, String tokenValue) {
//	
//		model.addAttribute("token", tokenValue);
//		
//		// for the retrieval of profile image, there is another controller
////					String profilePhotoUrl = albumService.getUrlOfProfilePhoto(securityToken.getUser());
////					model.addAttribute("profilePhotoUrl", profilePhotoUrl);
//	}
}
