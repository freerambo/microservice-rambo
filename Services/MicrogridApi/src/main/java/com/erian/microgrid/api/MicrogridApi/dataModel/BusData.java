package com.erian.microgrid.api.MicrogridApi.dataModel;

public class BusData {
	private int BusID;
	private String BusName;
	private String BusDescription;
	
	public BusData(){}
	
	public BusData(int busID, String busName, String busDescription) {
		super();
		BusID = busID;
		BusName = busName;
		BusDescription = busDescription;
	}
	
	public int getBusID() {
		return BusID;
	}
	public void setBusID(int busID) {
		BusID = busID;
	}
	public String getBusName() {
		return BusName;
	}
	public void setBusName(String busName) {
		BusName = busName;
	}
	public String getBusDescription() {
		return BusDescription;
	}
	public void setBusDescription(String busDescription) {
		BusDescription = busDescription;
	}
	
}
