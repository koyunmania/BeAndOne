package com.beone.webapp.persistence;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.beone.webapp.model.UserAlbum;
import com.beone.webapp.model.User;
import com.beone.webapp.model.UserPhoto;
import com.beone.webapp.utils.UserAlbumUtils;

public class UserAlbumDao extends AbstractDao {

	@SuppressWarnings("unchecked")
	public UserAlbum createProfileAlbumOrGetIfExists(UserAlbum profileAlbum) {
		List<UserAlbum> result = (List<UserAlbum>)this.localSessionFactory.getCurrentSession()
				.createQuery(
						"select ua from UserAlbum ua inner join ua.user u "
						+ "where ua.albumName=:albumName and u.userId=:userId")
                .setParameter("albumName", profileAlbum.getAlbumName())
                .setParameter("userId", profileAlbum.getUser().getUserId())
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			this.localSessionFactory.getCurrentSession().save(profileAlbum);
			return profileAlbum;
		}
	}

	public void createProfileAlbumPhotoEntry(UserPhoto photo) {
		this.localSessionFactory.getCurrentSession().save(photo);
	}
	
	public void deactivateAllProfilePhotoEntries(UserAlbum profilePhotoAlbum) {
		this.localSessionFactory.getCurrentSession().createQuery(
				"update UserPhoto up set up.isActive=false where up.album=:profileAlbum")
			.setParameter("profileAlbum", profilePhotoAlbum);
	}

	@SuppressWarnings("unchecked")
	public UserPhoto getProfilePhotoOfUser(User currentUser) {
		List<UserPhoto> result = (List<UserPhoto>)this.localSessionFactory.getCurrentSession()
				.createQuery(
						"select ph from UserPhoto ph inner join ph.album ua inner join ua.user u "
						+ "where ua.albumName=:albumName and u.userId=:userId and ph.isActive=true")
                .setParameter("albumName", UserAlbumUtils.PROFILE_ALBUM_NAME)
                .setParameter("userId", currentUser.getUserId())
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}

}
