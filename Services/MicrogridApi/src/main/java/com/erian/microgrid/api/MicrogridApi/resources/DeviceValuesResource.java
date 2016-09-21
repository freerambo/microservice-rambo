package com.erian.microgrid.api.MicrogridApi.resources;

import java.util.List;
import java.util.Map;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceValuesData;
import com.erian.microgrid.api.MicrogridApi.service.DeviceValuesHelper;


@Path("/devices/{deviceID}/data")

public class DeviceValuesResource {

	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getDeviceData(@PathParam("deviceID") int deviceId) {
		JSONArray deviceValuesDataList = new JSONArray();
		List<DeviceValuesData> list = DeviceValuesHelper.getDeviceValues(deviceId);
		
		for (DeviceValuesData devValues : list) {
			Map<String,String> map = devValues.getDict();
			JSONObject jsonObj = new JSONObject();
			for(Map.Entry<String, String> entry : map.entrySet()) {
				String key = entry.getKey();
				String value = entry.getValue();
				try {
					jsonObj.put(key, value);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			deviceValuesDataList.add(jsonObj);
		}

		return Response.status(Response.Status.OK)
				.entity(deviceValuesDataList.toString())
				.build();

	}

}
