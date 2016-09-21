package com.erian.microgrid.api.MicrogridApi.resources;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.erian.microgrid.api.MicrogridApi.model.VariableValue;

@Path("/devices/{deviceID}/variables")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class VariableValueResource {

	/*
	 *  POST: http://localhost:8080/MicrogridApi/devices/1/variables/1/value
	 *  JSON: {"variableId": 1, "timestamp": "2016-06-09 11:05:45.0", "value": 123}
	 */
	@POST
	@Path("/{variableId}/value")
	public VariableValue addVariableValue(@PathParam("variableId") int variableId, VariableValue varValue) {
		varValue.setVariableId(variableId);
		return varValue;
	}
}
