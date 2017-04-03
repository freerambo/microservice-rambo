/*
 * Copyright: Energy Research Institute @ NTU
 * weather-api
 * org.erian.examples.bootapi.config -> DBConfig.java
 * Created on 3 Apr 2017-3:10:09 pm
 */
package org.erian.examples.bootapi.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.SimpleDriverDataSource;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;

/**
 * function description：
 *
 * @author <a href="mailto:zhuyb@ntu.edu.sg">Rambo Zhu  </a>
 * @version v 1.0 
 * Create:  3 Apr 2017 3:10:09 pm
 */
//@Configuration
public class DBConfig {

	
	@Bean
	public DataSource dataSource() {
	    SimpleDriverDataSource dataSource = new SimpleDriverDataSource();
	    dataSource.setDriverClass(com.mysql.jdbc.Driver.class);
	    dataSource.setUsername("weather");
	    dataSource.setUrl("jdbc:mysql://155.69.218.214/weather_station?characterEncoding=UTF-8");
	    dataSource.setPassword("Zhu-YUan?Bo");

	    return dataSource;
	}

	@Bean
	public LocalContainerEntityManagerFactoryBean entityManagerFactory() {
	    LocalContainerEntityManagerFactoryBean em = new LocalContainerEntityManagerFactoryBean();
	    em.setDataSource(dataSource());
	    //
	    return em;
	}
	
}
