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
public class ProjectCommunicationTest {

	@Autowired
	private ProjectCommunicationDao testDao;

	@Test
	public void find() {
		List<ProjectCommunication> demos = testDao.findAll();
		assertThat(demos).hasSize(1);
	}
	
//	@Test
	public void findByProject() {
		List<ProjectCommunication> demos = testDao.findByProjectID(1001);
		assertThat(demos).hasSize(1);
	}
	
//	@Test
	public void save() {
		ProjectCommunication demo = new ProjectCommunication();
		demo.projectID = 1002;
		demo.communicationID = 1006;
//		demo.project.projectid = 1002;
//		demo.communication.communicationID = 1006;
		demo.address = "localhost:80";
		demo.intervalID = 1000;
		demo.createdOn = new Date();
		demo.createdBy = "testUser";
		testDao.save(demo);
		assertThat(demo.projCommID).isNotNull();
	}

	
	
}
