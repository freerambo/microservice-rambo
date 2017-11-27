/*
 * Copyright: Energy Research Institute @ NTU
 * spring-boot-service
 * org.erian.examples.bootapi.repository -> ProjectDao.java
 * Created on 7 Jul 2017-12:53:28 pm
 */
package com.erian.ict.microgrid.domain;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 * function description：
 *
 * @author <a href="mailto:zhuyb@ntu.edu.sg">Rambo Zhu  </a>
 * @version v 1.0 
 * Create:  7 Jul 2017 12:53:28 pm
 */

public interface DataPointDao extends BaseDao<DataPoint, Integer> {

	
	@Query(value = "SELECT d FROM DataPoint AS d WHERE d.deviceId = :deviceId")
	List<DataPoint> getByDeviceId(@Param("deviceId")Integer deviceId);
}
