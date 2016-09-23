package com.erian.microgrid.api.MicrogridApi.service;

import java.util.Arrays;

import com.erian.microgrid.api.MicrogridApi.dataModel.BusData;
import com.erian.microgrid.api.MicrogridApi.dataModel.CommandData;
import com.erian.microgrid.api.MicrogridApi.dataModel.CommunicationData;
import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceData;
import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceTypeData;
import com.erian.microgrid.api.MicrogridApi.dataModel.UnitData;
import com.erian.microgrid.api.MicrogridApi.dataModel.VariableData;
import com.erian.microgrid.api.MicrogridApi.dataModel.VariableValueData;
import com.erian.microgrid.api.MicrogridApi.model.Bus;
import com.erian.microgrid.api.MicrogridApi.model.Command;
import com.erian.microgrid.api.MicrogridApi.model.Communication;
import com.erian.microgrid.api.MicrogridApi.model.Device;
import com.erian.microgrid.api.MicrogridApi.model.DeviceType;
import com.erian.microgrid.api.MicrogridApi.model.Unit;
import com.erian.microgrid.api.MicrogridApi.model.Variable;
import com.erian.microgrid.api.MicrogridApi.model.VariableValue;

public final class Mapper {

	public static Device MapDevice(DeviceData deviceData) {
		Device device = new Device();
		device.setID(deviceData.getID());
		device.setTypeID(deviceData.getTypeID());
		device.setTypeName(deviceData.getTypeName());
		device.setClassID(deviceData.getClassID());
		device.setClassName(deviceData.getClassName());
		device.setName(deviceData.getName());
		device.setDescription(deviceData.getDescription());
		device.setMicrogridID(deviceData.getMicrogridID());
		device.setMicrogridName(deviceData.getMicrogridName());
		device.setVendor(deviceData.getVendor());
		device.setModel(deviceData.getModel());
		device.setLocation(deviceData.getLocation());
		device.setIPAdress(deviceData.getIPAdress());
		device.setPortNumber(deviceData.getPortNumber());
		device.setBusID(deviceData.getBusID());
		device.setIsProgrammable(deviceData.getIsProgrammable());
		device.setIsConnected(deviceData.getIsConnected());
		device.setReadCommandID(deviceData.getReadCommandID());
		device.setReadCommand(deviceData.getReadCommand());

		return device;

	}
	
	public static DeviceData MapDevice(Device device) {
		DeviceData deviceData = new DeviceData();
		deviceData.setID(device.getID());
		deviceData.setTypeID(device.getTypeID());
		deviceData.setTypeName(device.getTypeName());
		deviceData.setClassID(device.getClassID());
		deviceData.setClassName(device.getClassName());
		deviceData.setName(device.getName());
		deviceData.setDescription(device.getDescription());
		deviceData.setMicrogridID(device.getMicrogridID());
		deviceData.setMicrogridName(device.getMicrogridName());
		deviceData.setVendor(device.getVendor());
		deviceData.setModel(device.getModel());
		deviceData.setLocation(device.getLocation());
		deviceData.setIPAdress(device.getIPAdress());
		deviceData.setPortNumber(device.getPortNumber());
		deviceData.setBusID(device.getBusID());
		deviceData.setIsProgrammable(device.getIsProgrammable());
		deviceData.setIsConnected(device.getIsConnected());
		deviceData.setReadCommandID(device.getReadCommandID());
		deviceData.setReadCommand(device.getReadCommand());

		return deviceData;
	}	
	
	public static DeviceType MapDeviceType(DeviceTypeData deviceTypeData) {
		DeviceType deviceType = new DeviceType();
		deviceType.setTypeID(deviceTypeData.getTypeID());
		deviceType.setClassID(deviceTypeData.getClassID());
		deviceType.setTypeName(deviceTypeData.getTypeName());
		deviceType.setClassName(deviceTypeData.getClassName());
		deviceType.setTypeDescription(deviceTypeData.getTypeDescription());
		deviceType.setClassDescription(deviceTypeData.getClassDescription());
		
		return deviceType;

	}
	
