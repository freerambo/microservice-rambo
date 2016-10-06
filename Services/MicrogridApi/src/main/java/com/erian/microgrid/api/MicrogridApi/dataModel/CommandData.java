package com.erian.microgrid.api.MicrogridApi.dataModel;

public class CommandData {
	private int ID;
	private String Name;
	private String Description;
	private String FormatString;
	private int DeviceID;
	
	private int ProtocolID;
	private String ProtocolName;
	private int CommandTypeID;
	private String CommandTypeName;
	
	public CommandData() {
		
	}

	public CommandData(int iD, String name, String description,
			String formatString, int deviceID, int protocolId, String protocolName, int commandTypeId,
			String commandTypeName) {
		super();
		ID = iD;
		Name = name;
		Description = description;
		FormatString = formatString;
		DeviceID = deviceID;
		ProtocolID = protocolId;
		ProtocolName = protocolName;
		CommandTypeID = commandTypeId;
		CommandTypeName = commandTypeName;
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
	
	public int getProtocolID() {
		return ProtocolID;
	}
	
	public void setProtocolID(int protocolID) {
		ProtocolID = protocolID;
	}
	
	public String getProtocolName() {
		return ProtocolName;
	}
	
	public void setProtocolName(String protocolName) {
		ProtocolName = protocolName;
	}
	
	public int getCommandTypeID() {
		return CommandTypeID;
	}
	
	public void setCommandTypeID(int commandTypeID) {
		CommandTypeID = commandTypeID;
	}
	
	public String getCommandTypeName() {
		return CommandTypeName;
	}
	
	public void setCommandTypeName(String commandTypeName) {
		CommandTypeName = commandTypeName; 
	}
	
	public String getInputVariables() {
		//TODO
		return new String();
	}
	
	public void setInputVariables(String inputVariables) {
		//TODO
	}
	
	public String getOutputVariables() {
		//TODO
		return new String();
	}
	
	public void setOutputVariables(String outputVariables) {
		//TODO
	}
}
