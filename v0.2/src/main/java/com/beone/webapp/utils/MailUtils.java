package com.beone.webapp.utils;

import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import com.beone.webapp.model.Email;

public class MailUtils {
//	private static JavaMailSender mailSender;

	public static void sendEmail(Email email, String url) {
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
		
		SimpleMailMessage msg = new SimpleMailMessage();
        msg.setTo(email.getTo());
        msg.setFrom(email.getFrom());
        msg.setSubject(email.getSubject());
        msg.setText(
            "Dear " + email.getUserName()
                + ", thank you for registering at Be&One. You can activate your account by clicking on following link: "
                + url);
        try{
            mailSender.send(msg);
        }
        catch (MailException ex) {
            System.err.println(ex.getMessage());
        }
	}
}
