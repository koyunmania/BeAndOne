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

import com.beone.webapp.app.BeOneConnectController;
import com.beone.webapp.controller.service.BeOneCalendarEventService;
import com.beone.webapp.controller.service.BeOneCalendarService;
import com.beone.webapp.controller.service.BeOneCalendarSubCategoryService;
import com.beone.webapp.controller.service.CityService;
import com.beone.webapp.controller.service.CountryService;
import com.beone.webapp.model.BeOneCalendar;
import com.beone.webapp.model.BeOneCalendarEvent;
import com.beone.webapp.model.BeOneCalendarSubCategory;
import com.beone.webapp.model.City;
import com.beone.webapp.model.Country;
import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.exceptions.ControllerServiceException;
import com.beone.webapp.utils.BeOneCalendarUtil;

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
			Locale locale,
			Model model) {
		logger.info("upload_calendar-post is called");
		
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
		int columnIndexWhereDatesStart = 20;
		int columnIndexWherePlusCResides = 15;
		int columnIndexWhereGoogleIt = 16;
		
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
		        
		        while (iterator.hasNext()) {
		        	Row currentRow = iterator.next();
		        	logger.debug("Retrieved the next line. ");
		        	
		        	Cell timeZoneCell = currentRow.getCell(10);
		        	Cell categoryCell = currentRow.getCell(6);
		        	Cell subCategoryCell = currentRow.getCell(7);
		        	Cell eventNameCell = currentRow.getCell(8);
		        	Cell eventLocationCell = currentRow.getCell(10);
//		        	Cell i love u selcuk beyhan yakashikular
		        	Cell eventDescriptionCell = currentRow.getCell(columnIndexWherePlusCResides);
		        	Cell plusCNumberToMakeFilenameCell = currentRow.getCell(14);
		        	
		        	logger.debug(String.format("Retrieved line category: %s, subCategory: %s, eventName: %s, location: %s", 
		        			categoryCell.toString(),
		        			subCategoryCell.toString(),
		        			eventNameCell.toString(),
		        			eventLocationCell.toString()));
		        	
		        	if( timeZoneCell.getCellType() == Cell.CELL_TYPE_STRING &&
		        		categoryCell.getCellType() == Cell.CELL_TYPE_STRING &&
		        		subCategoryCell.getCellType() == Cell.CELL_TYPE_STRING &&
		        		eventNameCell.getCellType() == Cell.CELL_TYPE_STRING) {
		        		
		        		logger.debug(String.format("Initializing the calendar category: %s subcategory: %s eventName: %s", 
		        				categoryCell.getStringCellValue(), 
		        				subCategoryCell.getStringCellValue(),
		        				eventNameCell.getStringCellValue()));
		        		
		        		String calendarName = StringUtils.trim(categoryCell.getStringCellValue());
		        		
		        		BeOneCalendar cal = new BeOneCalendar();
		        		cal.setCalendarName(calendarName);
		        		cal.setColorCode(BeOneCalendarUtil.getOrGenerateColorCode(categoryCell.getStringCellValue()));
		        		cal.setCalendarIcon(BeOneCalendarUtil.getOrGenerateCalendarIcon(categoryCell.getStringCellValue()));
		        		// try adding the calendar if it does not exist.
		        		// it doesn't cause any issue when called
		        		// this assures non-existing calendars created in advance
		        		calendarService.addCalendarIfNotExists(cal);
		        		
		        		// now get the calendar item
		        		BeOneCalendar insertedOrExistingCalendar = calendarService.getCalendarByName(calendarName);
		        		
		        		// assuming the non-existing calendar is created and the pre-existing
		        		// calendar retrieved, we add that one to the list for later usage
		        		calendars.add(insertedOrExistingCalendar);
		        		
		        		logger.debug("Now adding the subcategory of the calendar");
		        		
		        		String subCategoryName = StringUtils.trim(subCategoryCell.getStringCellValue());
		        		BeOneCalendarSubCategory subCategory = new BeOneCalendarSubCategory();
		        		subCategory.setCalendar(insertedOrExistingCalendar);
		        		subCategory.setCalendarSubCategory(subCategoryName);
		        		subCategory.setDescription("Initial content. Not taken from Excel file.");
		        		subcategoryService.addSubCategoryIfNotExists(subCategory);
		        		
		        		BeOneCalendarSubCategory insertedOrExistingSubCategory =
		        				subcategoryService.getSubCategoryByCalendarAndName(subCategory);
		        		
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
			        							(hour < 10 ? "0"+hour : hour) + 
			        							":" +
			        							(minute < 10 ? "0"+minute : minute)+
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
										((convertedDateOfTheEventFromHeader.get(Calendar.MONTH)+1) < 10 
											? ("0"+(convertedDateOfTheEventFromHeader.get(Calendar.MONTH)+1))
											: (convertedDateOfTheEventFromHeader.get(Calendar.MONTH)+1)
										) +"-"+
										(convertedDateOfTheEventFromHeader.get(Calendar.DAY_OF_MONTH) < 10
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

								String eventName = StringUtils.trim(eventNameCell.getStringCellValue());
				        		event.setSubCategory(insertedOrExistingSubCategory);
				        		event.setEventLocation(eventLocationCell.getStringCellValue());
			        			event.setEventName(eventName);
			        			if(eventDescriptionCell.getCellType() == Cell.CELL_TYPE_STRING && eventDescriptionCell.getStringCellValue() != null &&
		        					eventDescriptionCell.getStringCellValue() != "") {
			        				event.setEventDescription(eventDescriptionCell.getStringCellValue());
			        			} else if (eventDescriptionCell.getCellType() == Cell.CELL_TYPE_NUMERIC){
			        				event.setEventDescription(""+eventDescriptionCell.getNumericCellValue());
			        			} else {
			        				event.setEventDescription("Explanation missing");
			        			}
			        			
			        			
			        			// get the +C number to calculate the image
			        			if(plusCNumberToMakeFilenameCell.getCellType() == Cell.CELL_TYPE_STRING && plusCNumberToMakeFilenameCell.getStringCellValue() != null &&
			        					plusCNumberToMakeFilenameCell.getStringCellValue() != "") {
			        				event.setEventHappeningPhotoFilename(""+plusCNumberToMakeFilenameCell.getStringCellValue());
			        			} else if (plusCNumberToMakeFilenameCell.getCellType() == Cell.CELL_TYPE_NUMERIC){
			        				event.setEventHappeningPhotoFilename(""+plusCNumberToMakeFilenameCell.getNumericCellValue());
			        			} else {
			        				event.setEventHappeningPhotoFilename("default"+(i%2)+".jpg");
			        			}
				        		
				        		calendarEventService.insertOrUpdateEvent(event);
				        		
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
