package org.erian.examples.bootapi.repository;

import static org.assertj.core.api.Assertions.*;

import java.util.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.erian.examples.bootapi.BootApiApplication;
import org.erian.examples.bootapi.domain.*;
import org.erian.examples.bootapi.repository.*;



@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = BootApiApplication.class)
@DirtiesContext
public class DeviceTest {

	@Autowired
	private DeviceDao testDao;

//	@Test
	public void find() {
		List<Device> objs = testDao.findAll();
		assertThat(objs).hasSize(3);
	}
	
	@Test
	public void save() {
		Device obj = new Device();
		obj.name = "testDevice123";
		obj.description = "this is a test project";
		obj.protocol = "ModbusTCP";
//		obj.path = "192.21.127.110:8080";
		obj.address = 100;
		obj.createdBy = "testUser";
		obj.createdOn = new Date();
		obj.type = "PowerMeter";
		obj.projectId = 1001;
		obj.interval = "SEC05";
		testDao.save(obj);
		assertThat(obj.id).isNotNull();
	}

	
}
