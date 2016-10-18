package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.eclipse.persistence.platform.database.HSQLPlatform;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.erian.microgrid.api.MicrogridApi.dataModel.CommunicationData;
import com.erian.microgrid.api.MicrogridApi.model.Command;
import com.erian.microgrid.api.MicrogridApi.model.Communication;
import com.erian.microgrid.api.MicrogridApi.service.CommandHelper;
import com.erian.microgrid.api.MicrogridApi.service.CommunicationHelper;

@Path("/devices/commands/read")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class AccessResource {
	
	@GET
	public List<Communication> getAllReadCommands() {
		try {
			return CommunicationHelper.getAllReadCommands();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@GET
	@Path("/switchOff")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	// With filter. E.g. http://localhost:8080/MicrogridApi/devices/commands/read/switchOff?deviceId=30&variableId=24
	public Response getSwitchOffCommand(@QueryParam("deviceId") int deviceId, @QueryParam("variableId") int variableId) {
		JSONObject jsonObj = new JSONObject();
		Map<String, String> map = CommandHelper.getSwitchOff(deviceId, variableId);
		for(Map.Entry<String, String> entry : map.entrySet()) {
			String key = entry.getKey();
			String value = entry.getValue();
			try {
				jsonObj.put(key, value);
			} catch (Exception e) {
				e.printStackTrace();
				continue;
			}
		}
		return Response.status(Response.Status.OK)
				.entity(jsonObj.toJSONString())
				.build();
	}
	
	@GET
	@Path("/switchOn")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	// With filter. E.g. http://localhost:8080/MicrogridApi/devices/commands/read/switchOn?deviceId=30&variableId=24
	public Response getSwitchOnCommand(@QueryParam("deviceId") int deviceId, @QueryParam("variableId") int variableId) {
		JSONObject jsonObj = new JSONObject();
		Map<String, String> map = CommandHelper.getSwitchOn(deviceId, variableId);
		for(Map.Entry<String, String> entry : map.entrySet()) {
			String key = entry.getKey();
			String value = entry.getValue();
			try {
				jsonObj.put(key, value);
			} catch (Exception e) {
				e.printStackTrace();
				continue;
			}
		}
		return Response.status(Response.Status.OK)
				.entity(jsonObj.toJSONString())
				.build();
	}

}
