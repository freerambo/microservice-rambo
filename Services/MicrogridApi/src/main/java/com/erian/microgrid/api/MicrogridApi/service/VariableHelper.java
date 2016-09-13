package com.erian.microgrid.api.MicrogridApi.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.erian.microgrid.api.MicrogridApi.model.Variable;

public class VariableHelper {

	private Connection c = null;
	
	public VariableHelper() {}
	
	public List<Variable> getAllVariables(int deviceId) {
		List<Variable> list = new ArrayList<>();
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
		variable.setID(rs.getInt("ID"));
		variable.setDeviceID(rs.getInt("DeviceID"));
		variable.setName(rs.getString("Name"));
		variable.setDescription(rs.getString("Description"));
		variable.setGetCommandID(rs.getInt("GetCommandID"));
		variable.setSetCommandID(rs.getInt("SetCommandID"));
		variable.setUnitID(rs.getInt("UnitID"));
		variable.setUpdatingDuration(rs.getInt("UpdatingDuration"));
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
