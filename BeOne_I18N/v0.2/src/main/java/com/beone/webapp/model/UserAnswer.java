package com.beone.webapp.model;

import java.sql.Timestamp;

public class UserAnswer {
	private int userAnswerId;
	private int questionId;
	private String userAnswerText;
	private int selectedAnswerId;
	private int userId;
	private Timestamp userAnswerGivenDate;
	
	public int getUserAnswerId() {
		return userAnswerId;
	}
	public void setUserAnswerId(int userAnswerId) {
		this.userAnswerId = userAnswerId;
	}
	public String getUserAnswerText() {
		return userAnswerText;
	}
	public void setUserAnswerText(String userAnswerText) {
		this.userAnswerText = userAnswerText;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public int getSelectedAnswerId() {
		return selectedAnswerId;
	}
	public void setSelectedAnswerId(int selectedAnswerId) {
		this.selectedAnswerId = selectedAnswerId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Timestamp getUserAnswerGivenDate() {
		return userAnswerGivenDate;
	}
	public void setUserAnswerGivenDate(Timestamp userAnswerGivenDate) {
		this.userAnswerGivenDate = userAnswerGivenDate;
	}
}
