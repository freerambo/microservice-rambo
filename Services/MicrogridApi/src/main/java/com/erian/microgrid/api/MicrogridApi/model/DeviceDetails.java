package com.erian.microgrid.api.MicrogridApi.model;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class DeviceDetails {

	private int deviceID;
	
	private String deviceName;
	
	private List<VariableDetails> varList = new ArrayList<VariableDetails>();

	public int getDeviceID() {
		return deviceID;
	}

	public void setDeviceID(int deviceID) {
		this.deviceID = deviceID;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public List<VariableDetails> getVarList() {
		return varList;
	}

	public void setVarList(List<VariableDetails> varList) {
		this.varList = varList;
	}

	
    
	

}
