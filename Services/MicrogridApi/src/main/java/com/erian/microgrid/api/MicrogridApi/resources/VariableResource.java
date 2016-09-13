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
import com.erian.microgrid.api.MicrogridApi.service.VariableService;

@Path("/")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class VariableResource {

	private VariableService variableService = new VariableService();
	
	@GET
	public List<Variable> getAllVariables(@PathParam("deviceId") int deviceId) {

		return variableService.getAllVariables(deviceId);
	}
	
	@POST
	public Variable addVariable(@PathParam("deviceId") int deviceId, Variable variable) {
		return variableService.addVariable(deviceId, variable);
	}
	
	@PUT
	@Path("/{variableId}")
	public Variable updateVariable(@PathParam("deviceId") int deviceId, @PathParam("variableId") int variableId, Variable variable) {
		variable.setId(variableId);		
		return variableService.updateVariable(deviceId, variable);
	}
	
	@DELETE
	@Path("/{deviceId}")
	public void deleteVariable(@PathParam("deviceId") int deviceId, @PathParam("variableId") int variableId) {
		variableService.removeVariable(deviceId, variableId);
	}
	
	@GET
	@Path("/{variableId}")
	public Variable getVariable(@PathParam("deviceId") int deviceId, @PathParam("variableId") int variableId) {
		return variableService.getVariable(deviceId, variableId);
	}
	
	
}
