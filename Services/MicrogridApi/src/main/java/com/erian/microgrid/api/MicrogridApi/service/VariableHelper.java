package com.erian.microgrid.api.MicrogridApi.service;
import com.erian.microgrid.api.MicrogridApi.dataModel.VariableData;
import com.erian.microgrid.api.MicrogridApi.model.Variable;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class VariableHelper {

	public static List<Variable> getAllVariables(int deviceId) {
		List<VariableData> variableList = getAllVariablesData(deviceId);
		List<Variable> res = new ArrayList<>();
		for (VariableData var: variableList ) {
			res.add(Mapper.MapVariable(var));
		}
		
		return res;
	}
	
	public static List<VariableData> getAllVariablesData(int deviceId) {
		List<VariableData> list = new ArrayList<>();
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
	
	protected static VariableData processVariableRow(ResultSet rs) throws SQLException {
		VariableData variableData = new VariableData();
		variableData.setID(rs.getInt("ID"));
		variableData.setDeviceID(rs.getInt("Device_ID"));
		variableData.setName(rs.getString("Name"));
		variableData.setDescription(rs.getString("Description"));
		variableData.setGetCommandID(rs.getInt("Get_Command_ID"));
		variableData.setSetCommandID(rs.getInt("Set_Command_ID"));
		variableData.setUnitID(rs.getInt("Unit_ID"));
		variableData.setUpdatingDuration(rs.getInt("Updating_Duration"));
		return variableData;
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
