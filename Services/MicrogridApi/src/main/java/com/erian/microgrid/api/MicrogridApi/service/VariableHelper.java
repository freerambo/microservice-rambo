package com.erian.microgrid.api.MicrogridApi.service;
import com.erian.microgrid.api.MicrogridApi.model.Variable;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class VariableHelper {

	public VariableHelper() {}
	
	public static List<Variable> getAllVariables(int deviceId) {
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
	
	protected static Variable processVariableRow(ResultSet rs) throws SQLException {
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
	
	
	public static Variable getVariable(int variableId) {
		return new Variable();
	}
	
	public static Variable addVariable(int deviceId, Variable variable) {
		return new Variable();
	}
	
	public static Variable updateVariable(Variable variable) {
		return variable;
	}
	
	public static Variable removeVariable(int variableId) {
		return new Variable();
	}
}
