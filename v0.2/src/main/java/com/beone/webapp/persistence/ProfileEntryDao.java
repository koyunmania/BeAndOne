package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.Set;

import com.beone.webapp.model.ProfileEntry;
import com.beone.webapp.model.User;

public class ProfileEntryDao extends AbstractDao {
	public ProfileEntry findByKey (int id)
	{
		ProfileEntry result = (ProfileEntry)this.localSessionFactory.getCurrentSession()
				.createQuery("from ProfileEntry where entryid=:entryid")
                .setParameter("entryid", id)
                .list().get(0);
		return result;
	}
	public void insertNew (ProfileEntry profile)
	{
		this.localSessionFactory.getCurrentSession().save(profile);
	}
	public void delete (ProfileEntry profile)
	{
		this.localSessionFactory.getCurrentSession().delete(profile);
	}
	
	public Set<ProfileEntry> getAllProfileEntryFieldsOfUser (User user)
	{
		Set<ProfileEntry> result = new HashSet<ProfileEntry>();
		result.addAll(this.localSessionFactory.getCurrentSession()
			.createQuery("from ProfileEntry where userid=:userid")
			.setParameter("userid", user.getUserId())
			.list());
		return result;
 		// End of user code
	}
	
	public void update (ProfileEntry profile)
	{
		// Start of user code special Implementation update
		this.localSessionFactory.getCurrentSession().saveOrUpdate(profile);
 		// End of user code
	}
}
