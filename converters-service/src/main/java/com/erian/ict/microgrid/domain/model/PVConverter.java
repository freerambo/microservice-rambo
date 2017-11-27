package com.erian.ict.microgrid.domain.model;

import org.springframework.scheduling.annotation.Scheduled;

import java.util.Date;

/**
 * Created by nhdevika on 2/14/2017.
 */

public class PVConverter {

    private Date updatedTimestamp;

    private double inductorCurrentChannel1;

    private double inductorCurrentChannel2;

    private double inductorCurrentChannel3;

    private double voltageChannel1;

    private double voltageChannel2;

    private double voltageChannel3;

    private long modeChannel1;

    private long modeChannel2;

    private long modeChannel3;

    private double referencePowerChannel1;

    private double referencePowerChannel2;

    private double referencePowerChannel3;

    private long inputRelayStatus;

    private long outputRelayStatus;

    private long priorChannel1;

    private long priorChannel2;

    private long priorChannel3;

    private double outputCurrent;

    private double voltageForDC;

    private String powerChannel1;

    private String powerChannel2;

    private String powerChannel3;

    private String deviceId;

    public Date getUpdatedTimestamp() {
        return updatedTimestamp;
    }

    public void setUpdatedTimestamp(Date updatedTimestamp) {
        this.updatedTimestamp = updatedTimestamp;
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

    public double getVoltageChannel1() {
        return voltageChannel1;
    }

    public void setVoltageChannel1(double voltageChannel1) {
        this.voltageChannel1 = voltageChannel1;
    }

    public double getVoltageChannel2() {
        return voltageChannel2;
    }

    public void setVoltageChannel2(double voltageChannel2) {
        this.voltageChannel2 = voltageChannel2;
    }

    public double getVoltageChannel3() {
        return voltageChannel3;
    }

    public void setVoltageChannel3(double voltageChannel3) {
        this.voltageChannel3 = voltageChannel3;
    }

    public long getModeChannel1() {
        return modeChannel1;
    }

    public void setModeChannel1(long modeChannel1) {
        this.modeChannel1 = modeChannel1;
    }

    public long getModeChannel2() {
        return modeChannel2;
    }

    public void setModeChannel2(long modeChannel2) {
        this.modeChannel2 = modeChannel2;
    }

    public long getModeChannel3() {
        return modeChannel3;
    }

    public void setModeChannel3(long modeChannel3) {
        this.modeChannel3 = modeChannel3;
    }

    public double getReferencePowerChannel1() {
        return referencePowerChannel1;
    }

    public void setReferencePowerChannel1(double referencePowerChannel1) {
        this.referencePowerChannel1 = referencePowerChannel1;
    }

    public double getReferencePowerChannel2() {
        return referencePowerChannel2;
    }

    public void setReferencePowerChannel2(double referencePowerChannel2) {
        this.referencePowerChannel2 = referencePowerChannel2;
    }

    public double getReferencePowerChannel3() {
        return referencePowerChannel3;
    }

    public void setReferencePowerChannel3(double referencePowerChannel3) {
        this.referencePowerChannel3 = referencePowerChannel3;
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

    public long getPriorChannel1() {
        return priorChannel1;
    }

    public void setPriorChannel1(long priorChannel1) {
        this.priorChannel1 = priorChannel1;
    }

    public long getPriorChannel2() {
        return priorChannel2;
    }

    public void setPriorChannel2(long priorChannel2) {
        this.priorChannel2 = priorChannel2;
    }

    public long getPriorChannel3() {
        return priorChannel3;
    }

    public void setPriorChannel3(long priorChannel3) {
        this.priorChannel3 = priorChannel3;
    }

    public double getOutputCurrent() {
        return outputCurrent;
    }

    public void setOutputCurrent(double outputCurrent) {
        this.outputCurrent = outputCurrent;
    }

    public double getVoltageForDC() {
        return voltageForDC;
    }

    public void setVoltageForDC(double voltageForDC) {
        this.voltageForDC = voltageForDC;
    }

    public String getPowerChannel1() {
        return powerChannel1;
    }

    public void setPowerChannel1(String powerChannel1) {
        this.powerChannel1 = powerChannel1;
    }

    public String getPowerChannel2() {
        return powerChannel2;
    }

    public void setPowerChannel2(String powerChannel2) {
        this.powerChannel2 = powerChannel2;
    }

    public String getPowerChannel3() {
        return powerChannel3;
    }

    public void setPowerChannel3(String powerChannel3) {
        this.powerChannel3 = powerChannel3;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }
}
