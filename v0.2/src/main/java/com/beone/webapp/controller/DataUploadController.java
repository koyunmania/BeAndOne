package com.beone.webapp.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.thymeleaf.util.StringUtils;

import com.beone.webapp.controller.service.BeOneCalendarEventService;
import com.beone.webapp.controller.service.BeOneCalendarService;
import com.beone.webapp.controller.service.BeOneCalendarSubCategoryService;
import com.beone.webapp.controller.service.CityService;
import com.beone.webapp.controller.service.CountryService;
import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarEvent;
import com.beone.webapp.model.BeOneCalendarEventTranslation;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.BeOneCalendarSubCategoryTranslation;
import com.beone.webapp.model.BeOneCalendarTranslation;
import com.beone.webapp.model.BeOneLanguage;
import com.beone.webapp.model.City;
import com.beone.webapp.model.Country;
import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.exceptions.ControllerServiceException;
import com.beone.webapp.utils.BeOneCalendarUtil;
import com.beone.webapp.utils.GeneralUtils;

@Controller
public class DataUploadController {
	private static final Logger logger = LoggerFactory.getLogger(DataUploadController.class);
	
	@Autowired
	private CountryService countryService;
	
	@Autowired
	private CityService cityService;
	
	@Autowired
	private BeOneCalendarService calendarService;
	
	@Autowired
	private BeOneCalendarSubCategoryService subcategoryService;
	
	@Autowired
	private BeOneCalendarEventService calendarEventService;
	
	public CountryService getCountryService() {
		return countryService;
	}

	public void setCountryService(CountryService countryService) {
		this.countryService = countryService;
	}

	public CityService getCityService() {
		return cityService;
	}

	public void setCityService(CityService cityService) {
		this.cityService = cityService;
	}

	public BeOneCalendarService getCalendarService() {
		return calendarService;
	}

	public void setCalendarService(BeOneCalendarService calendarService) {
		this.calendarService = calendarService;
	}
	
	public BeOneCalendarEventService getCalendarEventService() {
		return calendarEventService;
	}

	public void setCalendarEventService(
			BeOneCalendarEventService calendarEventService) {
		this.calendarEventService = calendarEventService;
	}

	public BeOneCalendarSubCategoryService getSubcategoryService() {
		return subcategoryService;
	}

	public void setSubcategoryService(
			BeOneCalendarSubCategoryService subcategoryService) {
		this.subcategoryService = subcategoryService;
	}

	@RequestMapping(value = "/upload-form", method = RequestMethod.GET)
	public String upload_form(Locale locale, Model model) {
		logger.info("upload_form-get is called");
		
		// countries
		ArrayList<Country> allCountries = countryService.getAllCountries();
		
		// cities
		ArrayList<City> allCities = cityService.getAllCitiesWithCountries();
		
		model.addAttribute("countries", allCountries);
		model.addAttribute("cities", allCities);
		
		logger.debug("upload_form-get exiting");
		return "dataupload";
	}
	
