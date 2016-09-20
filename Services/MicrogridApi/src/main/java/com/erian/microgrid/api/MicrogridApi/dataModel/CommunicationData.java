package com.erian.microgrid.api.MicrogridApi.dataModel;

public class CommunicationData {
	
	public int variableId;
	public String variableName;
	public String commandFormatString;
	public String IPAdress;
	public String portNumber;	
	public int deviceId;
	public int commandId;
	
	public CommunicationData() {
		
	}

	public CommunicationData(int variableId, String variableName, String commandFormatString, String iPAdress,
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
