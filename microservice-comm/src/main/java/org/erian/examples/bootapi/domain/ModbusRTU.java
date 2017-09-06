package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

@Entity
public class ModbusRTU extends IdEntity implements Serializable {
	public static final long serialVersionUID = 1L;
	
	@Column(name="deviceid")
	public Integer deviceId;
	
	@Column(name="address")
	public String address;
	
	@Column(name="baudrate")
	public Integer baudrate;
	
	@Column(name="databit")
	public Integer databit;
	@Column(name="stopbit")
	public Integer stopbit;
	
	@Column(name="Parity")
	public String parity;
	
	@Column(name="encoding")
	public String encoding;
	
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

	public ModbusRTU() {
	}
}