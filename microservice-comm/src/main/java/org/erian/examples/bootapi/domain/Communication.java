package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;




/**
 * The persistent class for the Communication database table.
 * 
 */
@Entity
@NamedQuery(name="Communication.findAll", query="SELECT c FROM Communication c")
public class Communication implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="CommunicationID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int communicationID;

	@Column(name="CommunicationName")
	private String communicationName;

	@Column(name="CreatedBy")
	private String createdBy;

	@Column(name="CreatedOn")
	private Date createdOn;

	@Column(name="Description")
	private String description;

	@Column(name="Details")
	private String details;

	@Column(name="UpdatedBy")
	private String updatedBy;

	@Column(name="UpdatedOn")
	private Date updatedOn;

	public Communication() {
	}

	public int getCommunicationID() {
		return this.communicationID;
	}

	public void setCommunicationID(int communicationID) {
		this.communicationID = communicationID;
	}

	public String getCommunicationName() {
		return this.communicationName;
	}

	public void setCommunicationName(String communicationName) {
		this.communicationName = communicationName;
	}

	public String getCreatedBy() {
		return this.createdBy;
	}

	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}

	public Date getCreatedOn() {
		return this.createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDetails() {
		return this.details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getUpdatedBy() {
		return this.updatedBy;
	}

	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}

	public Date getUpdatedOn() {
		return this.updatedOn;
	}

	public void setUpdatedOn(Date updatedOn) {
		this.updatedOn = updatedOn;
	}

}