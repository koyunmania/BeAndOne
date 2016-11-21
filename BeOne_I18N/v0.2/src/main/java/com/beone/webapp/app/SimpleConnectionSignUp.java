/*
 * Copyright 2014 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.beone.webapp.app;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.social.connect.Connection;
import org.springframework.social.connect.ConnectionSignUp;

import com.beone.webapp.model.User;
import com.beone.webapp.persistence.UserDao;

/**
 * Create a local user for the remote user
 * Simple little {@link ConnectionSignUp} command that allocates new userIds in memory.
 * Doesn't bother storing a user record in any local database, since this quickstart 
 * just stores the user id in a cookie.
 * @author Selcuk
 */
public final class SimpleConnectionSignUp implements ConnectionSignUp {
	private static final Logger logger = LoggerFactory.getLogger(SimpleConnectionSignUp.class);
	
	private UserDao usersDao;

	public UserDao getUsersDao() {
		return usersDao;
	}

	public void setUsersDao(UserDao usersDao) {
		this.usersDao = usersDao;
	}

	@Override
	public String execute(Connection<?> connection) {
		logger.info("execute called");
		User remoteUser = new User();
		String providerUserId = connection.createData().getProviderUserId();
		String providerId = connection.createData().getProviderId();
		remoteUser.setEmail(connection.fetchUserProfile().getEmail());
		remoteUser.setFirstname(connection.fetchUserProfile().getFirstName());
		remoteUser.setLastname(connection.fetchUserProfile().getLastName());
		remoteUser.setProvider(providerId);
		remoteUser.setUsername(providerUserId);
		this.usersDao.insertNew(remoteUser);
		return ""+remoteUser.getUserId();
	}

}
