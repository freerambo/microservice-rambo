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
	public static final long serialVersionUID = 1L;

	@Id
	@Column(name="CommunicationID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Integer communicationID;

	@Column(name="CommunicationName")
	public String communicationName;

	@Column(name="CreatedBy")
	public String createdBy;

	@Column(name="CreatedOn")
	public Date createdOn;

	@Column(name="Description")
	public String description;

	@Column(name="Details")
	public String details;

	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	public Communication() {
	}

}