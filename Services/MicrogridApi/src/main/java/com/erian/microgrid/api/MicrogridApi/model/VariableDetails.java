package com.erian.microgrid.api.MicrogridApi.model;

public class VariableDetails {
	
	private int variableID;
	
	private String variableName; 
	
	private String timestamp;
	
	private float value;
	
	private String url_ON;
	
	private String url_OFF;
	
	private int isSwitcher;
	
	private int isLink;

	public int getVariableID() {
		return variableID;
	}

	public void setVariableID(int variableID) {
		this.variableID = variableID;
	}

	public String getVariableName() {
		return variableName;
	}

	public void setVariableName(String variableName) {
		this.variableName = variableName;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public float getValue() {
		return value;
	}

	public void setValue(float value) {
		this.value = value;
	}

	public String getUrl_ON() {
		return url_ON;
	}

	public void setUrl_ON(String url_ON) {
		this.url_ON = url_ON;
	}

	public String getUrl_OFF() {
		return url_OFF;
	}

	public void setUrl_OFF(String url_OFF) {
		this.url_OFF = url_OFF;
	}

	public int getIsSwitcher() {
		return isSwitcher;
	}

	public void setIsSwitcher(int isSwitcher) {
		this.isSwitcher = isSwitcher;
	}

	public int getIsLink() {
		return isLink;
	}

	public void setIsLink(int isLink) {
		this.isLink = isLink;
	}
	
	

}
