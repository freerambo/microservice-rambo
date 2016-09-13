package com.erian.microgrid.api.MicrogridApi.service;

import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceData;
import com.erian.microgrid.api.MicrogridApi.model.Device;

public final class Mapper {

	public static Device MapDevice(DeviceData deviceData) {
		Device device = new Device();
		device.setID(deviceData.getID());
		device.setTypeID(deviceData.getTypeID());
		device.setTypeName(deviceData.getTypeName());
		device.setClassID(deviceData.getClassID());
		device.setClassName(deviceData.getClassName());
		device.setName(deviceData.getName());
		device.setDescription(deviceData.getDescription());
		device.setMicrogridID(deviceData.getMicrogridID());
		device.setMicrogridName(deviceData.getMicrogridName());
		device.setVendor(deviceData.getVendor());
		device.setModel(deviceData.getModel());
		device.setLocation(deviceData.getLocation());
		device.setIPAdress(deviceData.getIPAdress());
		device.setPortNumber(deviceData.getPortNumber());
		device.setBusID(deviceData.getBusID());
		device.setIsProgrammable(deviceData.getIsProgrammable());
		device.setIsConnected(deviceData.getIsConnected());

		return device;

	}
}