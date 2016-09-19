package com.erian.microgrid.api.MicrogridApi.service;
import com.erian.microgrid.api.MicrogridApi.dataModel.VariableData;
import com.erian.microgrid.api.MicrogridApi.model.Variable;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
	
	private static List<VariableData> getAllVariablesData(int deviceId) {
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
		return Mapper.MapVariable(GetVariableData(variableId));
	}
	
	protected static VariableData GetVariableData(int variableId) {
		VariableData res = null;
		Connection c  = null;
 		try {
 			c  = DatabaseHelper.getConnection();
 			Statement s = c.createStatement();
 			String sql = "{call get_variable (" + variableId + ")}";
 			ResultSet rs = s.executeQuery(sql);
 			rs.next();
 			res = processVariableRow(rs);
 		}
 		catch (SQLException e) {
 			e.printStackTrace();
 			throw new RuntimeException(e);
 		} finally {
 			DatabaseHelper.close(c);
 		}
 		return res;
	    
	}
	
	public static Variable addNewVariable(int deviceId, Variable newVariable) {
		VariableData variableData = Mapper.MapVariable(newVariable);
		addNewVariableData(deviceId, variableData);
		return Mapper.MapVariable(variableData);
	}
	
	public static Variable updateVariable(Variable variable) {
		VariableData variableData = Mapper.MapVariable(variable);
		updateVariable(variableData);
		return Mapper.MapVariable(variableData);
	}
	
	private static VariableData addNewVariableData(int deviceId, VariableData newVariable) {
		Connection c = null;
		PreparedStatement ps=null;
		VariableData variableAdded = null;
		try {
			c = DatabaseHelper.getConnection();
            String query = "{call add_variable(?,?,?,?,?)}";
            ps= c.prepareStatement(query);
            ps.setInt(1, newVariable.getDeviceID());
            ps.setString(2, newVariable.getName());
            ps.setString(3, newVariable.getDescription());
            ps.setInt(4, newVariable.getUnitID());
            ps.setInt(5, newVariable.getUpdatingDuration());
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	variableAdded = processVariableRow(rs);
            }
       	}
        catch (Exception e) {
        	e.printStackTrace();
        	throw new RuntimeException(e);
               
        } finally {
            DatabaseHelper.close(c);
        }
		return variableAdded;
	}
	
	public static VariableData updateVariable(VariableData variable) {
		Connection c = null;
		PreparedStatement ps=null;
		VariableData variableUpdated = null;
		try {
			c = DatabaseHelper.getConnection();
            String query = "{call update_variable(?,?,?,?,?,?,?)}";
            ps= c.prepareStatement(query);
            ps.setInt(1, variable.getID());
            ps.setString(2, variable.getName());
            ps.setString(3, variable.getDescription());
            ps.setInt(4, variable.getUnitID());
            ps.setInt(5, variable.getUpdatingDuration());
            ps.setInt(6, variable.getSetCommandID());
            ps.setInt(7, variable.getGetCommandID());
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
            	variableUpdated = processVariableRow(rs);
            }
       	}
        catch (Exception e) {
        	e.printStackTrace();
        	throw new RuntimeException(e);
               
        } finally {
            DatabaseHelper.close(c);
        }
		return variableUpdated;
	}
	
	public static Variable removeVariable(int variableId) {
		return new Variable();
	}
}
