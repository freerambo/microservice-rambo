package com.erian.microgrid.api.MicrogridApi.model;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Device1 {
	//private int ID;
	private int TypeID;
	private String TypeName;
	private int ClassID;
	private String ClassName;
	private String Name;
	private String Description;
	private int MicrogridID;
	private String MicrogridName;
	private String Vendor;
	private String Model;
	private String Location;
	private String IPAdress;
	private String PortNumber;
	private int BusID;
	private int IsProgrammable;
	private int IsConnected;
	
	public Device1(){
		
	}
	
	public Device1(int device_type_id,String name,String description,int microgrid_id,String vendor,String model,String location,String ip_adress,String port_number,int bus_id,int is_programmable,int is_connected){
		//this.ID=ID;
		this.TypeID=device_type_id;
		//this.TypeName=TypeName;
		//this.ClassID=ClassID;
		//this.ClassName=ClassName;
		this.Name=name;
		this.Description=description;
		this.MicrogridID=microgrid_id;
		//this.MicrogridName=MicrogridName;
		this.Vendor=vendor;
		this.Model=model;
		this.Location=location;
		this.IPAdress=ip_adress;
		this.PortNumber=port_number;
		this.BusID=bus_id;
		this.IsProgrammable=is_programmable;
		this.IsConnected=is_connected;
		
	}

//	public int getID() {
//		return ID;
//	}
//
//	public void setID(int iD) {
//		ID = iD;
//	}

	public int getTypeID() {
		return TypeID;
	}

	public void setTypeID(int typeID) {
		TypeID = typeID;
	}

	public String getTypeName() {
		return TypeName;
	}

	public void setTypeName(String typeName) {
		TypeName = typeName;
	}

	public int getClassID() {
		return ClassID;
	}

	public void setClassID(int classID) {
		ClassID = classID;
	}

	public String getClassName() {
		return ClassName;
	}

	public void setClassName(String className) {
		ClassName = className;
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

	public int getMicrogridID() {
		return MicrogridID;
	}

	public void setMicrogridID(int microgridID) {
		MicrogridID = microgridID;
	}

	public String getMicrogridName() {
		return MicrogridName;
	}

	public void setMicrogridName(String microgridName) {
		MicrogridName = microgridName;
	}

	public String getVendor() {
		return Vendor;
	}

	public void setVendor(String vendor) {
		Vendor = vendor;
	}

	public String getModel() {
		return Model;
	}

	public void setModel(String model) {
		Model = model;
	}

	public String getLocation() {
		return Location;
	}

	public void setLocation(String location) {
		Location = location;
	}

	public String getIPAdress() {
		return IPAdress;
	}

	public void setIPAdress(String iPAdress) {
		IPAdress = iPAdress;
	}

	public String getPortNumber() {
		return PortNumber;
	}

	public void setPortNumber(String portNumber) {
		PortNumber = portNumber;
	}

	public int getBusID() {
		return BusID;
	}

	public void setBusID(int busID) {
		BusID = busID;
	}

	public int getIsProgrammable() {
		return IsProgrammable;
	}

	public void setIsProgrammable(int isProgrammable) {
		IsProgrammable = isProgrammable;
	}

	public int getIsConnected() {
		return IsConnected;
	}

	public void setIsConnected(int isConnected) {
		IsConnected = isConnected;
	}

	
	
}
