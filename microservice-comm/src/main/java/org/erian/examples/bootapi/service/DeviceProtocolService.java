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
public class DeviceProtocolService {

	private static Logger logger = LoggerFactory.getLogger(DeviceProtocolService.class);


	
	@Autowired
	private DeviceProtocolDao deviceProtocolDao;
	
	@Transactional(readOnly = true)
	public List<DeviceProtocol> findAll() {
		return deviceProtocolDao.findAll();
	}

	@Transactional(readOnly = true)
	public DeviceProtocol findOne(Integer id) {
		return deviceProtocolDao.findOne(id);
	}


	@Transactional
	public DeviceProtocol saveDevice(DeviceProtocol deviceProtocol) {

		return deviceProtocolDao.save(deviceProtocol);
	}

	@Transactional
	public DeviceProtocol modifyDevice(DeviceProtocol deviceProtocol) {

		DeviceProtocol orginalDevice = deviceProtocolDao.findOne(deviceProtocol.deviceProtocolID);

		if (orginalDevice == null) {
			logger.error(deviceProtocol.deviceProtocolID + "  is not exist");
			throw new ServiceException("The DeviceProtocol is not exist", ErrorCode.BAD_REQUEST);
		}
		return deviceProtocolDao.save(deviceProtocol);
	}

	@Transactional
	public void deleteDevice(Integer id) {
		DeviceProtocol deviceProtocol = deviceProtocolDao.findOne(id);

		if (deviceProtocol == null) {
			logger.error( id + " DeviceProtocol which is not exist");
			throw new ServiceException("The DeviceProtocol is not exist", ErrorCode.BAD_REQUEST);
		}

		deviceProtocolDao.delete(id);
	}
}
