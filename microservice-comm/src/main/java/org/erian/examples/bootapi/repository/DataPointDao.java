/*
 * Copyright: Energy Research Institute @ NTU
 * spring-boot-service
 * org.erian.examples.bootapi.repository -> ProjectDao.java
 * Created on 7 Jul 2017-12:53:28 pm
 */
package org.erian.examples.bootapi.repository;

import java.util.List;

import org.erian.examples.bootapi.domain.*;
import org.springframework.data.repository.query.Param;


/**
 * function description：
 *
 * @author <a href="mailto:zhuyb@ntu.edu.sg">Rambo Zhu  </a>
 * @version v 1.0 
 * Create:  7 Jul 2017 12:53:28 pm
 */

public interface DataPointDao extends BaseDao<DataPoint, Integer> {

	List<DataPoint> getByDeviceId(Integer deviceId);
	
	void deleteByDeviceId(Integer deviceId);

}
