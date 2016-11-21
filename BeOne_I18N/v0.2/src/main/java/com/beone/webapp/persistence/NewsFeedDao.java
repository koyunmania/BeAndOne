package com.beone.webapp.persistence;

import java.util.ArrayList;
import java.util.List;

import com.beone.webapp.model.NewsFeed;


public class NewsFeedDao extends AbstractDao {
	
	public NewsFeed findByKey (int feedId) {
		// Start of user code special Implementation findByKey
		NewsFeed result = (NewsFeed)this.localSessionFactory.getCurrentSession()
				.createQuery("from NewsFeed where feedId=?")
                .setParameter(0, feedId)
                .list().get(0);
		return result;
 		// End of user code
	}
	
	public void insertNew (NewsFeed feed)
	{
		// Start of user code special Implementation insertNew
		this.localSessionFactory.getCurrentSession().saveOrUpdate(feed);
 		// End of user code
	}
	
	public void delete (NewsFeed feed)
	{
		// Start of user code special Implementation delete
		this.localSessionFactory.getCurrentSession().delete(feed);
 		// End of user code
	}
	
	public List<NewsFeed> getAll ()
	{
		// Start of user code special Implementation getAll
		List<NewsFeed> result = new ArrayList<NewsFeed>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from NewsFeed").list());
		return result;
 		// End of user code
	}
	
	public void update (NewsFeed feed)
	{
		// Start of user code special Implementation update
		this.localSessionFactory.getCurrentSession().saveOrUpdate(feed);
 		// End of user code
	}
	
	public List<NewsFeed> getFeedsOfLastXMinutes (int minutes)
	{
		// Start of user code special Implementation getCitiesOfCountry
		List<NewsFeed> result = new ArrayList<NewsFeed>();
		result.addAll(
			this.localSessionFactory.getCurrentSession()
				//.createQuery("from NewsFeed where feedPublishDate>=(feedPublishDate - INTERVAL :minutes)")
				.createQuery("from NewsFeed")
				//.setParameter("minutes", minutes+" minutes")
				.list());
		return result;
 		// End of user code
	}
}
