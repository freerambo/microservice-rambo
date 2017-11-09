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
import org.erian.modules.utils.Collections3;

@Service
public class DeviceService {

	private static Logger logger = LoggerFactory.getLogger(DeviceService.class);

	@Autowired
	private DeviceDao deviceDao;
	@Autowired
	private DataPointService dpService;
	
	@Autowired
	private ModbusTcpDao tcpDao;

	@Autowired
	private ModbusRtuDao rtuDao;

	@Autowired
	private EthernetIpDao ipDao;
	
	@Transactional(readOnly = true)
	public List<Device> findAll() {
		return deviceDao.findAll();
	}
	
	@Transactional(readOnly = true)
	public List<Device> findByProject(Integer projectId) {
		return deviceDao.getByProjectId(projectId);
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
		//delete all datapoints
		dpService.deleteByDevice(id); 
		// delete protocols ... 
		this.deleteProtocolByDevice(device);
	}
	
	@Transactional
	private void deleteProtocolByDevice(Device device){
		switch (device.protocol) {
			case DataPointService.MODBUS_TCP:
				tcpDao.deleteByDeviceId(device.id);
				break;
			case DataPointService.MODBUS_RTU:
				rtuDao.deleteByDeviceId(device.id);
			 break;
			case DataPointService.ETHERNET_IP:
				ipDao.deleteByDeviceId(device.id);
				break;
			default:
				logger.error("unknown protocol " + device.protocol);
				break;
		}
	}
	
	@Transactional
	public void deleteByProject(Integer projectId) {
		List<Device> devices = this.findByProject(projectId);
		if (Collections3.isNotEmpty(devices)) {
			for(Device device: devices)
				this.deleteDevice(device.id);
		}
	}
}
