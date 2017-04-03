/*
 * Copyright: Energy Research Institute @ NTU
 * weather-api
 * org.erian.examples.bootapi.domain -> ISSDataPK.java
 * Created on 3 Apr 2017-1:59:11 pm
 */
package org.erian.examples.bootapi.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

/**
 * The primary key class for the ISSData database table.
 * 
 */
@Embeddable
public class ISSDataPK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(name="receiverrecid")
	public int receiverRecID;

	@Column(name="channelindex")
	protected byte channelIndex;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="recdatetime")
	protected Date recDateTime;

	public ISSDataPK() {
	}
	public int getReceiverRecID() {
		return this.receiverRecID;
	}
	public void setReceiverRecID(int receiverRecID) {
		this.receiverRecID = receiverRecID;
	}
	public byte getChannelIndex() {
		return this.channelIndex;
	}
	public void setChannelIndex(byte channelIndex) {
		this.channelIndex = channelIndex;
	}
	public java.util.Date getRecDateTime() {
		return this.recDateTime;
	}
	public void setRecDateTime(java.util.Date recDateTime) {
		this.recDateTime = recDateTime;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof ISSDataPK)) {
			return false;
		}
		ISSDataPK castOther = (ISSDataPK)other;
		return 
			(this.receiverRecID == castOther.receiverRecID)
			&& (this.channelIndex == castOther.channelIndex)
			&& this.recDateTime.equals(castOther.recDateTime);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.receiverRecID;
		hash = hash * prime + ((int) this.channelIndex);
		hash = hash * prime + this.recDateTime.hashCode();
		
		return hash;
	}
	
	
}