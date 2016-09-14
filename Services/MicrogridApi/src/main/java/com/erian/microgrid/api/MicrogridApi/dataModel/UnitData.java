package com.erian.microgrid.api.MicrogridApi.dataModel;

public class UnitData {
	private int UnitID;
	private String UnitName;
	private String UnitDescription;
	
	public UnitData(){}
	
	public UnitData(int unitID, String unitName, String unitDescription) {
		super();
		UnitID = unitID;
		UnitName = unitName;
		UnitDescription = unitDescription;
	}
	public int getUnitID() {
		return UnitID;
	}
	public void setUnitID(int unitID) {
		UnitID = unitID;
	}
	public String getUnitName() {
		return UnitName;
	}
	public void setUnitName(String unitName) {
		UnitName = unitName;
	}
	public String getUnitDescription() {
		return UnitDescription;
	}
	public void setUnitDescription(String unitDescription) {
		UnitDescription = unitDescription;
	}
	
}
