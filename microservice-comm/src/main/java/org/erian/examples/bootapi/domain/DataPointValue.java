package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the DataPointValue database table.
 * 
 */
@Entity
@NamedQuery(name="DataPointValue.findAll", query="SELECT d FROM DataPointValue d")
public class DataPointValue extends IdEntity implements Serializable {
	public static final long serialVersionUID = 1L;



	@Column(name="DataPointID")
	public Integer dataPointId;

	@Column(name="Timestamp")
	public Date timestamp;

	@Column(name="Value")
	public double value;

	public DataPointValue() {
	}

	

}