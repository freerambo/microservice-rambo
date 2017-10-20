package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

@Entity
public class DataPoint extends IdEntity implements Serializable {
	public static final long serialVersionUID = 1L;

	
	@Column(name="Name")
	public String name;
	
	@Column(name="Type")
	public String type;
	
	@Column(name="Description")
	public String description;
	
	@Column(name="Path")
	public String path;
	
	@Column(name="Address")
	public Integer address;
	
	@Column(name="length")
	public Integer length;
	
	@Column(name="Interval")
	public String interval;
	
	@Column(name="InputExpression")
	public String inputExpression;
	
	@Column(name="OutPutExpression")
	public String outPutExpression;
	
/*	@Column(name="DeviceID")
	public Integer deviceId;*/
	
/*	@Column(name="Readable")
	public Integer readable;
	
	@Column(name="Writable")
	public Integer writable;*/
	
	@Column(name="ReadOnly")
	public boolean readOnly;
	@Column(name="WriteOnly")
	public boolean writeOnly;
	
	@Column(name="Unit")
	public String unit;
	
	@Column(name="SetValue")
	public String setValue;
	
	@Column(name="CreatedOn")
	public Date createdOn;

	@Column(name="CreatedBy")
	public String createdBy;

	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	
	@ManyToOne
	@JoinColumn(name = "deviceId")
	public Device device;
	
	
	public DataPoint() {
	}
}