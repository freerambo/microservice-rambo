package com.erian.microgrid.api.MicrogridApi.resources;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.ws.rs.BeanParam;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceValuesData;
import com.erian.microgrid.api.MicrogridApi.resources.beans.DateTimeFilterBean;
import com.erian.microgrid.api.MicrogridApi.service.DeviceValuesHelper;


@Path("/devices/{deviceID}/data")

public class DeviceValuesResource {

	// With filter: E.g. http://localhost:8080/MicrogridApi/devices/3/data?startDate=2016-06-09 11:05:45&endDate=2016-06-09 11:05:45
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public Response getDeviceData(@PathParam("deviceID") int deviceId, @BeanParam DateTimeFilterBean filterBean) throws ParseException {
		//System.out.println("startDate: " + filterBean.getStartDate() + " endDate: " + filterBean.getEndDate());
		JSONArray deviceValuesDataList = new JSONArray();
		List<DeviceValuesData> list = null;
		String strStartDate = filterBean.getStartDateString();
		String strEndDate = filterBean.getEndDateString();
		if(strStartDate != null || strEndDate != null) {
			list = DeviceValuesHelper.getDeviceValuesWithDatesString(deviceId, strStartDate, strEndDate);
		}
		else
			list = DeviceValuesHelper.getDeviceValues(deviceId);
		
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
