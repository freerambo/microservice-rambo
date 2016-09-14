package com.erian.microgrid.api.MicrogridApi.service;

import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceData;
import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceTypeData;
import com.erian.microgrid.api.MicrogridApi.model.Device;
import com.erian.microgrid.api.MicrogridApi.model.DeviceType;

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
	
	public static DeviceData MapDevice(Device device) {
		DeviceData deviceData = new DeviceData();
		deviceData.setID(device.getID());
		deviceData.setTypeID(device.getTypeID());
		deviceData.setTypeName(device.getTypeName());
		deviceData.setClassID(device.getClassID());
		deviceData.setClassName(device.getClassName());
		deviceData.setName(device.getName());
		deviceData.setDescription(device.getDescription());
		deviceData.setMicrogridID(device.getMicrogridID());
		deviceData.setMicrogridName(device.getMicrogridName());
		deviceData.setVendor(device.getVendor());
		deviceData.setModel(device.getModel());
		deviceData.setLocation(device.getLocation());
		deviceData.setIPAdress(device.getIPAdress());
		deviceData.setPortNumber(device.getPortNumber());
		deviceData.setBusID(device.getBusID());
		deviceData.setIsProgrammable(device.getIsProgrammable());
		deviceData.setIsConnected(device.getIsConnected());

		return deviceData;
	}	
	
	public static DeviceType MapDeviceType(DeviceTypeData deviceTypeData) {
		DeviceType deviceType = new DeviceType();
		deviceType.setTypeID(deviceTypeData.getTypeID());
		deviceType.setClassID(deviceTypeData.getClassID());
		deviceType.setTypeName(deviceTypeData.getTypeName());
		deviceType.setClassName(deviceTypeData.getClassName());
		deviceType.setTypeDescription(deviceTypeData.getTypeDescription());
		deviceType.setClassDescription(deviceTypeData.getClassDescription());
		
		return deviceType;

	}	
}