package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.erian.microgrid.api.MicrogridApi.model.DeviceType;
import com.erian.microgrid.api.MicrogridApi.service.StaticDataHelper;

@Path("/static")

public class StaticResource {	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/deviceTypes")
	public List<DeviceType> getDeviceTypes(){
		return StaticDataHelper.GetDeviceTypes();
	}

	
}

