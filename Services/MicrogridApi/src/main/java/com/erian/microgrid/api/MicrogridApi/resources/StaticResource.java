package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.erian.microgrid.api.MicrogridApi.model.Bus;
import com.erian.microgrid.api.MicrogridApi.model.DeviceType;
import com.erian.microgrid.api.MicrogridApi.service.StaticDataHelper;

@Path("/static")
@Produces(MediaType.APPLICATION_JSON)
public class StaticResource {	
	
	@GET	
	@Path("/deviceTypes")
	public List<DeviceType> getDeviceTypes(){
		return StaticDataHelper.GetDeviceTypes();
	}
	
	@GET
	@Path("/buses")
	public List<Bus> getBuses(){
		try{
			List<Bus> res = StaticDataHelper.GetBuses();
			return res;
		}
		catch (Exception e){
			
		}
		return null;
	}	
}

