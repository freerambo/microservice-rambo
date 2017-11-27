package com.erian.ict.microgrid.domain.model;

import java.util.Date;

/**
 * Created by nhdevika on 2/14/2017.
 */
public class BatteryConverter {

    private Date updatedTimestamp;

    private String deviceId;

    private double inductorCurrentChannel1;

    private double inductorCurrentChannel2;

    private double inductorCurrentChannel3;

    private double outputCurrent;

    private double refVolumeConfirm;

    private double droopCoefConfirm;

    private long channel1Status;

    private long channel2Status;

    private long channel3Status;

    private long inputRelayStatus;

    private long outputRelayStatus;

    private long mode;

    private long faultMessage;

    private double heatSinkTemp;

    private double refPowerConfirm;

    private double voltage;

    private double DCBusVolatge;
    
    private int batSoc;

    private String operatingPower;

    public Date getUpdatedTimestamp() {
        return updatedTimestamp;
    }

    public void setUpdatedTimestamp(Date updatedTimestamp) {
        this.updatedTimestamp = updatedTimestamp;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public double getInductorCurrentChannel1() {
        return inductorCurrentChannel1;
    }

    public void setInductorCurrentChannel1(double inductorCurrentChannel1) {
        this.inductorCurrentChannel1 = inductorCurrentChannel1;
    }

    public double getInductorCurrentChannel2() {
        return inductorCurrentChannel2;
    }

    public void setInductorCurrentChannel2(double inductorCurrentChannel2) {
        this.inductorCurrentChannel2 = inductorCurrentChannel2;
    }

    public double getInductorCurrentChannel3() {
        return inductorCurrentChannel3;
    }

    public void setInductorCurrentChannel3(double inductorCurrentChannel3) {
        this.inductorCurrentChannel3 = inductorCurrentChannel3;
    }

    public double getOutputCurrent() {
        return outputCurrent;
    }

    public void setOutputCurrent(double outputCurrent) {
        this.outputCurrent = outputCurrent;
    }

    public double getRefVolumeConfirm() {
        return refVolumeConfirm;
    }

    public void setRefVolumeConfirm(double refVolumeConfirm) {
        this.refVolumeConfirm = refVolumeConfirm;
    }

    public double getDroopCoefConfirm() {
        return droopCoefConfirm;
    }

    public void setDroopCoefConfirm(double droopCoefConfirm) {
        this.droopCoefConfirm = droopCoefConfirm;
    }

    public long getChannel1Status() {
        return channel1Status;
    }

    public void setChannel1Status(long channel1Status) {
        this.channel1Status = channel1Status;
    }

    public long getChannel2Status() {
        return channel2Status;
    }

    public void setChannel2Status(long channel2Status) {
        this.channel2Status = channel2Status;
    }

    public long getChannel3Status() {
        return channel3Status;
    }

    public void setChannel3Status(long channel3Status) {
        this.channel3Status = channel3Status;
    }

    public long getInputRelayStatus() {
        return inputRelayStatus;
    }

    public void setInputRelayStatus(long inputRelayStatus) {
        this.inputRelayStatus = inputRelayStatus;
    }

    public long getOutputRelayStatus() {
        return outputRelayStatus;
    }

    public void setOutputRelayStatus(long outputRelayStatus) {
        this.outputRelayStatus = outputRelayStatus;
    }

    public long getMode() {
        return mode;
    }

    public void setMode(long mode) {
        this.mode = mode;
    }

    public int getBatSoc() {
		return batSoc;
	}

	public void setBatSoc(int batSoc) {
		this.batSoc = batSoc;
	}

	public long getFaultMessage() {
        return faultMessage;
    }

    public void setFaultMessage(long faultMessage) {
        this.faultMessage = faultMessage;
    }

    public double getHeatSinkTemp() {
        return heatSinkTemp;
    }

    public void setHeatSinkTemp(double heatSinkTemp) {
        this.heatSinkTemp = heatSinkTemp;
    }

    public double getRefPowerConfirm() {
        return refPowerConfirm;
    }

    public void setRefPowerConfirm(double refPowerConfirm) {
        this.refPowerConfirm = refPowerConfirm;
    }

    public double getVoltage() {
        return voltage;
    }

    public void setVoltage(double voltage) {
        this.voltage = voltage;
    }

    public double getDCBusVolatge() {
        return DCBusVolatge;
    }

    public void setDCBusVolatge(double DCBusVolatge) {
        this.DCBusVolatge = DCBusVolatge;
    }

    public String getOperatingPower() {
        return operatingPower;
    }

    public void setOperatingPower(String operatingPower) {
        this.operatingPower = operatingPower;
    }
}
