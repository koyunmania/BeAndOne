package com.beone.webapp.services.v1;

import java.io.IOException;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.social.ResourceNotFoundException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.beone.webapp.app.ApplicationSettings;
import com.beone.webapp.controller.AbstractController;
import com.beone.webapp.controller.service.UserAlbumService;

@RestController
public class PhotoRestServiceController extends AbstractController{
	private static final Logger logger = LoggerFactory.getLogger(ProfileServiceController.class);
	
	@Autowired
	private UserAlbumService photoAlbumService;
	
	public UserAlbumService getPhotoAlbumService() {
		return photoAlbumService;
	}

	public void setPhotoAlbumService(UserAlbumService photoAlbumService) {
		this.photoAlbumService = photoAlbumService;
	}



	@RequestMapping(value="/api/v1/profile/image", method=RequestMethod.POST)
    public RestResult handleFileUpload(@RequestParam("files") MultipartFile file) {
		logger.debug("handleFileUpload called");
		RestResult r = new RestResult();
		
		currentUser = getCurrentAuthUser();
		
        if (!file.isEmpty()) {
            try {
            	String photoAlbumsLocation = (String)applicationSettings
            			.getSettingsMap()
            			.get(ApplicationSettings.PHOTO_ALBUMS_UPLOAD_LOCATION);
            	
            	logger.debug("Configured photo albums location: " + photoAlbumsLocation);
            	
            	photoAlbumService.uploadProfilePhoto(photoAlbumsLocation, file, currentUser);
                
                r.setStatus(true);
        		r.setMessage("You successfully uploaded " + file.getOriginalFilename());
        		r.setData(null);
        		return r;
            } catch (Exception e) {
            	logger.error("Upload failed", e);
            	
            	r.setStatus(false);
        		r.setMessage("You failed to upload " + file.getOriginalFilename());
        		r.setData(null);
                return r;
            }
        } else {
        	r.setStatus(false);
    		r.setMessage("You failed to upload " + file.getOriginalFilename() + " because the file was empty.");
    		r.setData(null);
    		return r;
        }
    }
	
	@ResponseBody
	@RequestMapping(value = "/api/v1/plusc/photo/web/{plusCid}", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
	public byte[] getPlusCPhoto(@PathVariable(value="plusCid") String plusCid) {
		logger.info("getPlusCPhoto-get is called");
		
		currentUser = getCurrentAuthUser();
		
		String photoAlbumsLocation = (String)applicationSettings
    			.getSettingsMap()
    			.get(ApplicationSettings.PHOTO_ALBUMS_UPLOAD_LOCATION);
		String plusCPhotosFolderName = (String)applicationSettings
    			.getSettingsMap()
    			.get(ApplicationSettings.PLUS_C_PHOTOS_FOLDER_NAME);
		
		byte[] imageByte = null;
		try {
			imageByte = photoAlbumService.getPlusCPhoto(
					currentUser, photoAlbumsLocation, 
					plusCPhotosFolderName, plusCid);
			
			if(imageByte == null || imageByte.length == 0) {
				throw new ResourceNotFoundException("beone", "Image is not found");
			}
		} catch (IOException e) {
			logger.error("There was an error during retrieval of plusC image", e);
		}
		
		return imageByte;
	}
}
