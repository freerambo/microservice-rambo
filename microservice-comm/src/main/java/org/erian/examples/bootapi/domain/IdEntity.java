/*
 * Copyright: Energy Research Institute @ NTU
 * spring-boot-service
 * org.erian.examples.bootapi.domain -> IdEntity.java
 * Created on 7 Jul 2017-12:22:26 pm
 */
package org.erian.examples.bootapi.domain;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

import org.apache.commons.lang3.builder.ToStringBuilder;

/** General Id Entity Long
 * function description：
 *
 * @author <a href="mailto:zhuyb@ntu.edu.sg">Rambo Zhu  </a>
 * @version v 1.0 
 * Create:  7 Jul 2017 12:22:26 pm
 */
//JPA 基类的标识
@MappedSuperclass
public abstract class IdEntity {
	
	// JPA primary key indicator, define the strategy for generating the PK
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long id;
	
	public IdEntity() {

	}

	public IdEntity(Long id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
