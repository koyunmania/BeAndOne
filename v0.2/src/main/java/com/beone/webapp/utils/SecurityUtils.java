package com.beone.webapp.utils;

import java.util.UUID;

public class SecurityUtils {

	public static String generateToken() {
		UUID uid = UUID.randomUUID();
		return uid.toString();
	}

}
