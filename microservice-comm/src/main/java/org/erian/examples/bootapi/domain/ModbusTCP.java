package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

@Entity
public class ModbusTCP extends IdEntity implements Serializable {
	public static final long serialVersionUID = 1L;
	
	@Column(name="deviceid")
	public Integer deviceId;
	
	@Column(name="ip")
	public String ip;
	
	@Column(name="port")
	public Integer port;
	
	@Column(name="Description")
	public String description;
	
	@Column(name="CreatedOn")
	public Date createdOn;
	
	@Column(name="createdBy")
	public String createdBy;
	
	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	public ModbusTCP() {
	}
}