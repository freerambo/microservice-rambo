package com.erian.microgrid.api.MicrogridApi.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Unit {
	private int UnitID;
	private String UnitName;
	private String UnitDescription;
	
	public Unit(){}
	
	public Unit(int unitID, String unitName, String unitDescription) {
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
