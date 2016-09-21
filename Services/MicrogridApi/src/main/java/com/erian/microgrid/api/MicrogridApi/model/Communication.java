package com.erian.microgrid.api.MicrogridApi.model;

import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

import org.glassfish.jersey.server.JSONP;

@XmlRootElement
public class Communication {
	
	public int variableId;
	public String variableName;
	public String commandFormatString;
	public String IPAdress;
	public String portNumber;	
	public int deviceId;
	public int commandId;
	
	public Date valueTimestamp;  // TODO find why Date fields are excluded from Json response and how to include them. Then can change String to DateTime
	public float value;
	
	public Communication() {
		valueTimestamp = new Date();
	}

	public Communication(int variableId, String variableName, String commandFormatString, String iPAdress,
			String portNumber, int deviceId, int commandId, Date valueTimestamp, float value) {
		super();
		this.variableId = variableId;
		this.variableName = variableName;
		this.commandFormatString = commandFormatString;
		IPAdress = iPAdress;
		this.portNumber = portNumber;
		this.deviceId = deviceId;
		this.commandId = commandId;
		this.valueTimestamp = valueTimestamp;
		this.value = value;
	}

	
	
}
