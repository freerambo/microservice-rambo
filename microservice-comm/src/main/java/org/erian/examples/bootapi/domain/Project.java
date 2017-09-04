package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import org.apache.commons.lang3.builder.ToStringBuilder;


/**
 * The persistent class for the Project database table.
 * 
 */
@Entity
@Table(name = "Project")
@NamedQuery(name="Project.findAll", query="SELECT p FROM Project p")
public class Project extends IdEntity implements Serializable {
	public static final long serialVersionUID = 1L;

	
	@Column(name="Name")
	public String name;
	
	@Column(name="Description")
	public String description;
	
	@Column(name="CreatedBy")
	public String createdBy;

	@Column(name="CreatedOn")
	public Date createdOn;

	@Column(name="logo")
	public String logo;

	@Column(name="UpdatedBy")
	public String updatedBy;

	@Column(name="UpdatedOn")
	public Date updatedOn;

	@Column(name="UserID")
	public int userId;
	
	public Project() {
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}