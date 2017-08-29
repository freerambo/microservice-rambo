package org.erian.examples.bootapi.service;

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
import org.erian.examples.bootapi.service.*;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = BootApiApplication.class)
@DirtiesContext
public class ProtocolServiceTest {

	@Autowired
	private ProtocolService service;
//	@Test
	public void find() {
		List<Protocol> objs = service.findAll();
		assertThat(objs).hasSize(1);
	}
	
	@Test
	public void save() {
		Protocol obj = new Protocol();
		obj.name = "testProtocol1";
		obj.description = "this is a test protocol";
		obj.createdBy = "testUser";
		obj.createdOn = new Date();
		obj.details = "this is details of protocol";
		service.saveProtocol(obj);
		assertThat(obj.protocolID).isNotNull();
	}

	
	
}
