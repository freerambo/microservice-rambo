package com.erian.microgrid.api.MicrogridApi.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.erian.microgrid.api.MicrogridApi.dataModel.VariableValueData;
import com.erian.microgrid.api.MicrogridApi.model.VariableValue;

public class VariableValueHelper {

	public static VariableValue addVariableValue(VariableValue varValue) {
		VariableValueData varValueData = Mapper.MapVariableValue(varValue);
		varValueData = addVariableValue(varValueData);
		return Mapper.MapVariableValue(varValueData);
	}
	
	private static VariableValueData addVariableValue(VariableValueData varValueData) {
		Connection c = null;
		PreparedStatement ps=null;
		VariableValueData addedVarValueData = null;
		try {
			c = DatabaseHelper.getConnection();
			String query = "{call add_variable_value(?,?,?)}";
			ps= c.prepareStatement(query);
			ps.setInt(1, varValueData.getVariableId());
			ps.setString(2, varValueData.getTimestamp());
			ps.setDouble(3, varValueData.getValue());
			ResultSet rs = ps.executeQuery();
			/* No need to read back because sql return null
            while (rs.next()) {
            	addedVarValueData = processVariableValueRow(rs);
            }
            */
		}
		catch (Exception e) {
        	e.printStackTrace();
        	//throw new RuntimeException(e);
        	return null;
               
        } finally {
            DatabaseHelper.close(c);
        }
		
		return varValueData;
		//return addedVarValueData;
	}
	
	private static VariableValueData processVariableValueRow(ResultSet rs) throws SQLException {
		VariableValueData varValueData = new VariableValueData();
		varValueData.setVariableId(rs.getInt("variable_id"));
		varValueData.setTimestamp(rs.getTimestamp("data_timestamp").toString());
		varValueData.setValue(rs.getFloat(3));
		return varValueData;
	}
}
