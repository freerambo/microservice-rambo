package com.erian.microgrid.communicationservice.api.CommunicationService;

import java.io.IOException;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.json.simple.JSONObject;

@Path("devicedata")

public class CommunicationResource {

@GET
@Path("/{ipAddress}/{command}")
@Produces(MediaType.APPLICATION_JSON)

public JSONObject getDataFromDevices(@PathParam("ipAddress") String ipAddress, @PathParam("command") String command) throws IOException, InterruptedException{
	System.out.println(ipAddress);
	System.out.println(command);
	String formattedCommand= command + "\n";
	return CommunicationHelper.getConnection(ipAddress, formattedCommand);
		}
	}

	
	

