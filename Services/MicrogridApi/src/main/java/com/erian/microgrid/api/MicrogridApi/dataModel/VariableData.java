package com.erian.microgrid.api.MicrogridApi.dataModel;

public class VariableData {
	private int ID;
	private int DeviceID;
	private String Name;
	private String Description;
	private int GetCommandID;
	private int SetCommandID;
	private Boolean DisplayData;
	private Boolean DisplayDiagram;
	private int UnitID;
	private String UnitCode;
	private int UpdatingDuration;
	
	public VariableData() {
		
	}

	public VariableData(int iD, int deviceID, String name, String description,
			int getCommandID, int setCommandID, 
			Boolean displayData, Boolean displayDiagram, 
			int unitID, String unitCode, int updatingDuration) {
		super();
		ID = iD;
		DeviceID = deviceID;
		Name = name;
		Description = description;
		GetCommandID = getCommandID;
		SetCommandID = setCommandID;
		DisplayData = displayData;
		DisplayDiagram = displayDiagram;
		UnitID = unitID;
		UnitCode = unitCode;
		UpdatingDuration = updatingDuration;
	}

	public int getID() {
		return ID;
	}

	public void setID(int iD) {
		ID = iD;
	}

	public int getDeviceID() {
		return DeviceID;
	}

	public void setDeviceID(int deviceID) {
		DeviceID = deviceID;
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

	public int getGetCommandID() {
		return GetCommandID;
	}

	public void setGetCommandID(int getCommandID) {
		GetCommandID = getCommandID;
	}

	public int getSetCommandID() {
		return SetCommandID;
	}

	public void setSetCommandID(int setCommandID) {
		SetCommandID = setCommandID;
	}

	public Boolean getDisplayData() {
		return DisplayData;
	}

	public void setDisplayData(Boolean displayData) {
		DisplayData = displayData;
	}

	public Boolean getDisplayDiagram() {
		return DisplayDiagram;
	}

	public void setDisplayDiagram(Boolean displayDiagram) {
		DisplayDiagram = displayDiagram;
	}

	public int getUnitID() {
		return UnitID;
	}

	public void setUnitID(int unitID) {
		UnitID = unitID;
	}

	public String getUnitCode() {
		return UnitCode;
	}

	public void setUnitCode(String unitCode) {
		UnitCode = unitCode;
	}

	public int getUpdatingDuration() {
		return UpdatingDuration;
	}

	public void setUpdatingDuration(int updatingDuration) {
		UpdatingDuration = updatingDuration;
	}
	
	
}
