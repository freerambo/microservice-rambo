package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the Project database table.
	[DataPointID] [int] IDENTITY(1000,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[length] [int] NULL,
	[address] [int] NULL,
	[path] [nchar](256) NULL,
	[Description] [nvarchar](50) NULL,
	[IntervalID] [int] NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](100) NULL,
	[UpdatedOn] [datetime] NULL,
	[DeviceID] [int] NOT NULL,
	[Readable] [bit] NULL,
	[Writable] [bit] NULL,
	[InputExpression] [nchar](128) NULL,
	[OutPutExpression] [nchar](128) NULL,
	[Unit] [nchar](10) NULL,
 */
@Entity
public class DataPoint implements Serializable {
	public static final long serialVersionUID = 1L;

	@Id
	@Column(name="DataPointID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer dataPointID;
	
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
	
	@Column(name="IntervalID")
	public Integer intervalID;
	
	@Column(name="InputExpression")
	public String inputExpression;
	
	@Column(name="OutPutExpression")
	public String outPutExpression;
	
	@Column(name="DeviceID")
	public Integer deviceID;
	
	@Column(name="Readable")
	public Integer Readable;
	
	@Column(name="Writable")
	public Integer Writable;
	
	@Column(name="Unit")
	public String unit;
	
	@Column(name="CreatedOn")
	public Date createdOn;

	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	public DataPoint() {
	}
}