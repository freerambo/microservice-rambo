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
	public static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ProtocolID")
	public Integer protocolID;

	@Column(name="CreatedBy")
	public String createdBy;

	@Column(name="CreatedOn")
	public Date createdOn;

	@Column(name="Description")
	public String description;

	@Column(name="Details")
	public String details;

	@Column(name="Name")
	public String name;

	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	public Protocol() {
	}
}