package com.erian.ict.microgrid.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

@Entity
public class DataPoint extends IdEntity implements Serializable {
	public static final long serialVersionUID = 1L;

	
	public String name;
	
	public String type;
	
	public String description;
	
	public String path;
	
	public Integer address;
	
	public Integer length;
	
	public String interval;
	
	public String inputExpression;
	
	public String outputExpression;
	
/*	@Column(name="DeviceID")
	public Integer deviceId;*/
	
/*	@Column(name="Readable")
	public Integer readable;
	
	@Column(name="Writable")
	public Integer writable;*/
	
	public boolean readOnly;
	
	public boolean writeOnly;
	
	public String unit;
	
	public String setValue;
	
	public Date createdOn;

	public String createdBy;

	public String updatedBy;

	public Date updatedOn;

	public Integer deviceId;
	
	public DataPoint() {
	}
}