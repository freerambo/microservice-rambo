package com.erian.microgrid.websocket.api.WebSocketCommunication;

import java.io.IOException;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;


@Path("converterdata")
public class WebsocketResource{
	
@GET
@Path("/query")
@Produces(MediaType.APPLICATION_JSON)

public JSONObject getDataFromConverters(@QueryParam("command") String command) throws IOException, InterruptedException, ParseException{
	System.out.println(command);
	return WebsocketHelper.Start(command);
			}
	
}