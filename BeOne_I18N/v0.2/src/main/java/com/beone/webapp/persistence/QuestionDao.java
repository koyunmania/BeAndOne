package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.Question;

public class QuestionDao extends AbstractDao
{
	@SuppressWarnings("unchecked")
	public Question findByKey (int id) {
		List<Question> result = (List<Question>)this.localSessionFactory.getCurrentSession()
				.createQuery("from Question q where q.questionId=:questionId")
                .setParameter("questionId", id)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
	
	public void insertNew (Question question) {
		this.localSessionFactory.getCurrentSession().save(question);
	}
	
	public void delete (Question question) {
		this.localSessionFactory.getCurrentSession().delete(question);
	}
	
	public Set<Question> getAll () {
		Set<Question> result = new HashSet<Question>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from Question que").list());
		return result;
	}
	
	public Set<Question> getAllSorted (String sortAttribute, String sortDirection) {
		if(sortAttribute== null || sortAttribute.length() == 0) {
			sortAttribute = "questionTranslatedText";
		}
		
		if(sortDirection== null || sortDirection.length() == 0) {
			sortDirection = "ASC";
		}
		
		Set<Question> result = new HashSet<Question>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"from Question ORDER BY "+ sortAttribute+ " " + sortDirection).list());
		return result;
	}
	
	public void update (Question question) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(question);
	}

	public List<Question> getAllActiveQuestions() {
		List<Question> result = (List<Question>)this.localSessionFactory.getCurrentSession()
				.createQuery("from Question q where isActive=true")
                .list();
		
		return result;
	}

	public Question findByQuestionCode(int questionCode) {
		List<Question> result = (List<Question>)this.localSessionFactory.getCurrentSession()
				.createQuery("from Question q where q.questionCode=:questionCode")
                .setParameter("questionCode", questionCode)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
}
