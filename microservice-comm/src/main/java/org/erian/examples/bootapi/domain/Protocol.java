package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the Protocol database table.
 * 
 */
@Entity
@NamedQuery(name="Protocol.findAll", query="SELECT p FROM Protocol p")
public class Protocol implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="ProtocolID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int protocolID;

	@Column(name="CreatedBy")
	private String createdBy;

	@Column(name="CreatedOn")
	private Date createdOn;

	@Column(name="Description")
	private String description;

	@Column(name="Details")
	private String details;

	@Column(name="Name")
	private String name;

	@Column(name="UpdatedBy")
	private String updatedBy;

	@Column(name="UpdatedOn")
	private Date updatedOn;

	public Protocol() {
	}

	public int getProtocolID() {
		return this.protocolID;
	}

	public void setProtocolID(int protocolID) {
		this.protocolID = protocolID;
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

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
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