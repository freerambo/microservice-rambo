package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

@Entity
public class Device extends IdEntity implements Serializable {
	public static final long serialVersionUID = 1L;

	@Column(name="Name")
	public String name;
	
	@Column(name="Type")
	public String type;
	
	@Column(name="Description")
	public String description;
	
	@Column(name="protocol")
	public String protocol;
	
	@Column(name="Path")
	public String path;
	
	@Column(name="interval")
	public String interval;
	
	@Column(name="projectid")
	public Integer projectId;

	@Column(name="CreatedBy")
	public String createdBy;
	
	@Column(name="CreatedOn")
	public Date createdOn;

	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	public Device() {
	}
}