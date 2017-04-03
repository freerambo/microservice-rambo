package org.erian.examples.bootapi.repository;

import static org.assertj.core.api.Assertions.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.data.domain.PageRequest;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.erian.examples.bootapi.BootApiApplication;
import org.erian.examples.bootapi.domain.*;
import org.erian.examples.bootapi.repository.*;
import org.erian.examples.bootapi.service.WeatherService;

@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = BootApiApplication.class)
@DirtiesContext
public class WeatherDaoTest {

	private static Logger logger = LoggerFactory.getLogger(WeatherDaoTest.class);

	@Autowired
	private WeatherDao weatherDao;

	@Test
	public void findLatest() {
		ISSData data = weatherDao.getLatestOne();
		logger.info(data.toString());
		assertThat(data).isNotNull();
	}
	
	
}
