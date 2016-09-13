package com.erian.microgrid.api.MicrogridApi.service;
import com.erian.microgrid.api.MicrogridApi.model.Device;

import java.util.List;


public class MessageService {

	public List<Device> getAllDevices(){
		ConfigurationHelper confHelper= new ConfigurationHelper();
	    return confHelper.GetAllDevices();
	}	

	public Device addNewDevice(Device newDevice) {
		ConfigurationHelper confHelper= new ConfigurationHelper();
		return confHelper.AddNewDevice(newDevice);
	}
}

