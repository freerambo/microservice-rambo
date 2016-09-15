package com.erian.microgrid.api.MicrogridApi.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.erian.microgrid.api.MicrogridApi.dataModel.CommandData;
import com.erian.microgrid.api.MicrogridApi.model.Command;

public class CommandHelper {
	
	public static List<Command> getAllCommands(int deviceId) {
		List<CommandData> commandList = getAllCommandsData(deviceId);
		List<Command> res = new ArrayList<>();
		for (CommandData var: commandList ) {
			res.add(Mapper.MapCommand(var));
		}
		
		return res;
	}
	
	public static List<CommandData> getAllCommandsData(int deviceId) {
		List<CommandData> list = new ArrayList<>();
		Connection c = null;
		try {
			c = DatabaseHelper.getConnection();
			Statement s = c.createStatement();
			String sql = "{call get_commands (" + deviceId + ")}";
			ResultSet rs = s.executeQuery(sql);
			while (rs.next()) {
				list.add(processCommandRow(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		return list;
	}
	
	protected static CommandData processCommandRow(ResultSet rs) throws SQLException {
		CommandData commandData = new CommandData();
		commandData.setID(rs.getInt("ID"));
		commandData.setName(rs.getString("Name"));
		commandData.setDescription(rs.getString("Description"));
		commandData.setFormatString(rs.getString("FormatString"));
		commandData.setDeviceID(rs.getInt("Device_ID"));

		return commandData;
	}
}
