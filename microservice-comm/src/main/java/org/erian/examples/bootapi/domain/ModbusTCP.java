package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
//@Table(name="modbus_tcp")
public class ModbusTCP extends IdEntity implements Serializable {
	public static final long serialVersionUID = 1L;
	
	public Integer deviceId;
	
	public String ip;
	
	public Integer port;
	
	public String description;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date createdOn;

	public String createdBy;
	
	public String updatedBy;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
	public Date updatedOn;

	public ModbusTCP() {
	}
}