/*
 * Copyright: Energy Research Institute @ NTU
 * weather-api
 * org.erian.examples.bootapi.domain -> d.java
 * Created on 3 Apr 2017-1:58:25 pm
 */
package org.erian.examples.bootapi.domain;
import java.io.Serializable;
import javax.persistence.*;

import org.apache.commons.lang3.builder.ToStringBuilder;
/**
 * function description：
 *
 * @author <a href="mailto:zhuyb@ntu.edu.sg">Rambo Zhu  </a>
 * @version v 1.0 
 * Create:  3 Apr 2017 1:58:25 pm
 */

@Entity
public class ISSData implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private ISSDataPK id;

	@Column(name="dewpoint")
	private short dewPoint;

	@Column(name="dominantdir")
	private short dominantDir;

	@Column(name="et")
	private short et;

	@Column(name="heatindex")
	private short heatIndex;

	@Column(name="hirainrate")
	private short hiRainRate;

	@Column(name="hisolarrad")
	private short hiSolarRad;

	@Column(name="hitempout")
	private short hiTempOut;

	@Column(name="hiuv")
	private short hiUV;

	@Column(name="hiwinddir")
	private short hiWindDir;

	@Column(name="hiwindspeed")
	private short hiWindSpeed;

	@Column(name="humout")
	private short humOut;

	@Column(name="intervalindex")
	private short intervalIndex;

	@Column(name="lowtempout")
	private short lowTempOut;

	@Column(name="lowwindchill")
	private short lowWindChill;

	@Column(name="raincollectorinc")
	private float rainCollectorInc;

	@Column(name="raincollectortype")
	private short rainCollectorType;

	@Column(name="scaleravgwinddir")
	private short scalerAvgWindDir;

	@Column(name="solarrad")
	private short solarRad;

	@Column(name="tempout")
	private short tempOut;

	
	@Column(name="thswindex")
	private short THSWIndex;

	@Column(name="totalrainclicks")
	private short totalRainClicks;

	@Column(name="uv")
	private short uv;

	@Column(name="windspeed")
	private short windSpeed;

	public ISSData() {
	}

	public ISSDataPK getId() {
		return this.id;
	}

	public void setId(ISSDataPK id) {
		this.id = id;
	}

	public short getDewPoint() {
		return this.dewPoint;
	}

	public void setDewPoint(short dewPoint) {
		this.dewPoint = dewPoint;
	}

	public short getDominantDir() {
		return this.dominantDir;
	}

	public void setDominantDir(short dominantDir) {
		this.dominantDir = dominantDir;
	}

	public short getEt() {
		return this.et;
	}

	public void setEt(short et) {
		this.et = et;
	}

	public short getHeatIndex() {
		return this.heatIndex;
	}

	public void setHeatIndex(short heatIndex) {
		this.heatIndex = heatIndex;
	}

	public short getHiRainRate() {
		return this.hiRainRate;
	}

	public void setHiRainRate(short hiRainRate) {
		this.hiRainRate = hiRainRate;
	}

	public short getHiSolarRad() {
		return this.hiSolarRad;
	}

	public void setHiSolarRad(short hiSolarRad) {
		this.hiSolarRad = hiSolarRad;
	}

	public short getHiTempOut() {
		return this.hiTempOut;
	}

	public void setHiTempOut(short hiTempOut) {
		this.hiTempOut = hiTempOut;
	}

	public short getHiUV() {
		return this.hiUV;
	}

	public void setHiUV(short hiUV) {
		this.hiUV = hiUV;
	}

	public short getHiWindDir() {
		return this.hiWindDir;
	}

	public void setHiWindDir(short hiWindDir) {
		this.hiWindDir = hiWindDir;
	}

	public short getHiWindSpeed() {
		return this.hiWindSpeed;
	}

	public void setHiWindSpeed(short hiWindSpeed) {
		this.hiWindSpeed = hiWindSpeed;
	}

	public short getHumOut() {
		return this.humOut;
	}

	public void setHumOut(short humOut) {
		this.humOut = humOut;
	}

	public short getIntervalIndex() {
		return this.intervalIndex;
	}

	public void setIntervalIndex(short intervalIndex) {
		this.intervalIndex = intervalIndex;
	}

	public short getLowTempOut() {
		return this.lowTempOut;
	}

	public void setLowTempOut(short lowTempOut) {
		this.lowTempOut = lowTempOut;
	}

	public short getLowWindChill() {
		return this.lowWindChill;
	}

	public void setLowWindChill(short lowWindChill) {
		this.lowWindChill = lowWindChill;
	}

	public float getRainCollectorInc() {
		return this.rainCollectorInc;
	}

	public void setRainCollectorInc(float rainCollectorInc) {
		this.rainCollectorInc = rainCollectorInc;
	}

	public short getRainCollectorType() {
		return this.rainCollectorType;
	}

	public void setRainCollectorType(short rainCollectorType) {
		this.rainCollectorType = rainCollectorType;
	}

	public short getScalerAvgWindDir() {
		return this.scalerAvgWindDir;
	}

	public void setScalerAvgWindDir(short scalerAvgWindDir) {
		this.scalerAvgWindDir = scalerAvgWindDir;
	}

	public short getSolarRad() {
		return this.solarRad;
	}

	public void setSolarRad(short solarRad) {
		this.solarRad = solarRad;
	}

	public short getTempOut() {
		return this.tempOut;
	}

	public void setTempOut(short tempOut) {
		this.tempOut = tempOut;
	}

	public short getTHSWIndex() {
		return this.THSWIndex;
	}

	public void setTHSWIndex(short THSWIndex) {
		this.THSWIndex = THSWIndex;
	}

	public short getTotalRainClicks() {
		return this.totalRainClicks;
	}

	public void setTotalRainClicks(short totalRainClicks) {
		this.totalRainClicks = totalRainClicks;
	}

	public short getUv() {
		return this.uv;
	}

	public void setUv(short uv) {
		this.uv = uv;
	}

	public short getWindSpeed() {
		return this.windSpeed;
	}

	public void setWindSpeed(short windSpeed) {
		this.windSpeed = windSpeed;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}