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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

/**
 * Created by panded4 on 11/19/2016.
 */
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

    @Transactional
    public String sendVerificationEmail(User user,Email email) {
        String token = SecurityUtils.generateToken();
        RegisterToken registerToken = new RegisterToken();
        registerToken.setUser(user);
        registerToken.setToken(token);
        registerTokenDao.insertNew(registerToken);
        String url = "http://localhost:8085" + "/verify/" + user.getUserId() + "/" + token;

        MailUtils.sendEmail(email,url);
        return null;
    }
    @Transactional
    public boolean verify(int userid, String key) {
        User user = userDao.findByKey(userid);
        RegisterToken registerToken=new RegisterToken();
        registerToken.setToken(key);
        if (null!=registerTokenDao.getUserByToken(registerToken)) {
            user.setStatus("active");
            userDao.insertNew(user);
            RegisterToken registerToken1=new RegisterToken();
            registerToken1.setToken(SecurityUtils.generateToken());
            registerToken1.setUser(user);
            registerTokenDao.update(registerToken1);
            return true;
        } else {
            return false;
        }
    }
}
