package com.erian.microgrid.api.MicrogridApi.model;

public class Communication {
	
	public int variableId;
	public String variableName;
	public String commandFormatString;
	public String IPAdress;
	public String portNumber;	
	public int deviceId;
	public int commandId;
	
	public Communication() {
		
	}

	public Communication(int variableId, String variableName, String commandFormatString, String iPAdress,
			String portNumber, int deviceId, int commandId) {
		super();
		this.variableId = variableId;
		this.variableName = variableName;
		this.commandFormatString = commandFormatString;
		IPAdress = iPAdress;
		this.portNumber = portNumber;
		this.deviceId = deviceId;
		this.commandId = commandId;
	}
	
}
