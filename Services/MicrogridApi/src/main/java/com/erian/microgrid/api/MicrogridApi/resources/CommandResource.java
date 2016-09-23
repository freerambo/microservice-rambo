package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
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
		try {
			return CommandHelper.getAllCommands(deviceId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Command addCommand(@PathParam("deviceId") int deviceId, Command command) {
		try {
			return CommandHelper.addNewCommand(deviceId, command);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	@PUT
	@Path("/{commandId}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Command updateCommand(@PathParam("commandId") int commandId, Command command) {
		try {
			command.setID(commandId);		
			return CommandHelper.updateCommand(command);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
