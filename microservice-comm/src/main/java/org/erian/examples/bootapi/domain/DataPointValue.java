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
public class DataPointValue implements Serializable {
	public static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="DataPointValueID")
	public Integer dataPointValueID;

	@Column(name="DataPointID")
	public Integer dataPointID;

	@Column(name="Timestamp")
	public Date timestamp;

	@Column(name="Value")
	public double value;

	public DataPointValue() {
	}

	

}