	@RequestMapping(value = "/upload-calendar", method = RequestMethod.POST)
	public String upload_calendar(
			@RequestParam("city") String cityId,
			@RequestParam("uploadFile") MultipartFile file,
			@RequestParam("language") String languageId,
			Locale locale,
			Model model) {
		logger.info("upload_calendar-post is called");
		
		int i_languageId = BeOneLanguage.ENGLISH.ordinal();
		try {
			i_languageId = Integer.parseInt(languageId);
		} catch(NumberFormatException e) {
			logger.warn("Provided language Id is not compatible: " + languageId);
		}
		
		// countries
		ArrayList<Country> allCountries = countryService.getAllCountries();
		
		// cities
		ArrayList<City> allCities = cityService.getAllCitiesWithCountries();
		
		model.addAttribute("countries", allCountries);
		model.addAttribute("cities", allCities);
		
		// TODO: Later we retrieve the timezone from the Location value in Excel.
		// besides, the value should be calculated via SummerTime and WinterTime considerations.
		Calendar currentCalendarInLocation = Calendar.getInstance();
		
		ArrayList<String> resultMessages = new ArrayList<String>();
		
		// Zero based indexes
		int columnIndexWhereDatesStart = 38;
		int columnIndexWherePlusCResidesTr = 32;
		int columnIndexWherePlusCResidesEn = 33;
		int columnIndexWhereGoogleIt = 36;
		
		int indexOfTimeZoneCell = 13;
    	
    	
    	int indexOfCategoryEnCell = 6;
    	int indexOfCategoryTrCell = 7;
    	int indexOfSubCategoryEnCell = 8;
    	int indexOfSubCategoryTrCell = 9;
    	int indexOfEventNameEnCell = 10;
    	int indexOfEventNameTrCell = 11;
    	
    	int indexOfPlusCDesignNumberTrCell = 17;
    	int indexOfPlusCMessageNumberTrCell = 18;
    	int indexOfPlusC2WebTrCell = 19;
    	int indexOfPlusC2WallTrCell = 20;
    	int indexOfPlusC2PrintTrCell = 21;
    	int indexOfPlusC2AppTrCell = 22;
    	
    	int indexOfPlusCDesignNumberEnCell = 17;
    	int indexOfPlusCMessageNumberEnCell = 25;
    	int indexOfPlusC2WebEnCell = 26;
    	int indexOfPlusC2WallEnCell = 27;
    	int indexOfPlusC2PrintEnCell = 28;
    	int indexOfPlusC2AppEnCell = 29;
		
		if(file == null) {
			model.addAttribute("error", "No file could be uploaded");
			logger.info("No file could be uploaded");
		} else  if(
				!file.getOriginalFilename().toLowerCase().endsWith(".xls") && 
				!file.getOriginalFilename().toLowerCase().endsWith(".xlsx")) {
			logger.info("Uploaded file: "+file.getOriginalFilename());
			model.addAttribute("error", "Uploaded file is not an Excel file");
		} else {
			logger.info("Uploaded file: "+file.getOriginalFilename());
			try {
				//FileInputStream inputStream = new FileInputStream(file.getInputStream());
				Workbook workbook = new XSSFWorkbook(file.getInputStream());
		        Sheet firstSheet = workbook.getSheetAt(0);
		        Iterator<Row> iterator = firstSheet.iterator();
		        
		        int rowIndex = 1;
		        ArrayList<BeOneCalendar> calendars = new ArrayList<BeOneCalendar>();
		        
		        // which column index represents which date, to use it easily later
		        HashMap<String, Date> columnDateMapping = new HashMap<String, Date>();
		        
		        // iterate within the columns of the first row to build up the columnDateMapping
		        int colIndex = 0;
		        try {
			        if(iterator.hasNext()) {
			        	Row nextRow = iterator.next();
			        	resultMessages.add("Last Cell Index: " + nextRow.getLastCellNum());
			        	for(int i=columnIndexWhereDatesStart; i<nextRow.getLastCellNum(); i++) {
			        		logger.debug("Column " + i + " has the type: " + nextRow.getCell(i).getCellType());
			        		switch(nextRow.getCell(i).getCellType()) {
				        		case Cell.CELL_TYPE_BLANK:
				        			logger.debug(" cell is empty");
				        			break;
				        		case Cell.CELL_TYPE_BOOLEAN:
				        			logger.debug(" cell is boolean");
				        			logger.debug(" value: " + nextRow.getCell(i).getBooleanCellValue());
				        			break;
				        		case Cell.CELL_TYPE_ERROR:
				        			logger.debug(" cell is error");
				        			break;
				        		case Cell.CELL_TYPE_FORMULA:
				        			logger.debug(" cell is formula");
				        			logger.debug(" value: " + nextRow.getCell(i).getCellFormula());
				        			break;
				        		case Cell.CELL_TYPE_NUMERIC:
				        			logger.debug(" cell is numeric");
				        			logger.debug(" value: " + nextRow.getCell(i).getNumericCellValue());
				        			logger.debug(" value: " + nextRow.getCell(i).getDateCellValue());
				        			break;
				        		case Cell.CELL_TYPE_STRING:
				        			logger.debug(" cell is string");
				        			logger.debug(" value: " + nextRow.getCell(i).getStringCellValue());
				        			break;
			        		}
			        		colIndex = i;
			        		columnDateMapping.put(""+i, nextRow.getCell(i).getDateCellValue());
			        	}
			        }
		        } catch(IllegalStateException ex) {
		        	resultMessages.add("Header row dates are not compatible in column: " + colIndex);
		        	
		        	workbook.close();
			        file.getInputStream().close();
			        
		        	throw new ControllerServiceException(StatusCode.MISSING_MANDATORY_FIELD, 
		        			"Header row dates are not compatible in column: " + colIndex);
		        }
		        int lineNumber = 2;
		        while (iterator.hasNext()) {
		        	logger.info("Working on line: " + lineNumber);
		        	Row currentRow = iterator.next();
		        	lineNumber++;
		        	logger.debug("Retrieved the next line. ");
		        	
					Cell timeZoneCell = currentRow.getCell(indexOfTimeZoneCell);
					Cell categoryTrCell = currentRow.getCell(indexOfCategoryTrCell);
					Cell categoryEnCell = currentRow.getCell(indexOfCategoryEnCell);
					Cell subCategoryTrCell = currentRow.getCell(indexOfSubCategoryTrCell);
					Cell subCategoryEnCell = currentRow.getCell(indexOfSubCategoryEnCell);
					Cell eventNameTrCell = currentRow.getCell(indexOfEventNameTrCell);
					Cell eventNameEnCell = currentRow.getCell(indexOfEventNameEnCell);
		        	Cell eventLocationCell = currentRow.getCell(indexOfTimeZoneCell);
//		        	Cell i love u selcuk beyhan yakashikular
//		        	Cell eventDescriptionCell = currentRow.getCell(columnIndexWherePlusCResides);
//		        	Cell plusCNumberToMakeFilenameCell = currentRow.getCell(14);
		        	
		        	
		        	Cell plusCDesignNumberTrCell = currentRow.getCell(indexOfPlusCDesignNumberTrCell);
		        	Cell plusCMessageNumberTrCell = currentRow.getCell(indexOfPlusCMessageNumberTrCell);
		        	Cell plusC2WebTrCell = currentRow.getCell(indexOfPlusC2WebTrCell);
		        	Cell plusC2WallTrCell = currentRow.getCell(indexOfPlusC2WallTrCell);
		        	Cell plusC2PrintTrCell = currentRow.getCell(indexOfPlusC2PrintTrCell);
		        	Cell plusC2AppTrCell = currentRow.getCell(indexOfPlusC2AppTrCell);
		        	Cell eventDescriptionTrCell = currentRow.getCell(columnIndexWherePlusCResidesTr);
		        	
		        	Cell plusCDesignNumberEnCell = currentRow.getCell(indexOfPlusCDesignNumberEnCell);
		        	Cell plusCMessageNumberEnCell = currentRow.getCell(indexOfPlusCMessageNumberEnCell);
		        	Cell plusC2WebEnCell = currentRow.getCell(indexOfPlusC2WebEnCell);
		        	Cell plusC2WallEnCell = currentRow.getCell(indexOfPlusC2WallEnCell);
		        	Cell plusC2PrintEnCell = currentRow.getCell(indexOfPlusC2PrintEnCell);
		        	Cell plusC2AppEnCell = currentRow.getCell(indexOfPlusC2AppEnCell);
		        	Cell eventDescriptionEnCell = currentRow.getCell(columnIndexWherePlusCResidesEn);
		        	
		        	
		        	logger.debug(String.format("Retrieved line category-TR: %s, subCategory-TR: %s, eventName-TR: %s, location: %s", 
		        			categoryTrCell.toString(),
		        			subCategoryTrCell.toString(),
		        			eventNameTrCell.toString(),
		        			eventLocationCell.toString()));
		        	logger.debug(String.format("Retrieved line category-EN: %s, subCategory-EN: %s, eventName-EN: %s, location: %s", 
		        			categoryEnCell.toString(),
		        			subCategoryEnCell.toString(),
		        			eventNameEnCell.toString(),
		        			eventLocationCell.toString()));
		        	
		        	if( //timeZoneCell.getCellType() == Cell.CELL_TYPE_STRING &&
		        		categoryTrCell.getCellType() == Cell.CELL_TYPE_STRING &&
		        		subCategoryTrCell.getCellType() == Cell.CELL_TYPE_STRING &&
		        		eventNameTrCell.getCellType() == Cell.CELL_TYPE_STRING &&
		        		
		        		categoryEnCell.getCellType() == Cell.CELL_TYPE_STRING &&
		        		subCategoryEnCell.getCellType() == Cell.CELL_TYPE_STRING &&
		        		eventNameEnCell.getCellType() == Cell.CELL_TYPE_STRING) {
		        		
		        		logger.debug(String.format("Initializing the calendar category-TR: %s subcategory-TR: %s eventName-TR: %s", 
		        				categoryTrCell.getStringCellValue(), 
		        				subCategoryTrCell.getStringCellValue(),
		        				eventNameTrCell.getStringCellValue()));
		        		
		        		logger.debug(String.format("Initializing the calendar category-EN: %s subcategory-EN: %s eventName-EN: %s", 
		        				categoryEnCell.getStringCellValue(), 
		        				subCategoryEnCell.getStringCellValue(),
		        				eventNameEnCell.getStringCellValue()));
		        		
		        		String calendarNameTurkish = StringUtils.trim(categoryTrCell.getStringCellValue());
		        		String calendarNameEnglish = StringUtils.trim(categoryEnCell.getStringCellValue());
		        		
		        		BeOneCalendar cal = new BeOneCalendar();
//		        		cal.setCalendarName(calendarName);
		        		cal.setColorCode(BeOneCalendarUtil.getOrGenerateColorCode(categoryTrCell.getStringCellValue()));
		        		// try adding the calendar if it does not exist.
		        		// it doesn't cause any issue when called
		        		// this assures non-existing calendars created in advance
		        		BeOneCalendar insertedOrExistingCalendar = 
		        				calendarService.addCalendarIfNotExistsOrReturn(cal, calendarNameTurkish);
		        		
		        		BeOneCalendarTranslation transTr = new BeOneCalendarTranslation();
		        		transTr.setCalendarId(insertedOrExistingCalendar.getCalendarId());
		    			transTr.setLanguageId(BeOneLanguage.TURKISH.ordinal());
		    			transTr.setTransName(calendarNameTurkish);
		    			transTr.setCalendarId(insertedOrExistingCalendar.getCalendarId());
		    			calendarService.addTranslationIfNotExists(transTr);
		    			
		    			BeOneCalendarTranslation transEn = new BeOneCalendarTranslation();
		    			transEn.setCalendarId(insertedOrExistingCalendar.getCalendarId());
		    			transEn.setLanguageId(BeOneLanguage.ENGLISH.ordinal());
		    			transEn.setTransName(calendarNameEnglish);
		    			transEn.setCalendarId(insertedOrExistingCalendar.getCalendarId());
		    			calendarService.addTranslationIfNotExists(transEn);
		        		
//		        		// now get the calendar item
//		        		BeOneCalendar insertedOrExistingCalendar = 
//		        				calendarService.getCalendarByName(calendarName, i_languageId);
		        		
		        		// assuming the non-existing calendar is created and the pre-existing
		        		// calendar retrieved, we add that one to the list for later usage
		        		calendars.add(insertedOrExistingCalendar);
		        		
		        		logger.debug("Now adding the subcategory of the calendar");
		        		
		        		String subCategoryNameTr = StringUtils.trim(subCategoryTrCell.getStringCellValue());
		        		String subCategoryNameEn = StringUtils.trim(subCategoryEnCell.getStringCellValue());
		        		BeOneCalendarSubCategory subCategory = new BeOneCalendarSubCategory();
		        		subCategory.setCalendar(insertedOrExistingCalendar);
//		        		subCategory.setCalendarSubCategory(subCategoryName);
//		        		subCategory.setDescription("Initial content. Not taken from Excel file.");
		        		BeOneCalendarSubCategory insertedOrExistingSubCategory = 
		        				subcategoryService.addSubCategoryIfNotExists(subCategory, subCategoryNameTr);
		        		
//		        		BeOneCalendarSubCategory insertedOrExistingSubCategory =
//		        				subcategoryService.getSubCategoryByCalendarAndName(subCategory);
		        		
		        		BeOneCalendarSubCategoryTranslation subCatTransTr = new BeOneCalendarSubCategoryTranslation();
		        		subCatTransTr.setLanguageId(BeOneLanguage.TURKISH.ordinal());
		        		subCatTransTr.setDescriptionTrans("Inital content. Not taken from Excel file.");
		        		subCatTransTr.setCalendarSubCategoryTrans(subCategoryNameTr);
		        		subCatTransTr.setSubcategoryId(insertedOrExistingSubCategory.getSubcategoryId());
		        		subcategoryService.addTranslationIfNotExists(subCatTransTr);
		        		
		        		BeOneCalendarSubCategoryTranslation subCatTransEn = new BeOneCalendarSubCategoryTranslation();
		        		subCatTransEn.setLanguageId(BeOneLanguage.ENGLISH.ordinal());
		        		subCatTransEn.setDescriptionTrans("Inital content. Not taken from Excel file.");
		        		subCatTransEn.setCalendarSubCategoryTrans(subCategoryNameEn);
		        		subCatTransEn.setSubcategoryId(insertedOrExistingSubCategory.getSubcategoryId());
		        		subcategoryService.addTranslationIfNotExists(subCatTransEn);
		        		
		        		logger.debug("Iterating through the cells to add the events");

		        		// events might occur on multiple days in different periods
		        		int daysOfEvent = 0;
		        		for(int i=columnIndexWhereDatesStart; i<currentRow.getLastCellNum(); i++) {
		        			logger.debug(String.format("  Cell(%d ; %d)", rowIndex, i));
		        			daysOfEvent++;
		        			
		        			logger.debug("  Cell type: " + currentRow.getCell(i).getCellType());
		        			logger.debug("  Cell value: " + currentRow.getCell(i).toString());
		        			
			        		if(currentRow.getCell(i).getCellType() == Cell.CELL_TYPE_STRING ||
			        			currentRow.getCell(i).getCellType() == Cell.CELL_TYPE_NUMERIC) {
			        			
			        			logger.debug("Event cell("+rowIndex+","+i+") value: " + currentRow.getCell(i).toString());
			        			
			        			Date dateOfTheEventFromHeader = columnDateMapping.get(""+i);
			        			Calendar convertedDateOfTheEventFromHeader = Calendar.getInstance();
			        			convertedDateOfTheEventFromHeader.setTime(dateOfTheEventFromHeader);
			        			
			        			String cellValueOfEventDate = "";
			        			if(currentRow.getCell(i).getCellType() == Cell.CELL_TYPE_STRING) {
			        				cellValueOfEventDate = currentRow.getCell(i).getStringCellValue();
			        				logger.debug("- String value of the cell is: " + cellValueOfEventDate);
			        			} else if(currentRow.getCell(i).getCellType() == Cell.CELL_TYPE_NUMERIC) {
			        				double numericValue = currentRow.getCell(i).getNumericCellValue();
			        				Date dateValue = currentRow.getCell(i).getDateCellValue();
			        				logger.debug("- Numeric value of the cell is: " + numericValue);
			        				logger.debug("- Date    value of the cell is: " + dateValue);
			        				
			        				if(((int)numericValue) == 0 || numericValue < 1) {
			        					// then it is a date field, containing a value for: Sun Dec 31 03:59:00 CET 1899
			        					// we need to extract the time portion out of it and determine the time for the event
			        					currentCalendarInLocation.setTime(dateValue);
			        					int hour = currentCalendarInLocation.get(Calendar.HOUR_OF_DAY);
			        					int minute = currentCalendarInLocation.get(Calendar.MINUTE);
			        					cellValueOfEventDate = 
			        							"" + 
			        							(hour < indexOfTimeZoneCell ? "0"+hour : hour) + 
			        							":" +
			        							(minute < indexOfTimeZoneCell ? "0"+minute : minute)+
			        							":00";
			        				} else {
			        					// then it is a numeric field containing a value like 1 or 2
			        					cellValueOfEventDate = "" +(int) numericValue;
			        				}
			        			} else {
			        				logger.debug(String.format(" Celltype is not acceptable of row %d column: %s", 
		        						rowIndex, 
		        						currentRow.getCell(i).getAddress().toString()));
			        				resultMessages.add(String.format(" Celltype is not acceptable of row %d column: %s", 
		        						rowIndex, 
		        						currentRow.getCell(i).getAddress().toString()));
									continue;
			        			}
			        			
			        			// Sat Dec 31 00:00:00 CET 2016
			        			SimpleDateFormat dayFormat = new SimpleDateFormat("EEE, MMM d HH:mm:ss z yyyy");
			        			SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			        			java.util.Date parsedDateTime;
								
								BeOneCalendarEvent event = new BeOneCalendarEvent();
								if("1".equals(cellValueOfEventDate)) {
									event.setEventType("FullDayEvent");
				        			event.setEventDate(new Timestamp(dateOfTheEventFromHeader.getTime()));
								} else {
									String dateToUse = ""+
										convertedDateOfTheEventFromHeader.get(Calendar.YEAR) + "-" +
										((convertedDateOfTheEventFromHeader.get(Calendar.MONTH)+1) < indexOfTimeZoneCell 
											? ("0"+(convertedDateOfTheEventFromHeader.get(Calendar.MONTH)+1))
											: (convertedDateOfTheEventFromHeader.get(Calendar.MONTH)+1)
										) +"-"+
										(convertedDateOfTheEventFromHeader.get(Calendar.DAY_OF_MONTH) < indexOfTimeZoneCell
											? ("0"+convertedDateOfTheEventFromHeader.get(Calendar.DAY_OF_MONTH))
											: (convertedDateOfTheEventFromHeader.get(Calendar.DAY_OF_MONTH))
										);
									
									try {
										parsedDateTime = timeFormat.parse(dateToUse + " " + cellValueOfEventDate);
									} catch (ParseException e) {
										logger.debug("Row: "+rowIndex + " Time cannot be parsed: " + dateToUse + " " + cellValueOfEventDate);
										resultMessages.add("Row: "+rowIndex + " Time cannot be parsed: " + dateToUse + " " + cellValueOfEventDate);
										continue;
									}
									
									event.setEventType("TimeEvent");
				        			event.setEventDate(new Timestamp(parsedDateTime.getTime()));
								}

				        		event.setSubCategory(insertedOrExistingSubCategory);
				        		event.setEventLocation(eventLocationCell.getStringCellValue());
				        		String eventTrName = StringUtils.trim(eventNameTrCell.getStringCellValue());
				        		String eventEnName = StringUtils.trim(eventNameEnCell.getStringCellValue());
				        		calendarEventService.insertOrUpdateEvent(event, eventTrName, eventEnName);
				        		
//			        			event.setEventName(eventName);
//			        			if(eventDescriptionCell.getCellType() == Cell.CELL_TYPE_STRING && eventDescriptionCell.getStringCellValue() != null &&
//		        					eventDescriptionCell.getStringCellValue() != "") {
//			        				event.setEventDescription(eventDescriptionCell.getStringCellValue());
//			        			} else if (eventDescriptionCell.getCellType() == Cell.CELL_TYPE_NUMERIC){
//			        				event.setEventDescription(""+eventDescriptionCell.getNumericCellValue());
//			        			} else {
//			        				event.setEventDescription("Explanation missing");
//			        			}
//			        			
//			        			// get the +C number to calculate the image
//			        			if(plusCNumberToMakeFilenameCell.getCellType() == Cell.CELL_TYPE_STRING && plusCNumberToMakeFilenameCell.getStringCellValue() != null &&
//			        					plusCNumberToMakeFilenameCell.getStringCellValue() != "") {
//			        				event.setEventHappeningPhotoFilename(""+plusCNumberToMakeFilenameCell.getStringCellValue());
//			        			} else if (plusCNumberToMakeFilenameCell.getCellType() == Cell.CELL_TYPE_NUMERIC){
//			        				event.setEventHappeningPhotoFilename(""+plusCNumberToMakeFilenameCell.getNumericCellValue());
//			        			} else {
//			        				event.setEventHappeningPhotoFilename("default"+(i%2)+".jpg");
//			        			}
				        		String designNumberTr = GeneralUtils.trimAndGetStringValue(plusCDesignNumberTrCell);
				        		String eventLocationTr = GeneralUtils.trimAndGetStringValue(eventLocationCell);
				        		String plusCMessageNumberTr = GeneralUtils.trimAndGetStringValue(plusCMessageNumberTrCell);
				        		String plusCToAppTr = GeneralUtils.trimAndGetStringValue(plusC2AppTrCell);
				        		String plusCToPrintTr = GeneralUtils.trimAndGetStringValue(plusC2PrintTrCell);
				        		String plusCToWallTr = GeneralUtils.trimAndGetStringValue(plusC2WallTrCell);
				        		String plusCToWebTr = GeneralUtils.trimAndGetStringValue(plusC2WebTrCell);
				        		String eventDescriptionTr = GeneralUtils.trimAndGetStringValue(eventDescriptionTrCell);
				        		
								BeOneCalendarEventTranslation eventTransTr = new BeOneCalendarEventTranslation();
								eventTransTr.setLanguageId(BeOneLanguage.TURKISH.ordinal());
								eventTransTr.setEventName(eventTrName);
								eventTransTr.setDesignNumber(designNumberTr);
								eventTransTr.setEventLocation(eventLocationTr);
								eventTransTr.setPlusCMessageNumber(plusCMessageNumberTr);
								eventTransTr.setPlusCToApp(plusCToAppTr);
								eventTransTr.setPlusCToPrint(plusCToPrintTr);
								eventTransTr.setPlusCToWall(plusCToWallTr);
								eventTransTr.setPlusCToWeb(plusCToWebTr);
								eventTransTr.setEventId(event.getEventId());
								eventTransTr.setEventDescription(eventDescriptionTr);
								calendarEventService.insertOrUpdateEventTranslation(eventTransTr);

								
								String designNumberEn = GeneralUtils.trimAndGetStringValue(plusCDesignNumberEnCell);
				        		String eventLocationEn = GeneralUtils.trimAndGetStringValue(eventLocationCell);
				        		String plusCMessageNumberEn = GeneralUtils.trimAndGetStringValue(plusCMessageNumberEnCell);
				        		String plusCToAppEn = GeneralUtils.trimAndGetStringValue(plusC2AppEnCell);
				        		String plusCToPrintEn = GeneralUtils.trimAndGetStringValue(plusC2PrintEnCell);
				        		String plusCToWallEn = GeneralUtils.trimAndGetStringValue(plusC2WallEnCell);
				        		String plusCToWebEn = GeneralUtils.trimAndGetStringValue(plusC2WebEnCell);
				        		String eventDescriptionEn = GeneralUtils.trimAndGetStringValue(eventDescriptionEnCell);
				        		
								BeOneCalendarEventTranslation eventTransEn = new BeOneCalendarEventTranslation();
								eventTransEn.setLanguageId(BeOneLanguage.ENGLISH.ordinal());
								eventTransEn.setEventName(eventEnName);
								eventTransEn.setDesignNumber(designNumberEn);
								eventTransEn.setEventLocation(eventLocationEn);
								eventTransEn.setPlusCMessageNumber(plusCMessageNumberEn);
								eventTransEn.setPlusCToApp(plusCToAppEn);
								eventTransEn.setPlusCToPrint(plusCToPrintEn);
								eventTransEn.setPlusCToWall(plusCToWallEn);
								eventTransEn.setPlusCToWeb(plusCToWebEn);
								eventTransEn.setEventId(event.getEventId());
								eventTransEn.setEventDescription(eventDescriptionEn);
								calendarEventService.insertOrUpdateEventTranslation(eventTransEn);
								
				        		resultMessages.add("Row "+rowIndex + " Calendar and event added");
			        		}
			        	}
		        		
		        		if(daysOfEvent == 0) {
		        			resultMessages.add(""+rowIndex + " does not have any date or time set for the event.");
		        			rowIndex++;
		        			continue;
		        		}
		        	} else {
		        		logger.debug("Skipping line because it is not operable: " + rowIndex+" Calendar Data is not valid.");
		        		resultMessages.add(""+rowIndex + " Skipping line because it is not operable. Calendar Data is not valid.");
		        	}
		        	
		        	rowIndex++;
		        }
		        
		        workbook.close();
		        file.getInputStream().close();
				
			} catch (FileNotFoundException e) {
				logger.error("There is an error occured during reading of uploaded file", e);
			} catch (IOException e) {
				logger.error("There is an error occured during parsing of uploaded file", e);
			} catch(ControllerServiceException e) {
				logger.error("Exception occured during data upload", e);
			}
		}
		
		model.addAttribute("resultMessages", resultMessages);
		
		logger.debug("upload_calendar-post exiting");
		return "/dataupload";
	}
	
}
