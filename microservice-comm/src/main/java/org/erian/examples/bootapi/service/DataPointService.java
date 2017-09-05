package org.erian.examples.bootapi.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.erian.examples.bootapi.domain.*;
import org.erian.examples.bootapi.dto.*;
import org.erian.examples.bootapi.repository.*;
import org.erian.examples.bootapi.service.exception.ErrorCode;
import org.erian.examples.bootapi.service.exception.ServiceException;

@Service
public class DataPointService {

	private static Logger logger = LoggerFactory.getLogger(DataPointService.class);

	@Autowired
	private DataPointDao dataPointDao;
	
	@Autowired
	private ModbusTcpDao tcpDao;
	
	@Autowired
	private ModbusRtuDao rtuDao;
	
	@Autowired
	private EthernetIpDao ipDao;
	
	@Transactional(readOnly = true)
	public List<DataPoint> findAll() {
		return dataPointDao.findAll();
	}

	@Transactional(readOnly = true)
	public DataPoint findOne(Integer id) {
		return dataPointDao.findOne(id);
	}


	@Transactional
	public DataPoint saveDataPoint(DataPoint dataPoint) {

		return dataPointDao.save(dataPoint);
	}

	@Transactional
	public DataPoint modifyDataPoint(DataPoint dataPoint) {

		DataPoint orginalDataPoint = dataPointDao.findOne(dataPoint.id);

		if (orginalDataPoint == null) {
			logger.error(dataPoint.id + "  is not exist");
			throw new ServiceException("The DataPoint is not exist", ErrorCode.BAD_REQUEST);
		}
		return dataPointDao.save(dataPoint);
	}

	@Transactional
	public void deleteDataPoint(Integer id) {
		DataPoint dataPoint = dataPointDao.findOne(id);

		if (dataPoint == null) {
			logger.error( id + " DataPoint which is not exist");
			throw new ServiceException("The DataPoint is not exist", ErrorCode.BAD_REQUEST);
		}

		dataPointDao.delete(id);
	}
	/**
	 *  data processing for reading data from a datapiont ID
	 *  
	 * @function:
	 * @param id
	 * @return
	 * @author: Rambo Zhu     4 Sep 2017 9:48:45 pm
	 */
	public String readDataPoint(Integer id){
		String value = null;
		
		DataPoint dp = this.findOne(id);
		
		if(dp != null && dp.device != null){
			value = this.readDataPoint(dp);
		}else{
			logger.warn("The datapoint or Device is not exists with id -- " + id);
		}
		return value;
	}
	
	public String readDataPoint(DataPoint dp){
		String value = null;
		Device d = dp.device;
		
		switch(d.protocol){
		
			case "ModbusTCP": 
				ModbusTCP tcp = tcpDao.findByDeviceId(d.id);
				ModbusTcpRequest tcpReq = new ModbusTcpRequest(d, dp, tcp);
				return tcpReq.toString();
	//			break;
			case "ModbusRTU":
				ModbusRTU rtu = rtuDao.findByDeviceId(d.id);
				ModbusRtuRequest rtuReq = new ModbusRtuRequest(d, dp, rtu);
				return rtuReq.toString();
	//			break;
			case "EthernetIP": 
				EthernetIP ip = ipDao.findByDeviceId(d.id);
				EthernetIpRequest ipReq = new EthernetIpRequest(d, dp, ip);
	
				return ipReq.toString();
	//			break;	
			default:
				logger.error("unknown protocol " + d.protocol);
				break;
		}
		return value;
	}
	
}
