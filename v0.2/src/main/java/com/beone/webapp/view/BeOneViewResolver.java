package com.beone.webapp.view;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
@ComponentScan("com.beone")
public class BeOneViewResolver { 
	String locale = "?lang=";
	String regionCode = "tr";
	
	
	@Bean  
    public UrlBasedViewResolver urlBasedViewResolver() {  
	  locale = locale + regionCode;
      UrlBasedViewResolver resolver = new UrlBasedViewResolver();  
      resolver.setPrefix("/WEB-INF/views/");  
      resolver.setSuffix(".jsp"+locale);
      resolver.setCache(false);
      resolver.setViewClass(JstlView.class);  
      return resolver;  
    }
	
	
} 