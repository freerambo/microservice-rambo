package com.erian.ict.microgrid.domain;

import java.util.Date;

/**
 * Created by nhdevika on 2/14/2017.
 */

public class BICConverter {

    private Date updatedTimestamp;

    private String deviceId;

    private double voltagePhaseAForAC;

    private double voltagePhaseBForAC;

    private double voltagePhaseCForAC;

    private double currentPhaseAForAC;

    private double currentPhaseBForAC;

    private double currentPhaseCForAC;

    private double frequencyForAC;

    private double voltageForDC;

    private double currentForDC;

    private double refVoltageForDC;

    private double refVoltageForAC;

    private double refFrequencyForAC;

    private double droopVPCoefficientForDC;

    private double droopFPCoefficientForAC;

    private double droopVQCoefficientForAC;

    private double outputPowerForDC;

    private double outputActivePowerForAC;

    private double outputReactivePowerForAC;

    private double environmentTemperature;

    private double heatSinkTemperature;

    private double deviceTemperature;

    private long relayStatusForAC;

    private long relayStatusForDC;

    private long faultMessage;

    private long isolateStatus;

    private long mode;

    private long operationStatus;

    private long activePowerReference;

    private long reactivePowerReference;

    private long reactivePowerReferenceRec;

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

    public double getVoltagePhaseAForAC() {
        return voltagePhaseAForAC;
    }

    public void setVoltagePhaseAForAC(double voltagePhaseAForAC) {
        this.voltagePhaseAForAC = voltagePhaseAForAC;
    }

    public double getVoltagePhaseBForAC() {
        return voltagePhaseBForAC;
    }

    public void setVoltagePhaseBForAC(double voltagePhaseBForAC) {
        this.voltagePhaseBForAC = voltagePhaseBForAC;
    }

    public double getVoltagePhaseCForAC() {
        return voltagePhaseCForAC;
    }

    public void setVoltagePhaseCForAC(double voltagePhaseCForAC) {
        this.voltagePhaseCForAC = voltagePhaseCForAC;
    }

    public double getCurrentPhaseAForAC() {
        return currentPhaseAForAC;
    }

    public void setCurrentPhaseAForAC(double currentPhaseAForAC) {
        this.currentPhaseAForAC = currentPhaseAForAC;
    }

    public double getCurrentPhaseBForAC() {
        return currentPhaseBForAC;
    }

    public void setCurrentPhaseBForAC(double currentPhaseBForAC) {
        this.currentPhaseBForAC = currentPhaseBForAC;
    }

    public double getCurrentPhaseCForAC() {
        return currentPhaseCForAC;
    }

    public void setCurrentPhaseCForAC(double currentPhaseCForAC) {
        this.currentPhaseCForAC = currentPhaseCForAC;
    }

    public double getFrequencyForAC() {
        return frequencyForAC;
    }

    public void setFrequencyForAC(double frequencyForAC) {
        this.frequencyForAC = frequencyForAC;
    }

    public double getVoltageForDC() {
        return voltageForDC;
    }

    public void setVoltageForDC(double voltageForDC) {
        this.voltageForDC = voltageForDC;
    }

    public double getCurrentForDC() {
        return currentForDC;
    }

    public void setCurrentForDC(double currentForDC) {
        this.currentForDC = currentForDC;
    }

    public double getRefVoltageForDC() {
        return refVoltageForDC;
    }

    public void setRefVoltageForDC(double refVoltageForDC) {
        this.refVoltageForDC = refVoltageForDC;
    }

    public double getRefVoltageForAC() {
        return refVoltageForAC;
    }

    public void setRefVoltageForAC(double refVoltageForAC) {
        this.refVoltageForAC = refVoltageForAC;
    }

    public double getRefFrequencyForAC() {
        return refFrequencyForAC;
    }

    public void setRefFrequencyForAC(double refFrequencyForAC) {
        this.refFrequencyForAC = refFrequencyForAC;
    }

    public double getDroopVPCoefficientForDC() {
        return droopVPCoefficientForDC;
    }

    public void setDroopVPCoefficientForDC(double droopVPCoefficientForDC) {
        this.droopVPCoefficientForDC = droopVPCoefficientForDC;
    }

    public double getDroopFPCoefficientForAC() {
        return droopFPCoefficientForAC;
    }

    public void setDroopFPCoefficientForAC(double droopFPCoefficientForAC) {
        this.droopFPCoefficientForAC = droopFPCoefficientForAC;
    }

    public double getDroopVQCoefficientForAC() {
        return droopVQCoefficientForAC;
    }

    public void setDroopVQCoefficientForAC(double droopVQCoefficientForAC) {
        this.droopVQCoefficientForAC = droopVQCoefficientForAC;
    }

    public double getOutputPowerForDC() {
        return outputPowerForDC;
    }

    public void setOutputPowerForDC(double outputPowerForDC) {
        this.outputPowerForDC = outputPowerForDC;
    }

    public double getOutputActivePowerForAC() {
        return outputActivePowerForAC;
    }

    public void setOutputActivePowerForAC(double outputActivePowerForAC) {
        this.outputActivePowerForAC = outputActivePowerForAC;
    }

    public double getOutputReactivePowerForAC() {
        return outputReactivePowerForAC;
    }

    public void setOutputReactivePowerForAC(double outputReactivePowerForAC) {
        this.outputReactivePowerForAC = outputReactivePowerForAC;
    }

    public double getEnvironmentTemperature() {
        return environmentTemperature;
    }

    public void setEnvironmentTemperature(double environmentTemperature) {
        this.environmentTemperature = environmentTemperature;
    }

    public double getHeatSinkTemperature() {
        return heatSinkTemperature;
    }

    public void setHeatSinkTemperature(double heatSinkTemperature) {
        this.heatSinkTemperature = heatSinkTemperature;
    }

    public double getDeviceTemperature() {
        return deviceTemperature;
    }

    public void setDeviceTemperature(double deviceTemperature) {
        this.deviceTemperature = deviceTemperature;
    }

    public long getRelayStatusForAC() {
        return relayStatusForAC;
    }

    public void setRelayStatusForAC(long relayStatusForAC) {
        this.relayStatusForAC = relayStatusForAC;
    }

    public long getRelayStatusForDC() {
        return relayStatusForDC;
    }

    public void setRelayStatusForDC(long relayStatusForDC) {
        this.relayStatusForDC = relayStatusForDC;
    }

    public long getFaultMessage() {
        return faultMessage;
    }

    public void setFaultMessage(long faultMessage) {
        this.faultMessage = faultMessage;
    }

    public long getIsolateStatus() {
        return isolateStatus;
    }

    public void setIsolateStatus(long isolateStatus) {
        this.isolateStatus = isolateStatus;
    }

    public long getMode() {
        return mode;
    }

    public void setMode(long mode) {
        this.mode = mode;
    }

    public long getOperationStatus() {
        return operationStatus;
    }

    public void setOperationStatus(long operationStatus) {
        this.operationStatus = operationStatus;
    }

    public long getActivePowerReference() {
        return activePowerReference;
    }

    public void setActivePowerReference(long activePowerReference) {
        this.activePowerReference = activePowerReference;
    }

    public long getReactivePowerReference() {
        return reactivePowerReference;
    }

    public void setReactivePowerReference(long reactivePowerReference) {
        this.reactivePowerReference = reactivePowerReference;
    }

    public long getReactivePowerReferenceRec() {
        return reactivePowerReferenceRec;
    }

    public void setReactivePowerReferenceRec(long reactivePowerReferenceRec) {
        this.reactivePowerReferenceRec = reactivePowerReferenceRec;
    }
}
