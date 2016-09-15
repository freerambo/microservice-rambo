package com.erian.microgrid.api.MicrogridApi.dataModel;

public class CommandData {
	private int ID;
	private String Name;
	private String Description;
	private String FormatString;
	private int DeviceID;
	
	public CommandData() {
		
	}

	public CommandData(int iD, String name, String description,
			String formatString, int deviceID) {
		super();
		ID = iD;
		Name = name;
		Description = description;
		FormatString = formatString;
		DeviceID = deviceID;
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}

	public String getFormatString() {
		return FormatString;
	}

	public void setFormatString(String formatString) {
		FormatString = formatString;
	}

	public int getDeviceID() {
		return DeviceID;
	}

	public void setDeviceID(int deviceID) {
		DeviceID = deviceID;
	}
	
}
