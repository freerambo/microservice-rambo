package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the Communication database table.
	[DeviceProtocolID] [int] IDENTITY(1000,1) NOT NULL,
	[ProjCommID] [int] NOT NULL,
	[ProtocolID] [int] NOT NULL,
	[Description] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[UpdatedBy] [nvarchar](100) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
 */
@Entity
public class DeviceProtocol implements Serializable {
	public static final long serialVersionUID = 1L;

	@Id
	@Column(name="DeviceProtocolID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer deviceProtocolID;
	
	@Column(name="ProjCommID")
	public Integer projCommID;

	
	@Column(name="ProtocolID")
	public Integer protocolID;
	
	
	@Column(name="Description")
	public Integer description;
	
	
	@Column(name="CreatedBy")
	public String createdBy;

	@Column(name="CreatedOn")
	public Date createdOn;

	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	public DeviceProtocol() {
	}

}