package com.beone.webapp.model.exceptions;

import com.beone.webapp.model.StatusCode;

public class CodedException extends Exception{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 3424248902027017098L;
	
	/**
	 * The status code for this exception
	 */
	private StatusCode statusCode;
	
	public CodedException(StatusCode code, String message) {
		super(message);
		statusCode = code;
	}

	public StatusCode getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(StatusCode statusCode) {
		this.statusCode = statusCode;
	}
}
