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
public class ProtocolService {

	private static Logger logger = LoggerFactory.getLogger(ProtocolService.class);

	@Autowired
	private ProtocolDao protocolDao;

	@Transactional(readOnly = true)
	public List<Protocol> findAll() {
		return protocolDao.findAll();
	}

	@Transactional(readOnly = true)
	public Protocol findOne(Integer id) {
		return protocolDao.findOne(id);
	}

	@Transactional
	public Protocol saveProtocol(Protocol protocol) {

		return protocolDao.save(protocol);
	}

	@Transactional
	public Protocol modifyProtocol(Protocol protocol) {

		Protocol orginalProtocol = protocolDao.findOne(protocol.protocolID);

		if (orginalProtocol == null) {
			logger.error(protocol.protocolID + "  is not exist");
			throw new ServiceException("The Protocol is not exist", ErrorCode.BAD_REQUEST);
		}
		return protocolDao.save(protocol);
	}

	@Transactional
	public void deleteProtocol(Integer id) {
		Protocol protocol = protocolDao.findOne(id);

		if (protocol == null) {
			logger.error( id + " Protocol which is not exist");
			throw new ServiceException("The Protocol is not exist", ErrorCode.BAD_REQUEST);
		}

		protocolDao.delete(id);
	}
}
