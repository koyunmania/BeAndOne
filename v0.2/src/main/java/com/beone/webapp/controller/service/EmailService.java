package com.beone.webapp.controller.service;

import com.beone.webapp.model.Email;
import com.beone.webapp.model.RegisterToken;
import com.beone.webapp.model.User;
import com.beone.webapp.utils.MailUtils;
import com.beone.webapp.model.UserToken;
import com.beone.webapp.persistence.RegisterTokenDao;
import com.beone.webapp.persistence.UserDao;
import com.beone.webapp.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

/**
 * Created by panded4 on 11/19/2016.
 */

@Service
public class EmailService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private RegisterTokenDao registerTokenDao;

    private String domain;

    public UserDao getUserDao() {
        return userDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    public RegisterTokenDao getRegisterTokenDao() {
        return registerTokenDao;
    }

    public void setRegisterTokenDao(RegisterTokenDao registerTokenDao) {
        this.registerTokenDao = registerTokenDao;
    }

    public String sendVerificationEmail(Email email) {
        String token = SecurityUtils.generateToken();
        User user = userDao.findByEmailAndProvider(email.getTo(), User.USER_PROVIDER_BEONE);
        RegisterToken userToken = new RegisterToken();
        userToken.setUser(user);
        userToken.setToken(token);
        registerTokenDao.insertNew(userToken);
        String url = "http://localhost:8085" + "/verify/" + user.getUserId() + "/" + token;

        MailUtils.sendEmail(email,url);
        return null;
    }

    public boolean verify(String email, String key) {
        User user = userDao.findByEmailAndProvider(email, User.USER_PROVIDER_BEONE);
        UserToken userToken = new UserToken();
        userToken.setUser(user);
        userToken.setToken(key);
        if (registerTokenDao.getUserByTokenAndUser(userToken)) {
            user.setStatus("active");
            userDao.insertNew(user);
            return true;
        } else {
            return false;
        }
    }
}
