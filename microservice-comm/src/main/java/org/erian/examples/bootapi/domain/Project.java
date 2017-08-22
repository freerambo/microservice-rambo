package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the Project database table.
 * 
 */
@Entity
@Table(name = "Project")
@NamedQuery(name="Project.findAll", query="SELECT p FROM Project p")
public class Project implements Serializable {
	public static final long serialVersionUID = 1L;

	@Id
	@Column(name="projectid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	public Integer projectid;
	public Integer projectID;
	
	@Column(name="ProjectName")
	public String projectName;
	
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
}