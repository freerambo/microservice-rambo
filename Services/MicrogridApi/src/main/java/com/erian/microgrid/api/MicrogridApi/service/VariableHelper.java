package com.erian.microgrid.api.MicrogridApi.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.erian.microgrid.api.MicrogridApi.model.Variable;

public class VariableService {

	public List<Variable> getAllVariables(int deviceId) {
		List<Variable> list = new ArrayList<>();
		Connection c = null;
		try {
				c = DatabaseHelper.getConnection();
	            Statement s = c.createStatement();
	            String sql = "{call get_variables (" + deviceId + ")}";
	            ResultSet rs = s.executeQuery(sql);
	            while (rs.next()) {
	                list.add(processVariableRow(rs));
	            }
			} catch (SQLException e) {
	            e.printStackTrace();
	            throw new RuntimeException(e);
			} finally {
				DatabaseHelper.close(c);
			}
		return list;
	}
	
	protected Variable processVariableRow(ResultSet rs) throws SQLException {
		Variable variable = new Variable();
		variable.setId(rs.getInt("ID"));
		variable.setDeviceId(rs.getInt("Device_ID"));
		variable.setName(rs.getString("Name"));
		variable.setDescription(rs.getString("Description"));
		variable.setGetCommandId(rs.getInt("get_command_id"));
		variable.setSetCommandId(rs.getInt("set_command_id"));
		variable.setUnit_Id(rs.getInt("unit_id"));
		variable.setUpdatingDuration(rs.getInt("updating_duration"));
		return variable;
	}
	
	
	public Variable getVariable(int deviceId, int variableId) {
		return new Variable();
	}
	
	public Variable addVariable(int deviceId, Variable variable) {
		return new Variable();
	}
	
	public Variable updateVariable(int deviceId, Variable variable) {
		return variable;
	}
	
	public Variable removeVariable(int deviceId, int variableId) {
		return new Variable();
	}
}
