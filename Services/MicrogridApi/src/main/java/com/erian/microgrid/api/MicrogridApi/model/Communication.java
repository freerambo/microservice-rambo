package com.erian.microgrid.api.MicrogridApi.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import org.glassfish.jersey.server.JSONP;

@XmlRootElement
public class Communication {
	
	public List<String> variableIds;
	public List<String> variableNames;
	public String commandFormatString;
	public String IPAdress;
	public String portNumber;	
	public int deviceId;
	public int commandId;
	public String commandName;
	
	public Date valueTimestamp;  // TODO find why Date fields are excluded from Json response and how to include them. Then can change String to DateTime
	public float value;
	
	public Communication() {
		valueTimestamp = new Date();
		this.variableIds = new ArrayList<String>();
		this.variableNames = new ArrayList<String>();
	}

	public Communication(List<String> variableIds, List<String> variableNames, String commandFormatString,
			String iPAdress, String portNumber, int deviceId, int commandId) {
		super();
		this.variableIds = variableIds;
		this.variableNames = variableNames;
		this.commandFormatString = commandFormatString;
		IPAdress = iPAdress;
		this.portNumber = portNumber;
		this.deviceId = deviceId;
		this.commandId = commandId;
	}

	
	
}
