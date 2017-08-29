package org.erian.examples.bootapi.api;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;
import org.erian.examples.bootapi.domain.*;
import org.erian.examples.bootapi.service.*;
import org.erian.modules.constants.MediaTypes;
import org.javasimon.aop.Monitored;

@RestController
public class CommunicationController {

	
	public static final String PROJECT_PATH = "/api/communication/";
	
	private static Logger logger = LoggerFactory.getLogger(CommunicationController.class);

	@Autowired
	private CommunicationService communicationService;
	
	@RequestMapping(value = "/api/communications",method=RequestMethod.GET, produces = MediaTypes.JSON_UTF_8)
	@Monitored
	public List<Communication> listAllCommunication() {
		List<Communication> communications = communicationService.findAll();
		return communications;
	}

	@RequestMapping(value = "/api/communications/{id}", method=RequestMethod.GET, produces = MediaTypes.JSON_UTF_8)
	@Monitored
	public Communication listOneCommunication(@PathVariable("id") Integer id) {
		Communication communication = communicationService.findOne(id);
		return communication;
	}

//	Content-Type: application/json;charset=UTF-8
	@RequestMapping(value = "/api/communications", method = RequestMethod.POST, consumes = MediaTypes.JSON_UTF_8)
	@Monitored
	public Communication createCommunication(@RequestBody Communication communication, UriComponentsBuilder uriBuilder) {
		
		communication = communicationService.saveCommunication(communication);
			
		return communication;
	}
	
//	@RequestMapping(value = "/api/communications/{id}", method = RequestMethod.DELETE)
//	@Monitored
	public void deleteCommunication(@NotNull @PathVariable("id") Integer id) {
		communicationService.deleteCommunication(id);
	}

//	@RequestMapping(value = "/api/communications", method = RequestMethod.PUT, consumes = MediaTypes.JSON_UTF_8)
//	@Monitored
	public void modifyCommunication(@RequestBody Communication communication,
			@RequestParam(value = "token", required = false) String token) {
		
		communicationService.modifyCommunication(communication);
	}
}
