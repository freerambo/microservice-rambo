package com.erian.microgrid.api.MicrogridApi.dataModel;

public class CommunicationData {
	
	public String variableIds; //  comma-separated list of IDs
	public String variableNames; //  comma-separated list of Names
	public String commandFormatString;
	public String IPAdress;
	public String portNumber;	
	public int deviceId;
	public int commandId;
	public String commandName;
	public int commandTypeId;
	public String commandTypeName;
	public int protocolId;
	public String protocolName;
	
	public CommunicationData() {
		
	}
	
}
