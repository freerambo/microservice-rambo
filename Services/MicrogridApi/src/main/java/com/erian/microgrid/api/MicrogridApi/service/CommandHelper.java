package com.erian.microgrid.api.MicrogridApi.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.erian.microgrid.api.MicrogridApi.dataModel.CommandData;
import com.erian.microgrid.api.MicrogridApi.model.Command;

public class CommandHelper {

	public static List<Command> getAllCommands(int deviceId) {
		List<CommandData> commandList = getAllCommandsData(deviceId);
		List<Command> res = new ArrayList<>();
		for (CommandData var : commandList) {
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

	public static Command getCommand(int id) {
		CommandData res = null;
		Connection c = null;
		try {
			c = DatabaseHelper.getConnection();
			Statement s = c.createStatement();
			String sql = "{call get_command (" + id + ")}";
			ResultSet rs = s.executeQuery(sql);
			rs.next();
            res = processCommandRow(rs);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		return Mapper.MapCommand(res);
	}
	
	protected static CommandData processCommandRow(ResultSet rs) throws SQLException {
		CommandData commandData = new CommandData();
		commandData.setID(rs.getInt("id"));
		commandData.setName(rs.getString("name"));
		commandData.setDescription(rs.getString("description"));
		commandData.setFormatString(rs.getString("formatString"));
		commandData.setDeviceID(rs.getInt("deviceID"));
		commandData.setCommandTypeID(rs.getInt("commandTypeId"));
		commandData.setCommandTypeName(rs.getString("commandTypeName"));
		commandData.setProtocolID(rs.getInt("protocolId"));
		commandData.setProtocolName(rs.getString("protocolName"));

		return commandData;
	}

	public static Command addNewCommand(int deviceId, Command command) {
		CommandData commandData = Mapper.MapCommand(command);
		commandData = addNewCommandData(deviceId, commandData);
		return Mapper.MapCommand(commandData);
	}
	
	private static CommandData addNewCommandData(int deviceId, CommandData newCommand) {
		Connection c = null;
		PreparedStatement ps = null;
		CommandData commandAdded = null;
		try {
			c = DatabaseHelper.getConnection();
			String query = "{call add_command(?,?,?,?,?,?,?,?)}";
			ps = c.prepareStatement(query);
			ps.setInt(1, newCommand.getDeviceID());
			ps.setString(2, newCommand.getName());
			ps.setString(3, newCommand.getDescription());
			ps.setString(4, newCommand.getFormatString());
			ps.setInt(5, newCommand.getProtocolID());
			ps.setInt(6, newCommand.getCommandTypeID());
			ps.setString(7, newCommand.getInputVariables());
			ps.setString(8, newCommand.getOutputVariables());

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				commandAdded = processCommandRow(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);

		} finally {
			DatabaseHelper.close(c);
		}
		return commandAdded;

	}

	public static Command updateCommand(Command command) {
		CommandData commandData = Mapper.MapCommand(command);
		commandData = updateCommandData(commandData);
		return Mapper.MapCommand(commandData);
	}
	
	private static CommandData updateCommandData(CommandData command) {
		Connection c = null;
		PreparedStatement ps = null;
		CommandData commandUpdated = null;
		try {
			c = DatabaseHelper.getConnection();
			String query = "{call update_command(?,?,?,?,?,?,?,?)}";
			ps = c.prepareStatement(query);
			ps.setInt(1, command.getID());
			ps.setString(2, command.getName());
			ps.setString(3, command.getDescription());
			ps.setString(4, command.getFormatString());
			ps.setInt(5, command.getProtocolID());
			ps.setInt(6, command.getCommandTypeID());
			ps.setString(7, command.getInputVariables());
			ps.setString(8, command.getOutputVariables());

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				commandUpdated = processCommandRow(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);

		} finally {
			DatabaseHelper.close(c);
		}
		return commandUpdated;
	}
	
	public static Map<String, String> getSwitchOff(int deviceId, int variableId) {
		Map<String, String> map = new HashMap<String, String>();
		Connection c = null;
		
		try {
			c = DatabaseHelper.getConnection();
            Statement s = c.createStatement();
            String sql = "{call get_switch_OFF_command (" + deviceId + "," + variableId + ")}";
            ResultSet rs = s.executeQuery(sql);
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnNumber = rsmd.getColumnCount();
            while (rs.next()) {
            	for (int i=1 ; i <= columnNumber; i++) {
            		map.put(rsmd.getColumnLabel(i), rs.getString(i));
            	}
            }
            
		} catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		return map;
	}
	
	public static Map<String, String> getSwitchOn(int deviceId, int variableId) {
		Map<String, String> map = new HashMap<String, String>();
		Connection c = null;
		
		try {
			c = DatabaseHelper.getConnection();
            Statement s = c.createStatement();
            String sql = "{call get_switch_ON_command (" + deviceId + "," + variableId + ")}";
            ResultSet rs = s.executeQuery(sql);
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnNumber = rsmd.getColumnCount();
            while (rs.next()) {
            	for (int i=1 ; i <= columnNumber; i++) {
            		map.put(rsmd.getColumnLabel(i), rs.getString(i));
            	}
            }
            
		} catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		return map;
	}
}
