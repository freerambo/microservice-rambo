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
public class DeviceController {

	
	public static final String PROJECT_PATH = "/api/device/";
	
	private static Logger logger = LoggerFactory.getLogger(DeviceController.class);

	@Autowired
	private DeviceService deviceService;
	
	@RequestMapping(value = "/api/devices",method=RequestMethod.GET, produces = MediaTypes.JSON_UTF_8)
	@Monitored
	public List<Device> listAllDevice() {
		List<Device> devices = deviceService.findAll();
		return devices;
	}

	@RequestMapping(value = "/api/devices/{id}", method=RequestMethod.GET, produces = MediaTypes.JSON_UTF_8)
	@Monitored
	public Device listOneDevice(@PathVariable("id") Integer id) {
		Device device = deviceService.findOne(id);
		return device;
	}

//	Content-Type: application/json;charset=UTF-8
	@RequestMapping(value = "/api/devices", method = RequestMethod.POST, consumes = MediaTypes.JSON_UTF_8)
	@Monitored
	public Device createDevice(@RequestBody Device device, UriComponentsBuilder uriBuilder) {
		
		device = deviceService.saveDevice(device);
			
		return device;
	}
	
//	@RequestMapping(value = "/api/devices/{id}", method = RequestMethod.DELETE)
//	@Monitored
	public void deleteDevice(@NotNull @PathVariable("id") Integer id) {
		deviceService.deleteDevice(id);
	}

//	@RequestMapping(value = "/api/devices", method = RequestMethod.PUT, consumes = MediaTypes.JSON_UTF_8)
//	@Monitored
	public void modifyDevice(@RequestBody Device device,
			@RequestParam(value = "token", required = false) String token) {
		deviceService.modifyDevice(device);
	}
}
