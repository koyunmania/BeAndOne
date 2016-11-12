package com.beone.webapp.persistence;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.User;
import com.beone.webapp.model.UserAnswer;

public class UserAnswerDao extends AbstractDao
{
	@SuppressWarnings("unchecked")
	public UserAnswer findByKey (int id) {
		List<UserAnswer> result = (List<UserAnswer>)this.localSessionFactory.getCurrentSession()
				.createQuery("from UserAnswer ua where ua.userAnswerId=:userAnswerId")
                .setParameter("userAnswerId", id)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
	
	public void insertNew (UserAnswer userAnswer) {
		this.localSessionFactory.getCurrentSession().save(userAnswer);
	}
	
	public void delete (UserAnswer userAnswer) {
		this.localSessionFactory.getCurrentSession().delete(userAnswer);
	}
	
	@SuppressWarnings("unchecked")
	public Set<UserAnswer> getAll (User user) {
		Set<UserAnswer> result = new HashSet<UserAnswer>();
		result.addAll(this.localSessionFactory.getCurrentSession()
				.createQuery("from UserAnswer ua WHERE ua.userId=:userId")
				.setParameter("userId", user.getUserId())
				.list());
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public Set<UserAnswer> getAllSorted (String sortAttribute, String sortDirection, User user) {
		if(sortAttribute== null || sortAttribute.length() == 0) {
			sortAttribute = "questionId";
		}
		
		if(sortDirection== null || sortDirection.length() == 0) {
			sortDirection = "ASC";
		}
		
		Set<UserAnswer> result = new HashSet<UserAnswer>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"from UserAnswer ua WHERE ua.userId=:userId ORDER BY "+ sortAttribute+ " " + sortDirection)
				.setParameter("userId", user.getUserId())
				.list());
		return result;
	}
	
	public void update (UserAnswer userAnswer) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(userAnswer);
	}

	@SuppressWarnings("unchecked")
	public Set<UserAnswer> findAnswersOfUserToQuestionOnDate(User currentUser,
			int questionCode, Timestamp userDate) {
		Set<UserAnswer> result = new HashSet<UserAnswer>();
		result.addAll(this.localSessionFactory.getCurrentSession()
				.createQuery("select ua from UserAnswer as ua, Question as qu "
						+ "WHERE ua.userId=:userId and qu.questionCode=:questionCode and "
						+ "qu.questionId=ua.questionId and "
						+ "ua.userAnswerGivenDate=:userDate")
				.setParameter("userId", currentUser.getUserId())
				.setParameter("questionCode", questionCode)
				.setParameter("userDate", userDate)
				.list());
		return result;
	}
}
