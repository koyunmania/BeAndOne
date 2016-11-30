package com.beone.webapp.utils;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

import org.apache.poi.ss.usermodel.Cell;
import org.springframework.ui.Model;
import org.thymeleaf.util.StringUtils;

import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.UserToken;

public class GeneralUtils {

	public static Timestamp getCurrentDaysTimestamp(TimeZone userTimezone) {
		Calendar cal = null;
		if(userTimezone == null) {
			cal = GregorianCalendar.getInstance();	
		} else {
			cal = GregorianCalendar.getInstance(userTimezone);
		}
		
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
	
	public static Timestamp getCurrentTimestamp(TimeZone userTimezone) {
		Calendar cal = null;
		if(userTimezone == null) {
			cal = GregorianCalendar.getInstance();	
		} else {
			cal = GregorianCalendar.getInstance(userTimezone);
		}
		
		Timestamp result = new Timestamp(cal.getTimeInMillis());
		
		return result;
	}

	public static String trimAndGetStringValue(Cell cell) {
		if(cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
			return "" + (int)cell.getNumericCellValue();
		} else if(cell.getCellType() == Cell.CELL_TYPE_STRING){
			return StringUtils.trim(cell.getStringCellValue());
		} else if(cell.getCellType() == Cell.CELL_TYPE_BOOLEAN){
			return "" + cell.getBooleanCellValue();
		} else {
			return "";
		}
	}

	public static final boolean isBlankOrNull(final String value)
	{
		return (null!=value && value.length()>0) ? false : true;
	}
	
	public static final boolean isNotBlankOrNull(final String value)
	{
		return (null!=value && value.length()>0) ? true : false;		
	}
	
	public static final boolean isNonZero(final int value)
	{
		return (value>0) ? true : false;		
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
