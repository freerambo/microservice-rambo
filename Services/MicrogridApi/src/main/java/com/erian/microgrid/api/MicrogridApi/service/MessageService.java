package com.erian.microgrid.api.MicrogridApi.service;
import com.erian.microgrid.api.MicrogridApi.model.Device;

import java.util.List;


public class MessageService {

	public List<Device> getAllDevices(){
		DeviceHelper confHelper= new DeviceHelper();
	    return confHelper.GetAllDevices();
	}	

	public Device addNewDevice(Device newDevice) {
		DeviceHelper confHelper= new DeviceHelper();
		return confHelper.AddNewDevice(newDevice);
	}
}

