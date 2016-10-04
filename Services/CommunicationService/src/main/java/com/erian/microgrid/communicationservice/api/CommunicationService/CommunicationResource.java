package com.erian.microgrid.communicationservice.api.CommunicationService;

import java.io.IOException;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

import org.json.simple.JSONObject;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

@Path("Data")
@Api(value = "/Data")
public class CommunicationResource {

@GET
@Path("/{ipAddress}/{command}")
@Produces(MediaType.APPLICATION_JSON)
@ApiOperation(value = "/getDataFromDevices", notes = "Communication API - get Data From Devices with IP and Command")
@ApiResponses(value = { @ApiResponse(code = 200, message = "OK"),
		@ApiResponse(code = 400, message = "Bad Request"),
		@ApiResponse(code = 401, message = "Unauthorized") ,
		@ApiResponse(code = 404, message = "Not Found"),
		@ApiResponse(code = 403, message = "Request Forbidden") })

public JSONObject getDataFromDevices(@PathParam("ipAddress") String ipAddress, @PathParam("command") String command) throws IOException{
	System.out.println(ipAddress);
	System.out.println(command);
	String formattedCommand= command + "\n";
	return CommunicationHelper.getConnection(ipAddress, formattedCommand);
		}
	}

	
	

