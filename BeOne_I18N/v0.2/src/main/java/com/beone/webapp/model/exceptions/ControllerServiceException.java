package com.beone.webapp.model.exceptions;

import com.beone.webapp.model.StatusCode;

public class ControllerServiceException extends CodedException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8895161935879109203L;

	
	public ControllerServiceException(StatusCode code, String message) {
		super(code, message);
	}

}
