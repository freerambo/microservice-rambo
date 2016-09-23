package com.erian.microgrid.api.MicrogridApi.resources;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.erian.microgrid.api.MicrogridApi.model.VariableValue;
import com.erian.microgrid.api.MicrogridApi.service.VariableValueHelper;

@Path("/data")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class VariableValueResource {

	/*
	 *  POST: http://localhost:8080/MicrogridApi/data
	 *  JSON: {"variableId": 1, "timestamp": "2016-06-09 11:05:45.0", "value": 123}
	 */
	@POST
	public VariableValue addVariableValue(VariableValue varValue) {
		try {
			return VariableValueHelper.addVariableValue(varValue);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