	public static Bus MapBus(BusData busData) {
		return new Bus(busData.getBusID(), busData.getBusName(), busData.getBusDescription());

	}	
	
	public static Unit MapUnit(UnitData data) {
		Unit unit = new Unit();
		unit.setUnitID(data.getUnitID());
		unit.setUnitName(data.getUnitName());
		unit.setUnitDescription(data.getUnitDescription());
		
		return unit;

	}
	
	
	public static Variable MapVariable(VariableData variableData) {
		Variable variable = new Variable();
		variable.setID(variableData.getID());
		variable.setDeviceID(variableData.getDeviceID());
		variable.setName(variableData.getName());
		variable.setDescription(variableData.getDescription());
		variable.setGetCommandID(variableData.getGetCommandID());
		variable.setSetCommandID(variableData.getSetCommandID());
		variable.setDisplayData(variableData.getDisplayData());
		variable.setDisplayDiagram(variableData.getDisplayDiagram());
		variable.setUnitID(variableData.getUnitID());
		variable.setUnitCode(variableData.getUnitCode());
		variable.setUpdatingDuration(variableData.getUpdatingDuration());
		
		return variable;
	}
	
	public static VariableData MapVariable(Variable variable) {
		VariableData variableData = new VariableData();
		variableData.setID(variable.getID());
		variableData.setDeviceID(variable.getDeviceID());
		variableData.setName(variable.getName());
		variableData.setDescription(variable.getDescription());
		variableData.setGetCommandID(variable.getGetCommandID());
		variableData.setSetCommandID(variable.getSetCommandID());
		variableData.setDisplayData(variable.getDisplayData());
		variableData.setDisplayDiagram(variable.getDisplayDiagram());
		variableData.setUnitID(variable.getUnitID());
		variableData.setUpdatingDuration(variable.getUpdatingDuration());
		
		return variableData;
	}
	
	public static Command MapCommand(CommandData commandData) {
		Command command = new Command();
		command.setID(commandData.getID());
		command.setName(commandData.getName());
		command.setDesription(commandData.getDescription());
		command.setFormatString(commandData.getFormatString());
		command.setDeviceID(commandData.getDeviceID());
		
		return command;
	}
	
	public static CommandData MapCommand(Command command) {
		CommandData commandData = new CommandData();
		commandData.setID(command.getID());
		commandData.setName(command.getName());
		commandData.setDescription(command.getDescription());
		commandData.setFormatString(command.getFormatString());
		commandData.setDeviceID(command.getDeviceID());
		
		return commandData;
	}
	
	public static VariableValue MapVariableValue(VariableValueData variableValueData) {
		VariableValue variableValue = new VariableValue();
		variableValue.setVariableId(variableValueData.getVariableId());
		variableValue.setTimestamp(variableValueData.getTimestamp());
		variableValue.setValue(variableValueData.getValue());
		return variableValue;
	}
	
	public static VariableValueData MapVariableValue(VariableValue variableValue) {
		VariableValueData variableValueData = new VariableValueData();
		variableValueData.setVariableId(variableValue.getVariableId());
		variableValueData.setTimestamp(variableValue.getTimestamp());
		variableValueData.setValue(variableValue.getValue());
		return variableValueData;
	}
	
	public static Communication MapCommunication(CommunicationData data) {
		Communication res = new Communication();
		
		res.commandFormatString = data.commandFormatString;
		res.IPAdress = data.IPAdress;
		res.portNumber = data.portNumber;
		res.deviceId = data.deviceId;
		res.commandId = data.commandId;
		
		res.variableIds = Arrays.asList(data.variableIds.split("\\s*,\\s*")); 
		res.variableNames = Arrays.asList(data.variableNames.split("\\s*,\\s*")); 
		return res;

	}
}