package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.List;

import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.erian.microgrid.api.MicrogridApi.model.Variable;
import com.erian.microgrid.api.MicrogridApi.service.VariableHelper;

@Path("/devices/{deviceID}/variables")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class VariableResource {

	private VariableHelper variableService = new VariableHelper();
	
	@GET
	public List<Variable> getAllVariables(@PathParam("deviceID") int deviceId) {

		return variableService.getAllVariables(deviceId);
	}
	
	@POST
	public Variable addVariable(@PathParam("deviceId") int deviceId, Variable variable) {
		return variableService.addVariable(deviceId, variable);
	}
	
	@PUT
	@Path("/{variableId}")
	public Variable updateVariable(@PathParam("deviceId") int deviceId, @PathParam("variableId") int variableId, Variable variable) {
		variable.setID(variableId);		
		return variableService.updateVariable(deviceId, variable);
	}
	
	@DELETE
	@Path("/{variableId}")
	public void deleteVariable(@PathParam("deviceId") int deviceId, @PathParam("variableId") int variableId) {
		variableService.removeVariable(deviceId, variableId);
	}
	
	@GET
	@Path("/{variableId}")
	public Variable getVariable(@PathParam("deviceId") int deviceId, @PathParam("variableId") int variableId) {
		return variableService.getVariable(deviceId, variableId);
	}
	
	
}
