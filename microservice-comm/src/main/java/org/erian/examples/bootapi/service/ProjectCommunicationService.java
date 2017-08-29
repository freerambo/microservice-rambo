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
public class ProjectCommunicationService {

	private static Logger logger = LoggerFactory.getLogger(ProjectCommunicationService.class);

	
	@Autowired
	private ProjectCommunicationDao projectCommDao;

	@Transactional(readOnly = true)
	public List<ProjectCommunication> findAll() {
		return projectCommDao.findAll();
	}

	@Transactional(readOnly = true)
	public ProjectCommunication findOne(Integer id) {
		return projectCommDao.findOne(id);
	}


	@Transactional
	public ProjectCommunication saveProjectCommunication(ProjectCommunication project) {

		return projectCommDao.save(project);
	}

	@Transactional
	public ProjectCommunication modifyProjectCommunication(ProjectCommunication project) {

		ProjectCommunication orginalProjectCommunication = projectCommDao.findOne(project.projectID);

		if (orginalProjectCommunication == null) {
			logger.error(project.projectID + "  is not exist");
			throw new ServiceException("The ProjectCommunication is not exist", ErrorCode.BAD_REQUEST);
		}
		return projectCommDao.save(project);
	}

	@Transactional
	public void deleteProjectCommunication(Integer id) {
		ProjectCommunication project = projectCommDao.findOne(id);

		if (project == null) {
			logger.error( id + " ProjectCommunication which is not exist");
			throw new ServiceException("The ProjectCommunication is not exist", ErrorCode.BAD_REQUEST);
		}

		projectCommDao.delete(id);
	}
}
