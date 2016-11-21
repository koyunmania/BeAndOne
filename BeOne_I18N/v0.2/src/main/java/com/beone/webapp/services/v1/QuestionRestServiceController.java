package com.beone.webapp.services.v1;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.TimeZone;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.beone.webapp.controller.AbstractController;
import com.beone.webapp.controller.service.QuestionService;
import com.beone.webapp.model.Question;
import com.beone.webapp.model.User;
import com.beone.webapp.model.exceptions.CodedException;
import com.beone.webapp.services.v1.model.UserAnswerTO;

@RestController
public class QuestionRestServiceController extends AbstractController{
	
	private static final Logger logger = LoggerFactory.getLogger(QuestionRestServiceController.class);
	
	@Autowired
	private QuestionService questionService;
	
	@RequestMapping(
			value = "/api/v1/questions",
			produces = "application/json",
			method = RequestMethod.GET
			)
	private RestResult getAllActiveQuestions() {
		RestResult result = new RestResult();
		logger.info("QuestionRestServiceController: getAllActiveQuestions is called");
		
		List<Question> allActiveQuestions = null;
		
		try {
			allActiveQuestions = questionService.getAllActiveQuestions();
			if(allActiveQuestions == null) {
				result.setData(null);
				result.setMessage("Null data returned from questionService");
				result.setStatus(false);
			}
			else {
				result.setData(allActiveQuestions);
				result.setMessage("Data returned from getAllActiveQuestions");
				result.setStatus(true);
			}
		} catch (Exception e) {
			logger.error("QuestionRestServiceController: getAllActiveQuestions error!", e);
			result.setData(null);
			result.setMessage("AllActiveQuestions could not be loaded!");
			result.setStatus(false);
		}
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/answer",
			produces = "application/json",
			method = RequestMethod.POST
			)
	public RestResult giveAnswerToQuestion(@RequestBody UserAnswerTO answer, TimeZone userTimezone) {
		RestResult result = new RestResult();
		
		try {
			currentUser = getCurrentAuthUser();
			UserAnswerTO savedAnswer = questionService.giveAnswerToQuestion(answer, currentUser, userTimezone);
			result.setData(savedAnswer);
			result.setMessage("Answer saved");
			result.setStatus(true);
		} catch (CodedException e) {
			logger.error("QuestionRestServiceController: giveAnswerToQuestion error!", e);
			result.setData(null);
			result.setMessage("Ann error occured during setting the answer");
			result.setStatus(false);
		}
		
		return result;
	}
	
	@RequestMapping(
			value = "/api/v1/answer/{answerId}",
			produces = "application/json",
			method = RequestMethod.DELETE
			)
	public RestResult deleteAnswer(@PathVariable(value="answerId") String answerId) {
		RestResult result = new RestResult();
		
		try {
			currentUser = getCurrentAuthUser();
			
			questionService.deleteAnswerIfItIsMine(answerId, currentUser);
			result.setData(null);
			result.setMessage("Answer deleted");
			result.setStatus(true);
		} catch (CodedException e) {
			logger.error("An error occured during deleting the answer", e);
			result.setData(null);
			result.setMessage("Ann error occured during deleting the answer");
			result.setStatus(false);
		}
		
		return result;
	}
	
	/*
	@RequestMapping(
			value = "/api/v1/answer/",
			produces = "application/json",
			method = RequestMethod.GET
			)
	public RestResult getUserAnswers(){
		RestResult result = new RestResult();
		logger.info("QuestionRestServiceController: getUserAnswers is called...");
		
		Set<UserAnswerTO> answers = new HashSet<UserAnswerTO>();
		try{
			User currentUser = getCurrentAuthUser();
			
			answers = questionService.getUserAnswers(currentUser);
			result.setData(answers);
			result.setMessage("QuestionRestServiceController: UserAnswers returned successfully...");
			result.setStatus(true);
		} catch (Exception e) {
			result.setData(null);
			result.setMessage("QuestionRestServiceController: getUserAnswers error!");
			result.setStatus(false);
		}
		return result;
	}
	*/
	
	@RequestMapping(
			value = "/api/v1/questionAnswers/{questionCode}/{userdate}",
			produces = "application/json",
			method = RequestMethod.GET
			)
	public RestResult getUserAnswersForQuestion(
			@PathVariable(value="questionCode") String questionCode,
			@PathVariable(value="userdate") String userdate){
		RestResult result = new RestResult();
		logger.info("QuestionRestServiceController: getUserAnswersForQuestion is called...");
		
		Set<UserAnswerTO> answers = new HashSet<UserAnswerTO>();
		try{
			User currentUser = getCurrentAuthUser();
			
			int i_questionCode = -1;
			try {
				i_questionCode = Integer.parseInt(questionCode);
			} catch(NumberFormatException e) {
				logger.warn("Given questionCode is not a number: " + questionCode);
				result.setData(null);
				result.setMessage("Invalid value for questionCode given");
				result.setStatus(false);
				return result;
			}
			
			Timestamp t_userDate = null;
			SimpleDateFormat df = null;
			java.util.Date parsedDate = null;
			try {
				df = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				parsedDate = df.parse(userdate+" 00:00:00");
				t_userDate = new Timestamp(parsedDate.getTime());
			} catch(IllegalArgumentException e) {
				logger.warn("Given user date is not a date: " + userdate);
				result.setData(null);
				result.setMessage("Invalid value for userdate given");
				result.setStatus(false);
				return result;
			}
			
			answers = questionService.getUserAnswersForQuestionAndDate(currentUser, i_questionCode, t_userDate);
			result.setData(answers);
			result.setMessage("QuestionRestServiceController: getUserAnswersForQuestion returned successfully...");
			result.setStatus(true);
		} catch (Exception e) {
			logger.error("QuestionRestServiceController: getUserAnswersForQuestion error!", e);
			result.setData(null);
			result.setMessage("QuestionRestServiceController: getUserAnswersForQuestion error!");
			result.setStatus(false);
		}
		return result;
	}
}
