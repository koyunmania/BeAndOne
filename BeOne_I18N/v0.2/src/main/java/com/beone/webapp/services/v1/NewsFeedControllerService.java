package com.beone.webapp.services.v1;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beone.webapp.model.NewsFeed;
import com.beone.webapp.persistence.NewsFeedDao;
import com.beone.webapp.services.v1.model.NewsFeedTO;


@Controller
public class NewsFeedControllerService {
	
	private static final Logger logger = LoggerFactory.getLogger(NewsFeedControllerService.class);
	
	@Autowired
	NewsFeedDao newsFeedDao;
	
	
	public NewsFeedDao getNewsFeedDao() {
		return newsFeedDao;
	}


	public void setNewsFeedDao(NewsFeedDao newsFeedDao) {
		this.newsFeedDao = newsFeedDao;
	}


	@RequestMapping(value = "/api/newsfeed", produces = "application/json", method=RequestMethod.POST)
	@ResponseBody
	public RestResult getNewsfeed(@RequestHeader("Accept") String acceptHeader) {
		
		logger.info("getNewsfeed called, Serving resource for Accept header: {}", acceptHeader);
		
		//List<NewsFeed> feedList = newsFeedDao.getFeedsOfLastXMinutes(10);
		List<NewsFeed> feedList = newsFeedDao.getAll();
		List<NewsFeedTO> feedToList = new ArrayList<NewsFeedTO>();
		for(NewsFeed feed : feedList) {
			NewsFeedTO fTo = new NewsFeedTO();
			fTo.setFeedContent(feed.getFeedContent());
			fTo.setFeedId(feed.getFeedId());
			fTo.setFeedPublishDate(feed.getFeedPublishDate());
			fTo.setFeedTitle(feed.getFeedTitle());
			fTo.setUserId(feed.getFeedAuthor().getUserId());
			fTo.setUsername(feed.getFeedAuthor().getFirstname() + " " + feed.getFeedAuthor().getLastname());
			//fTo.setFeedPicture("<img =\"/images/profile/"+feed.getFeedAuthor().getUserId()+"\"/>");
			fTo.setFeedPicture("<span class=\"glyphicon glyphicon-user\"></span>");
			
			feedToList.add(fTo);
		}
		
		RestResult r = new RestResult();
		r.setStatus(true);
		r.setMessage("");
		r.setData(feedToList.toArray());
		
		return r;
	}
}
