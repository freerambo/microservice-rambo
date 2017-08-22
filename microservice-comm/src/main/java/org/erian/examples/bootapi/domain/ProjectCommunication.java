package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the Communication database table.
 * 	[ProjCommID] [int] IDENTITY(1000,1) NOT NULL,
	[ProjectID] [int] NOT NULL,
	[CommunicationID] [int] NOT NULL,
	[IntervalID] [int] NULL,
	[address] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedBy] [nvarchar](100) NULL,
	[UpdatedOn] [datetime] NULL,
 */
@Entity
@NamedQuery(name="ProjectCommunication.findAll", query="SELECT p FROM ProjectCommunication p")
public class ProjectCommunication implements Serializable {
	public static final long serialVersionUID = 1L;

	@Id
	@Column(name="ProjCommID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer projCommID;

	/*@ManyToOne
	@JoinColumn(name = "projectid")
	public Project project;
	
	@ManyToOne
	@JoinColumn(name = "communicationid")
	public Communication communication;*/
	
	@Column(name="CommunicationID")
	public Integer communicationID;
	
	@Column(name="ProjectID")
	public Integer projectID;

	@Column(name="IntervalID")
	public Integer intervalID;
	
	@Column(name="address")
	public String address;

	@Column(name="CreatedBy")
	public String createdBy;

	@Column(name="CreatedOn")
	public Date createdOn;

	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	public ProjectCommunication() {
	}

}