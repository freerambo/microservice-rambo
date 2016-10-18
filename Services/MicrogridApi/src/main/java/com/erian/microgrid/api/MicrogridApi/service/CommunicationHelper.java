package com.erian.microgrid.api.MicrogridApi.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.erian.microgrid.api.MicrogridApi.dataModel.CommandData;
import com.erian.microgrid.api.MicrogridApi.dataModel.CommunicationData;
import com.erian.microgrid.api.MicrogridApi.model.Command;
import com.erian.microgrid.api.MicrogridApi.model.Communication;

public class CommunicationHelper {

	public static List<Communication> getAllReadCommands() {
		List<CommunicationData> commandList = getAllReadCommandsData();
		List<Communication> res = new ArrayList<>();
		for (CommunicationData var : commandList) {
			res.add(Mapper.MapCommunication(var));
		}
		return res;
	}
	
	public static Communication getReadCommand(int variableId) {
		
		return Mapper.MapCommunication(getReadCommandData(variableId));
	}

	public static List<CommunicationData> getAllReadCommandsData() {
		List<CommunicationData> list = new ArrayList<>();
		Connection c = null;
		try {
			c = DatabaseHelper.getConnection();
			Statement s = c.createStatement();
			String sql = "{call get_read_commands ()}";
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
				list.add(processResultRow(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		return list;
	}
	
	public static CommunicationData getReadCommandData(int variableId) {
		throw new UnsupportedOperationException("getReadCommandData not implemented");
		/*CommunicationData res = null;
		Connection c = null;
		try {
			c = DatabaseHelper.getConnection();
			Statement s = c.createStatement();
			String sql = "{call get_read_command (" + variableId + ")}";
			ResultSet rs = s.executeQuery(sql);
            rs.next();
            res = processResultRow(rs);	
            
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		return res;*/
	}

	protected static CommunicationData processResultRow(ResultSet rs) throws SQLException {
		CommunicationData commData = new CommunicationData();
		
		commData.variableIds = rs.getString("variableIds");
		commData.variableNames = rs.getString("variableNames");
		commData.commandFormatString = rs.getString("commandFormatString");
		commData.IPAdress = rs.getString("IPAdress");
		commData.portNumber = rs.getString("portNumber");;
		commData.deviceId = rs.getInt("deviceId");;
		commData.commandId = rs.getInt("commandId");;
		commData.commandTypeId = rs.getInt("commandTypeId");
		commData.commandTypeName = rs.getString("commandTypeName");
		commData.protocolId = rs.getInt("protocolId");
		commData.protocolName = rs.getString("protocolName");

		return commData;
	}

}
