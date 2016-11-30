package com.beone.webapp.controller;

import java.io.IOException;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.social.ResourceNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beone.webapp.app.ApplicationSettings;
import com.beone.webapp.controller.service.UserAlbumService;
import com.beone.webapp.model.User;

@Controller
public class ProfileController extends AbstractController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProfileController.class);
	
	@Autowired
	private UserAlbumService albumService;
	
	public UserAlbumService getAlbumService() {
		return albumService;
	}

	public void setAlbumService(UserAlbumService albumService) {
		this.albumService = albumService;
	}

	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String profile(Locale locale, Model model) {
		logger.info("profile-get is called");
		
		
		User usr = getCurrentAuthUser();
		
		if(usr != null) {
			model.addAttribute("username", usr.getUsername());
		} else {
			model.addAttribute("username", "Not authenticated");
		}
		
		return "profile";
	}
	
	@ResponseBody
	@RequestMapping(value = "/profile/photo", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
	public byte[] getProfilePhoto(Locale locale, Model model) {
		logger.info("getProfilePhoto-get is called");
		
		currentUser = getCurrentAuthUser();
		
		String photoAlbumsLocation = (String)applicationSettings
    			.getSettingsMap()
    			.get(ApplicationSettings.PHOTO_ALBUMS_UPLOAD_LOCATION);
		
		byte[] imageByte = null;
		try {
			imageByte = albumService.getProfileImage(currentUser, photoAlbumsLocation);
			if(imageByte == null || imageByte.length == 0) {
				throw new ResourceNotFoundException("beone", "Image is not found");
			}
		} catch (IOException e) {
			logger.error("There was an error during retrieval of profile image", e);
		}
		
		return imageByte;
	}
}
