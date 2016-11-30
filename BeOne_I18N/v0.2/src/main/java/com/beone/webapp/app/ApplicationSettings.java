package com.beone.webapp.app;

import java.util.HashMap;

public class ApplicationSettings {
	public static final String PHOTO_ALBUMS_UPLOAD_LOCATION = "photoAlbumsUploadLocation";

	public static final String PLUS_C_PHOTOS_FOLDER_NAME = "plusCPhotosFolderName";
	
	private HashMap<String, Object> settingsMap;

	public HashMap<String, Object> getSettingsMap() {
		return settingsMap;
	}

	public void setSettingsMap(HashMap<String, Object> settingsMap) {
		this.settingsMap = settingsMap;
	}
}
