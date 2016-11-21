package com.beone.webapp.persistence;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.beone.webapp.model.PossibleAnswer;
import com.beone.webapp.model.Question;

public class PossibleAnswerDao extends AbstractDao
{
	@SuppressWarnings("unchecked")
	public PossibleAnswer findByKey (int id) {
		List<PossibleAnswer> result = (List<PossibleAnswer>)this.localSessionFactory.getCurrentSession()
				.createQuery("from PossibleAnswer pa where pa.possibleAnswerId=:answerId")
                .setParameter("answerId", id)
                .list();
		
		if(result.size() > 0) {
			return result.get(0);
		} else {
			return null;
		}
	}
	
	public void insertNew (PossibleAnswer answer) {
		this.localSessionFactory.getCurrentSession().save(answer);
	}
	
	public void delete (PossibleAnswer answer) {
		this.localSessionFactory.getCurrentSession().delete(answer);
	}
	
	public Set<PossibleAnswer> getAll () {
		Set<PossibleAnswer> result = new HashSet<PossibleAnswer>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery("from PossibleAnswer pa").list());
		return result;
	}
	
	public Set<PossibleAnswer> getAllSorted (String sortAttribute, String sortDirection) {
		if(sortAttribute== null || sortAttribute.length() == 0) {
			sortAttribute = "questionId";
		}
		
		if(sortDirection== null || sortDirection.length() == 0) {
			sortDirection = "ASC";
		}
		
		Set<PossibleAnswer> result = new HashSet<PossibleAnswer>();
		result.addAll(this.localSessionFactory.getCurrentSession().createQuery(
			"from PossibleAnswer ORDER BY "+ sortAttribute+ " " + sortDirection).list());
		return result;
	}
	
	public void update (PossibleAnswer answer) {
		this.localSessionFactory.getCurrentSession().saveOrUpdate(answer);
	}

	public List<PossibleAnswer> getPossibleAnwersForQuestion(Question q) {
		// TODO Auto-generated method stub
		return null;
	}
}
