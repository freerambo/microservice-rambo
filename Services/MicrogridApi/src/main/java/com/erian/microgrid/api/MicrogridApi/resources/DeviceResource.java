package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.erian.microgrid.api.MicrogridApi.model.Device;
import com.erian.microgrid.api.MicrogridApi.service.MessageService;

@Path("/devices")

public class DeviceResource {
	MessageService messageService = new MessageService();
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Device> getDeviceDetails(){
		return messageService.getAllDevices();
	}

}
