package com.beone.webapp.controller.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserAlbum;
import com.beone.webapp.model.UserPhoto;
import com.beone.webapp.persistence.UserAlbumDao;
import com.beone.webapp.utils.UserAlbumUtils;

public class UserAlbumService {
	
	@Autowired
	private UserAlbumDao photoAlbumDao;

	public UserAlbumDao getPhotoAlbumDao() {
		return photoAlbumDao;
	}

	public void setPhotoAlbumDao(UserAlbumDao photoAlbumDao) {
		this.photoAlbumDao = photoAlbumDao;
	}


	@Transactional
	public void uploadProfilePhoto(String albumUploadLocation, MultipartFile file, User currentUser) throws IOException {
		String randomAlbumLocation = UUID.randomUUID().toString();
		String randomPhotoFilename = UUID.randomUUID().toString();
		// currentUser, randomAlbumLocation
		UserAlbum profileAlbum = new UserAlbum();
		profileAlbum.setAlbumFoldername(randomAlbumLocation);
		profileAlbum.setAlbumName(UserAlbumUtils.PROFILE_ALBUM_NAME);
		profileAlbum.setUser(currentUser);
		profileAlbum = photoAlbumDao.createProfileAlbumOrGetIfExists(profileAlbum);
		
    	File userDefaultAlbumUploadFolder = new File(albumUploadLocation+randomAlbumLocation);
    	
    	if(!userDefaultAlbumUploadFolder.exists()) {
    		userDefaultAlbumUploadFolder.mkdirs();
    	}
    	
        byte[] bytes = file.getBytes();
        BufferedOutputStream stream = new BufferedOutputStream(
        		new FileOutputStream(
        				new File(userDefaultAlbumUploadFolder.getAbsolutePath()+"/"+randomPhotoFilename+".jpg")));
        stream.write(bytes);
        stream.close();
        
        UserPhoto photo = new UserPhoto();
        photo.setIsActive(true);
        photo.setAlbum(profileAlbum);
        photo.setOriginalFilename(file.getOriginalFilename());
        photo.setRandomFilename(randomPhotoFilename);
        photoAlbumDao.deactivateAllProfilePhotoEntries(profileAlbum);
        photoAlbumDao.createProfileAlbumPhotoEntry(photo);
	}

	@Transactional
	public String getUrlOfProfilePhoto(User currentUser) {
		String result = "http://image.priceprice.k-img.com/ph/images/common/face_japan_01.gif";
		
		if(currentUser != null) {
			UserPhoto userPhoto = photoAlbumDao.getProfilePhotoOfUser(currentUser);
			result = "/image/"
					+userPhoto.getAlbum().getAlbumFoldername()
					+"/"
					+userPhoto.getRandomFilename();
		}
		
		return result;
	}
	
	@Transactional
	public byte[] getImage(
			User currentUser, String albumUploadLocation, 
			String folderName, String fileName) throws IOException {
		
		byte[] result = null;
		if(currentUser != null) {
			Path path = Paths.get(albumUploadLocation+folderName+"/"+fileName);
			
	    	if(Files.exists(path)) {
				result = Files.readAllBytes(path);
	    	} else {
	    		path = Paths.get(albumUploadLocation+folderName+"/"+fileName+".jpeg");
				
		    	if(Files.exists(path)) {
					result = Files.readAllBytes(path);
		    	} else {
		    		path = Paths.get(albumUploadLocation+folderName+"/"+fileName+".jpg");
					
			    	if(Files.exists(path)) {
						result = Files.readAllBytes(path);
			    	}
		    	}
	    	}
		}
		
		return result;
	}
	
	@Transactional
	public byte[] getProfileImage(User currentUser, String photoAlbumsLocation) throws IOException {
		
		byte[] result = null;
		if(currentUser != null) {
			
			UserPhoto userProfilePhoto = photoAlbumDao.getProfilePhotoOfUser(currentUser);
			
			if(userProfilePhoto != null) {
				result = getImage(
						currentUser, 
						photoAlbumsLocation, 
						userProfilePhoto.getAlbum().getAlbumFoldername(),
						userProfilePhoto.getRandomFilename()+".jpg");
			} else {
//				result = getDefaultProfileImage(photoAlbumsLocation);
			}
		}
		
		return result;
	}

	private byte[] getDefaultProfileImage(String photoAlbumsLocation) throws IOException {
		byte[] result = null;
		Path path = Paths.get(photoAlbumsLocation+"/defaultprofile.svg");
		
    	if(Files.exists(path)) {
			result = Files.readAllBytes(path);
    	}
		
		return result;
	}

	@Transactional
	public byte[] getPlusCPhoto(User currentUser, String photoAlbumsLocation,
			String plusCPhotosFolderName, String plusCid) throws IOException {
		byte[] result = null;
			
		result = getImage(
				currentUser, 
				photoAlbumsLocation, 
				plusCPhotosFolderName,
				plusCid);
		
		return result;
	}
}
