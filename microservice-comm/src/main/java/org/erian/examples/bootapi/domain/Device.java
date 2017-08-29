package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the Project database table.
 * 	[DeviceID] [int] IDENTITY(1000,1) NOT NULL,
	[DeviceName] [nvarchar](50) NOT NULL,
	[DeviceType] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Path] [nvarchar](100) NULL,
	[Address] [int] NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[UpdatedBy] [nvarchar](100) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[DeviceProtocolID] [int] NOT NULL,
 */
@Entity
public class Device implements Serializable {
	public static final long serialVersionUID = 1L;

	@Id
	@Column(name="DeviceID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer deviceID;
	
	@Column(name="DeviceName")
	public String deviceName;
	
	@Column(name="DeviceType")
	public String deviceType;
	
	@Column(name="Description")
	public String description;
	
	@Column(name="Path")
	public String path;
	
	@Column(name="Address")
	public Integer address;

	@Column(name="CreatedOn")
	public Date createdOn;

	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	public Device() {
	}
}