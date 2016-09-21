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
		return CommunicationHelper.getAllReadCommands();
	}

}
