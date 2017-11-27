package com.erian.microgrid.api.MicrogridApi.dataModel;

public class CommandProtocolData {
	private int id;
	private String name;
	private String description;
	
	public CommandProtocolData(int id, String name, String description) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
	}
	
	public CommandProtocolData() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
}
