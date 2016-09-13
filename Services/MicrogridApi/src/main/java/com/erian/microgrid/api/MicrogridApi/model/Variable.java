package com.erian.microgrid.api.MicrogridApi.model;

public class Variable {
	private int Id;
	private int DeviceId;
	private String Name;
	private String Description;
	private int GetCommandId;
	private int SetCommandId;
	private Boolean DisplayData;
	private Boolean DisplayDiagram;
	private int Unit_Id;
	private int UpdatingDuration;
	
	public Variable() {
		
	}

	public Variable(int id, int deviceId, String name, String description,
			int getCommandId, int setCommandId,
			Boolean displayData, Boolean displayDiagram, int unit_Id,
			int updatingDuration) {
		super();
		Id = id;
		DeviceId = deviceId;
		Name = name;
		Description = description;
		GetCommandId = getCommandId;
		SetCommandId = setCommandId;
		DisplayData = displayData;
		DisplayDiagram = displayDiagram;
		Unit_Id = unit_Id;
		UpdatingDuration = updatingDuration;
	}

	public int getId() {
		return Id;
	}

	public void setId(int id) {
		Id = id;
	}

	public int getDeviceId() {
		return DeviceId;
	}

	public void setDeviceId(int deviceId) {
		DeviceId = deviceId;
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


	public int getGetCommandId() {
		return GetCommandId;
	}

	public void setGetCommandId(int getCommandId) {
		GetCommandId = getCommandId;
	}

	public int getSetCommandId() {
		return SetCommandId;
	}

	public void setSetCommandId(int setCommandId) {
		SetCommandId = setCommandId;
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

	public int getUnit_Id() {
		return Unit_Id;
	}

	public void setUnit_Id(int unit_Id) {
		Unit_Id = unit_Id;
	}

	public int getUpdatingDuration() {
		return UpdatingDuration;
	}

	public void setUpdatingDuration(int updatingDuration) {
		UpdatingDuration = updatingDuration;
	}


}
