package com.erian.microgrid.api.MicrogridApi.model;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Device {
	private int ID;
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
	private String BusName;
	private int IsProgrammable;
	private int IsConnected;
	
	private int ReadCommandID;
	private String ReadCommand;
	private String comment;
	
	public Device(){
		
	}
	
	public Device(int ID,int TypeID,String TypeName,int ClassID,String ClassName,String Name,String Description,
					int MicrogridID,String MicrogridName,String Vendor,String Model,String Location,
					String IPAdress,String PortNumber,int BusID, String BusName, 
					int IsProgrammable,int IsConnected, String ReadCommand, String comment)
	{
		this.ID=ID;
		this.TypeID=TypeID;
		this.TypeName=TypeName;
		this.ClassID=ClassID;
		this.ClassName=ClassName;
		this.Name=Name;
		this.Description=Description;
		this.MicrogridID=MicrogridID;
		this.MicrogridName=MicrogridName;
		this.Vendor=Vendor;
		this.Model=Model;
		this.Location=Location;
		this.IPAdress=IPAdress;
		this.PortNumber=PortNumber;
		this.BusID=BusID;
		this.BusName = BusName;
		this.IsProgrammable=IsProgrammable;
		this.IsConnected=IsConnected;
		this.ReadCommand = ReadCommand;
		this.comment = comment;
		
	}
	

	public int getID() {
		return ID;
	}
	public void setID(int iD) {
		ID = iD;
	}
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
	
	public String getBusName() {
		return BusName;
	}

	public void setBusName(String busName) {
		BusName = busName;
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
	
	public String getReadCommand() {
		return ReadCommand;
	}

	public void setReadCommand(String readCommand) {
		ReadCommand = readCommand;
	}
	
	public int getReadCommandID() {
		return ReadCommandID;
	}

	public void setReadCommandID(int readCommandID) {
		ReadCommandID = readCommandID;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}


	
	

}
