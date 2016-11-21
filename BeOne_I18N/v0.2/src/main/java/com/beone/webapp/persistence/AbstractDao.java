package com.beone.webapp.persistence;

import org.hibernate.SessionFactory;

public abstract class AbstractDao {

	protected SessionFactory localSessionFactory;

	public SessionFactory getLocalSessionFactory() {
		return localSessionFactory;
	}

	public void setLocalSessionFactory(SessionFactory localSessionFactory) {
		this.localSessionFactory = localSessionFactory;
	}
	
	public void refreshObject(Object obj) {
		this.localSessionFactory.getCurrentSession().refresh(obj);
		//Hibernate.initialize(obj);
	}
	
	public void flushCurrentState() {
		this.localSessionFactory.getCurrentSession().flush();
	}

	
}
