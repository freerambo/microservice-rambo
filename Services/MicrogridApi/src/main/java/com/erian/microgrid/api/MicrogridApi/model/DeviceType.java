package com.erian.microgrid.api.MicrogridApi.model;

public class DeviceType {
	private int TypeID;
	private String TypeName;
	private String TypeDescription;
	
	private int ClassID;
	private String ClassName;
	private String ClassDescription;	
		
	public DeviceType(int typeID, String typeName, String typeDescription, int classID, String className,
			String classDescription) {
		super();
		TypeID = typeID;
		TypeName = typeName;
		TypeDescription = typeDescription;
		ClassID = classID;
		ClassName = className;
		ClassDescription = classDescription;
	}

	public DeviceType() {
		
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

	public String getTypeDescription() {
		return TypeDescription;
	}

	public void setTypeDescription(String typeDescription) {
		TypeDescription = typeDescription;
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

	public String getClassDescription() {
		return ClassDescription;
	}

	public void setClassDescription(String classDescription) {
		ClassDescription = classDescription;
	}
}
