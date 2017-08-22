/*
 * Copyright: Energy Research Institute @ NTU
 * spring-boot-service
 * org.erian.examples.bootapi.domain -> Project.java
 * Created on 7 Jul 2017-12:23:27 pm
 */
package org.erian.examples.bootapi.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;

/**
 * function description：
 *
 * @author <a href="mailto:zhuyb@ntu.edu.sg">Rambo Zhu  </a>
 * @version v 1.0 
 * Create:  7 Jul 2017 12:23:27 pm
 */
//JPA实体类的标识
@Entity
public class Demo extends IdEntity{

	/*
	public String ProjectName;
	public String Description;
	public String CreatedBy;
	public Date CreatedOn;
	public String UpdatedBy;
	public Date UpdatedOn;
	public String logo;
	public String UserID;
	*/	    
	
	public String name;

	public Demo() {
	}


	public Demo(Long id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	
	
		    		  
	
}
