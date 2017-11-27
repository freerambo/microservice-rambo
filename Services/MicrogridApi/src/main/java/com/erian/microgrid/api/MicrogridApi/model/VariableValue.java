package com.erian.microgrid.api.MicrogridApi.model;

public class VariableValue {
	private int variableId;
	private String timestamp;
	private float value;
	
	public VariableValue() {
		
	}

	public VariableValue(int variableId, String timestamp, float value) {
		super();
		this.variableId = variableId;
		this.timestamp = timestamp;
		this.value = value;
	}

	public int getVariableId() {
		return variableId;
	}

	public void setVariableId(int variableId) {
		this.variableId = variableId;
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
	
	
}
