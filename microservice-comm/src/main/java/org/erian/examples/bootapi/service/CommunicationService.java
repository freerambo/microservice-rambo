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
public class CommunicationService {

	private static Logger logger = LoggerFactory.getLogger(CommunicationService.class);

	@Autowired
	private CommunicationDao communicationDao;

	@Transactional(readOnly = true)
	public List<Communication> findAll() {
		return communicationDao.findAll();
	}

	@Transactional(readOnly = true)
	public Communication findOne(Integer id) {
		return communicationDao.findOne(id);
	}


	@Transactional
	public Communication saveCommunication(Communication communication) {

		return communicationDao.save(communication);
	}

	@Transactional
	public Communication modifyCommunication(Communication communication) {

		Communication orginalCommunication = communicationDao.findOne(communication.communicationID);

		if (orginalCommunication == null) {
			logger.error(communication.communicationID + "  is not exist");
			throw new ServiceException("The Communication is not exist", ErrorCode.BAD_REQUEST);
		}
		return communicationDao.save(communication);
	}

	@Transactional
	public void deleteCommunication(Integer id) {
		Communication communication = communicationDao.findOne(id);

		if (communication == null) {
			logger.error( id + " Communication which is not exist");
			throw new ServiceException("The Communication is not exist", ErrorCode.BAD_REQUEST);
		}

		communicationDao.delete(id);
	}
}
