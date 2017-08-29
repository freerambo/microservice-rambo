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
public class ProtocolController {

	
	public static final String PROJECT_PATH = "/api/protocol/";
	
	private static Logger logger = LoggerFactory.getLogger(ProtocolController.class);

	@Autowired
	private ProtocolService protocolService;
	
	@RequestMapping(value = "/api/protocols",method=RequestMethod.GET, produces = MediaTypes.JSON_UTF_8)
	@Monitored
	public List<Protocol> listAllProtocol() {
		List<Protocol> protocols = protocolService.findAll();
		return protocols;
	}

	@RequestMapping(value = "/api/protocols/{id}", method=RequestMethod.GET, produces = MediaTypes.JSON_UTF_8)
	@Monitored
	public Protocol listOneProtocol(@PathVariable("id") Integer id) {
		Protocol protocol = protocolService.findOne(id);
		return protocol;
	}

//	Content-Type: application/json;charset=UTF-8
	@RequestMapping(value = "/api/protocols", method = RequestMethod.POST, consumes = MediaTypes.JSON_UTF_8)
	@Monitored
	public Protocol createProtocol(@RequestBody Protocol protocol, UriComponentsBuilder uriBuilder) {
		
		protocol = protocolService.saveProtocol(protocol);
			
		return protocol;
	}
	
//	@RequestMapping(value = "/api/protocols/{id}", method = RequestMethod.DELETE)
//	@Monitored
	public void deleteProtocol(@NotNull @PathVariable("id") Integer id) {
		protocolService.deleteProtocol(id);
	}

//	@RequestMapping(value = "/api/protocols", method = RequestMethod.PUT, consumes = MediaTypes.JSON_UTF_8)
//	@Monitored
	public void modifyProtocol(@RequestBody Protocol protocol,
			@RequestParam(value = "token", required = false) String token) {
		
		protocolService.modifyProtocol(protocol);
	}
}
