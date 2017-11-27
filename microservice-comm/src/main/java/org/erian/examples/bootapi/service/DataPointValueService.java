package org.erian.examples.bootapi.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.erian.examples.bootapi.domain.*;
import org.erian.examples.bootapi.repository.*;
import org.erian.examples.bootapi.service.exception.ErrorCode;
import org.erian.examples.bootapi.service.exception.ServiceException;

@Service
public class DataPointValueService {

	private static Logger logger = LoggerFactory.getLogger(DataPointValueService.class);

	@Autowired
	private DataPointValueDao dataPointDao;
	
	@Transactional(readOnly = true)
	public List<DataPointValue> findAll() {
		return dataPointDao.findAll();
	}

	@Transactional(readOnly = true)
	public DataPointValue findOne(Integer id) {
		return dataPointDao.findOne(id);
	}


	@Transactional
	public DataPointValue saveDataPointValue(DataPointValue dataPoint) {

		return dataPointDao.save(dataPoint);
	}

	@Transactional
	public DataPointValue modifyDataPointValue(DataPointValue dataPoint) {

		DataPointValue orginalDataPointValue = dataPointDao.findOne(dataPoint.id);

		if (orginalDataPointValue == null) {
			logger.error(dataPoint.id + "  is not exist");
			throw new ServiceException("The DataPointValue is not exist", ErrorCode.BAD_REQUEST);
		}
		return dataPointDao.save(dataPoint);
	}

	@Transactional
	public void deleteDataPointValue(Integer id) {
		DataPointValue dataPoint = dataPointDao.findOne(id);

		if (dataPoint == null) {
			logger.error( id + " DataPointValue which is not exist");
			throw new ServiceException("The DataPointValue is not exist", ErrorCode.BAD_REQUEST);
		}

		dataPointDao.delete(id);
	}
}
