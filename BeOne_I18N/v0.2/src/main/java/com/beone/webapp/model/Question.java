package com.beone.webapp.model;

public class Question {
	public static final int QUESTION_TYPE_SELF_ANSWER = 1;
	public static final int QUESTION_TYPE_CHOICE = 2;
	
	private int questionId;
	private int questionTypeId;
	private int textLanguageId;
	private String questionTranslatedText;
	private PossibleAnswer[] possibleAnswers;
	private boolean isActive;
	private int questionCode;
	
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public int getQuestionTypeId() {
		return questionTypeId;
	}
	public void setQuestionTypeId(int questionTypeId) {
		this.questionTypeId = questionTypeId;
	}
	public int getTextLanguageId() {
		return textLanguageId;
	}
	public void setTextLanguageId(int textLanguageId) {
		this.textLanguageId = textLanguageId;
	}
	public String getQuestionTranslatedText() {
		return questionTranslatedText;
	}
	public void setQuestionTranslatedText(String questionTranslatedText) {
		this.questionTranslatedText = questionTranslatedText;
	}
	public PossibleAnswer[] getPossibleAnswers() {
		return possibleAnswers;
	}
	public void setPossibleAnswers(PossibleAnswer[] possibleAnswers) {
		this.possibleAnswers = possibleAnswers;
	}
	public boolean getIsActive() {
		return isActive;
	}
	public void setIsActive(boolean isActive) {
		this.isActive = isActive;
	}
	public int getQuestionCode() {
		return questionCode;
	}
	public void setQuestionCode(int questionCode) {
		this.questionCode = questionCode;
	}
}
