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
public class DeviceService {

	private static Logger logger = LoggerFactory.getLogger(DeviceService.class);

	@Autowired
	private DeviceDao deviceDao;
	
	@Transactional(readOnly = true)
	public List<Device> findAll() {
		return deviceDao.findAll();
	}

	@Transactional(readOnly = true)
	public Device findOne(Integer id) {
		return deviceDao.findOne(id);
	}


	@Transactional
	public Device saveDevice(Device device) {

		return deviceDao.save(device);
	}

	@Transactional
	public Device modifyDevice(Device device) {

		Device orginalDevice = deviceDao.findOne(device.id);

		if (orginalDevice == null) {
			logger.error(device.id + "  is not exist");
			throw new ServiceException("The Device is not exist", ErrorCode.BAD_REQUEST);
		}
		return deviceDao.save(device);
	}

	@Transactional
	public void deleteDevice(Integer id) {
		Device device = deviceDao.findOne(id);

		if (device == null) {
			logger.error( id + " Device which is not exist");
			throw new ServiceException("The Device is not exist", ErrorCode.BAD_REQUEST);
		}

		deviceDao.delete(id);
	}
}
