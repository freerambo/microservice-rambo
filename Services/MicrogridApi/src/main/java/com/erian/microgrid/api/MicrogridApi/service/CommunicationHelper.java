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

	public static Communication getReadCommand(int variableId) {
		
		return Mapper.MapCommunication(getReadCommandData(variableId));
	}

	public static CommunicationData getReadCommandData(int variableId) {
		CommunicationData res = null;
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
		return res;
	}

	protected static CommunicationData processResultRow(ResultSet rs) throws SQLException {
		CommunicationData commData = new CommunicationData();
		
		commData.variableId = rs.getInt("variableId");
		commData.variableName = rs.getString("variableName");
		commData.commandFormatString = rs.getString("commandFormatString");
		commData.IPAdress = rs.getString("IPAdress");
		commData.portNumber = rs.getString("portNumber");;
		commData.deviceId = rs.getInt("deviceId");;
		commData.commandId = rs.getInt("commandId");;

		return commData;
	}

}
