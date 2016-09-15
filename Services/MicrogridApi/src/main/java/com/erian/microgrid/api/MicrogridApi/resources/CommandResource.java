package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.erian.microgrid.api.MicrogridApi.model.Command;
import com.erian.microgrid.api.MicrogridApi.service.CommandHelper;

@Path("/devices/{deviceID}/commands")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class CommandResource {
	
	@GET
	public List<Command> getAllCommands(@PathParam("deviceID") int deviceId) {
		return CommandHelper.getAllCommands(deviceId);
	}

}
