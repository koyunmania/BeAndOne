package com.beone.webapp.model;

public class PossibleAnswer {
	private int possibleAnswerId;
	private int textLanguageId;
	private int questionId;
	private String translatedText;
	
	public int getPossibleAnswerId() {
		return possibleAnswerId;
	}
	public void setPossibleAnswerId(int possibleAnswerId) {
		this.possibleAnswerId = possibleAnswerId;
	}
	public int getTextLanguageId() {
		return textLanguageId;
	}
	public void setTextLanguageId(int textLanguageId) {
		this.textLanguageId = textLanguageId;
	}
	public String getTranslatedText() {
		return translatedText;
	}
	public void setTranslatedText(String translatedText) {
		this.translatedText = translatedText;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
}
