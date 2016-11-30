package com.beone.webapp.utils;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.UserAnswer;
import com.beone.webapp.services.v1.model.UserAnswerTO;

public class BeOneUserAnswerUtils {

	public static UserAnswer convertFromTO(UserAnswerTO answer) {
		UserAnswer converted = new UserAnswer();
		
		converted.setQuestionId(answer.getQuestionId());
		converted.setSelectedAnswerId(answer.getSelectedAnswerId());
		converted.setUserId(answer.getUserId());
		converted.setUserAnswerText(answer.getUserAnswerText());
		converted.setSelectedAnswerId(answer.getSelectedAnswerId());
		converted.setUserAnswerGivenDate(answer.getUserAnswerGivenDate());
		
		return converted;
	}
	
	public static UserAnswerTO convertToTO(UserAnswer answer){
		UserAnswerTO converted = new UserAnswerTO();
		
		converted.setQuestionId(answer.getQuestionId());
		converted.setSelectedAnswerId(answer.getSelectedAnswerId());
		converted.setUserAnswerId(answer.getUserAnswerId());
		converted.setUserAnswerText(answer.getUserAnswerText());
		converted.setUserId(answer.getUserId());
		converted.setUserAnswerGivenDate(answer.getUserAnswerGivenDate());

		return converted;
	}
	
	public static Set<UserAnswerTO> convertToTOSet(Set<UserAnswer> answers){
		Set<UserAnswerTO> converted = new HashSet<UserAnswerTO>();
		for(UserAnswer answer: answers){
			converted.add(convertToTO(answer));
		}
		return converted;
	}

}
