package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.core.MediaType;

import com.erian.microgrid.api.MicrogridApi.service.DeviceHelper;
import com.erian.microgrid.api.MicrogridApi.model.Device;

@Path("/devices")

public class DeviceResource {	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<Device> getDeviceDetails(){
		return DeviceHelper.GetAllDevices();
	}

	@GET
	@Path("/{deviceId}")
	@Produces(MediaType.APPLICATION_JSON)
	public Device getDevice(@PathParam("deviceId") int deviceId){
		return DeviceHelper.GetDevice(deviceId);
	}
	
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	// @Path("/devices")  // POST action + "devices" is a recommended URI to "create new device" resource
	public Device addDevice(Device newDevice){
		   return DeviceHelper.AddNewDevice(newDevice);
		}
}

