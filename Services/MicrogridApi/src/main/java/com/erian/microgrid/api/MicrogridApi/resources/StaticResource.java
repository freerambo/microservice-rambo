package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.erian.microgrid.api.MicrogridApi.model.Bus;
import com.erian.microgrid.api.MicrogridApi.model.DeviceType;
import com.erian.microgrid.api.MicrogridApi.model.Unit;
import com.erian.microgrid.api.MicrogridApi.service.StaticDataHelper;

@Path("/static")
@Produces(MediaType.APPLICATION_JSON)
public class StaticResource {	
	
	@GET	
	@Path("/deviceTypes")
	public List<DeviceType> getDeviceTypes(){
		try {
			return StaticDataHelper.GetDeviceTypes();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	@GET
	@Path("/buses")
	public List<Bus> getBuses(){
		try{
			List<Bus> res = StaticDataHelper.GetBuses();
			return res; //The server encountered an internal error that prevented it from fulfilling this request.
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}	
	
	@GET	
	@Path("/units")
	public List<Unit> getUnits(){
		try {
			return StaticDataHelper.GetUnits();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}

