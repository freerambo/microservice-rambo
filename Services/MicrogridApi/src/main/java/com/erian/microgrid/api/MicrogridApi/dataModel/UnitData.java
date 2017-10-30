package com.erian.microgrid.api.MicrogridApi.dataModel;

public class UnitData {
	private int UnitID;
	private String UnitName;
	private String UnitDescription;
	/**
	 * add paramater unitCode by yuanbo, 2016-9-23 16:287:53
	 */
	private String unitCode;
	public UnitData(){}
	
	public UnitData(int unitID, String unitName, String unitDescription, String unitCode) {
		super();
		UnitID = unitID;
		UnitName = unitName;
		UnitDescription = unitDescription;
		 this.unitCode = unitCode;
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
	
	public String getUnitCode() {
		return unitCode;
	}

	public void setUnitCode(String unitCode) {
		this.unitCode = unitCode;
	}
}
