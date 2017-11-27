package com.erian.microgrid.api.MicrogridApi.model;

public class Variable {
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
	
	public Variable() {
		
	}

	public Variable(int id, int deviceId, String name, String description,
			int getCommandId, int setCommandId,
			Boolean displayData, Boolean displayDiagram, 
			int unitId, String unitCode,
			int updatingDuration) {
		super();
		ID = id;
		DeviceID = deviceId;
		Name = name;
		Description = description;
		GetCommandID = getCommandId;
		SetCommandID = setCommandId;
		DisplayData = displayData;
		DisplayDiagram = displayDiagram;
		UnitID = unitId;
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

	public int getUpdatingDuration() {
		return UpdatingDuration;
	}

	public void setUpdatingDuration(int updatingDuration) {
		UpdatingDuration = updatingDuration;
	}

	public String getUnitCode() {
		return UnitCode;
	}

	public void setUnitCode(String unitCode) {
		UnitCode = unitCode;
	}

}
