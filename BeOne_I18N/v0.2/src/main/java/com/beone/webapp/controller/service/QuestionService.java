package com.beone.webapp.controller.service;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;
import java.util.TimeZone;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import com.beone.webapp.model.PossibleAnswer;
import com.beone.webapp.model.Question;
import com.beone.webapp.model.StatusCode;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserAnswer;
import com.beone.webapp.model.exceptions.CodedException;
import com.beone.webapp.persistence.PossibleAnswerDao;
import com.beone.webapp.persistence.QuestionDao;
import com.beone.webapp.persistence.UserAnswerDao;
import com.beone.webapp.services.v1.model.UserAnswerTO;
import com.beone.webapp.utils.BeOneUserAnswerUtils;
import com.beone.webapp.utils.GeneralUtils;

public class QuestionService {
	
	@Autowired
	private QuestionDao questionDao;
	
	@Autowired
	private UserAnswerDao userAnswerDao;
	
	@Autowired
	private PossibleAnswerDao possibleAnswerDao;

	public QuestionDao getQuestionDao() {
		return questionDao;
	}

	public void setQuestionDao(QuestionDao questionDao) {
		this.questionDao = questionDao;
	}

	public UserAnswerDao getUserAnswerDao() {
		return userAnswerDao;
	}

	public void setUserAnswerDao(UserAnswerDao userAnswerDao) {
		this.userAnswerDao = userAnswerDao;
	}

	public PossibleAnswerDao getPossibleAnswerDao() {
		return possibleAnswerDao;
	}

	public void setPossibleAnswerDao(PossibleAnswerDao possibleAnswerDao) {
		this.possibleAnswerDao = possibleAnswerDao;
	}

	@Transactional
	public List<Question> getAllActiveQuestions() {
		List<Question> activeQuestions = questionDao.getAllActiveQuestions();
		
		return activeQuestions;
	}

	@Transactional
	public UserAnswerTO giveAnswerToQuestion(UserAnswerTO answer, User user, TimeZone userTimezone) throws CodedException {
		UserAnswerTO result = null;
		//Question q = questionDao.findByKey(answer.getQuestionId());
		Question q = questionDao.findByQuestionCode(answer.getQuestionCode());
		if(q == null) {
			throw new CodedException(StatusCode.QUESTION_DOES_NOT_EXIST, "Given question does not exist");
		} else {
			// if the question type is multiple-choice, then check whether the provided answer is valid
			if(q.getQuestionTypeId() == Question.QUESTION_TYPE_CHOICE) {
				PossibleAnswer possibleAnswer = possibleAnswerDao.findByKey(answer.getSelectedAnswerId());
				if(possibleAnswer == null) {
					throw new CodedException(StatusCode.PROVIDED_ANSWER_IS_NOT_VALID, 
						"The anwser for the question is not valid");
				} else if(possibleAnswer.getQuestionId() != answer.getQuestionId()) {
					throw new CodedException(StatusCode.ANSWER_DOES_NOT_MATCH_TO_QUESTION, 
						"Given answer value does not match to the expected question answers");
				} else {
					UserAnswer userAnswer = BeOneUserAnswerUtils.convertFromTO(answer);
					userAnswer.setUserId(user.getUserId());
					userAnswer.setUserAnswerGivenDate(GeneralUtils.getCurrentDaysTimestamp(userTimezone));
					userAnswer.setQuestionId(q.getQuestionId());
					userAnswerDao.insertNew(userAnswer);
					result = BeOneUserAnswerUtils.convertToTO(userAnswer);
				}
			} else if(q.getQuestionTypeId() == Question.QUESTION_TYPE_SELF_ANSWER) {
				UserAnswer userAnswer = BeOneUserAnswerUtils.convertFromTO(answer);
				userAnswer.setUserId(user.getUserId());
				userAnswer.setUserAnswerGivenDate(GeneralUtils.getCurrentDaysTimestamp(userTimezone));
				userAnswer.setQuestionId(q.getQuestionId());
				userAnswerDao.insertNew(userAnswer);
				result = BeOneUserAnswerUtils.convertToTO(userAnswer);
			} else {
				throw new CodedException(StatusCode.PROVIDED_QUESTION_TYPE_NOT_VALID, "Question type is not valid. Contact Administrator");
			}
		}
		
		return result;
	}

	@Transactional
	public void deleteAnswerIfItIsMine(String answerId, User currentUser) throws CodedException {
		int i_answerId = 0;
		
		try {
			i_answerId = Integer.parseInt(answerId);
		} catch(NumberFormatException e) {
			throw new CodedException(StatusCode.GIVEN_ID_IS_NOT_NUMBER, "Provided answer ID is not a number");
		}
		
		UserAnswer ans = userAnswerDao.findByKey(i_answerId);
		if(ans == null) {
			throw new CodedException(StatusCode.ANSWER_DOES_NOT_EXIST, "There is no answer with this ID");
		} else {
			if(ans.getUserId() != currentUser.getUserId()) {
				throw new CodedException(StatusCode.ANSWER_DOES_NOT_BELONG_TO_USER, "The user tried to delete an answer of other user");
			} else {
				userAnswerDao.delete(ans);
			}
		}
	}
	
	@Transactional
	public Set<UserAnswerTO> getUserAnswers(User user){
		return BeOneUserAnswerUtils.convertToTOSet(userAnswerDao.getAllSorted(null, null, user));
	}

	@Transactional
	public Set<UserAnswerTO> getUserAnswersForQuestionAndDate(User currentUser,
			int questionCode, Timestamp userDate) {
		Set<UserAnswer> userAnswers = 
				userAnswerDao.findAnswersOfUserToQuestionOnDate(currentUser, questionCode, userDate);
		
		Set<UserAnswerTO> converted = BeOneUserAnswerUtils.convertToTOSet(userAnswers);
		return converted;
	}
}
