package org.erian.examples.bootapi.repository;

import static org.assertj.core.api.Assertions.*;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.data.domain.PageRequest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.erian.examples.bootapi.BootApiApplication;
import org.erian.examples.bootapi.domain.*;
import org.erian.examples.bootapi.repository.*;

import static org.assertj.core.api.Assertions.*;


@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = BootApiApplication.class)
@DirtiesContext
public class DataPointTest {

	@Autowired
	private  DataPointDao testDao;

//	@Test
	public void find() {
		List<DataPoint> demos = testDao.findAll();
		assertThat(demos).hasSize(1);
	}
	
	
	@Test
	public void save() {
		DataPoint demo = new DataPoint();
		demo.name ="volt";
		demo.type = "int32";
		
		demo.address = 100;
		demo.length = 2;
		demo.description = "a demo datapoint";
		demo.interval = "SEC05";
		demo.createdOn = new Date();
		demo.createdBy = "testUser";
		demo.deviceId = 1001;
		demo.readable = 1;
		demo.writable = 0;
		demo.inputExpression = null;
		demo.outPutExpression = "floatToInt";
		demo.unit = "V";
		testDao.save(demo);
		assertThat(demo.id).isNotNull();
	}

	
	
}
