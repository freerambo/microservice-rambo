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

	//private VariableHelper variableService = new VariableHelper();
	
	@GET
	public List<Variable> getAllVariables(@PathParam("deviceID") int deviceId) {
		try {
			return VariableHelper.getAllVariables(deviceId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Variable addVariable(@PathParam("deviceId") int deviceId, Variable variable) {
		try {
			return VariableHelper.addNewVariable(deviceId, variable);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@PUT
	@Path("/{variableId}")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Variable updateVariable(@PathParam("variableId") int variableId, Variable variable) {
		try {
			variable.setID(variableId);		
			return VariableHelper.updateVariable(variable);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@DELETE
	@Path("/{variableId}")
	public void deleteVariable(@PathParam("deviceId") int deviceId, @PathParam("variableId") int variableId) {
		try {
			VariableHelper.removeVariable(deviceId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@GET
	@Path("/{variableId}")
	public Variable getVariable(@PathParam("variableId") int variableId) {
		try {
			return VariableHelper.getVariable(variableId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	@GET
	@Path("/{variableId}/read")
	public Communication getVariableReadCommand(@PathParam("variableId") int variableId) {
		try {
			return CommunicationHelper.getReadCommand(variableId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	*/
}
