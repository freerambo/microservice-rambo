package com.erian.microgrid.api.MicrogridApi.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceTypeData;
import com.erian.microgrid.api.MicrogridApi.model.DeviceType;

public class StaticDataHelper
{
	// private Connection c = null;

	public static List<DeviceType> GetDeviceTypes(){
		List<DeviceType> list = new ArrayList();
		Connection c = null;
		try {
				c = DatabaseHelper.getConnection();
	            Statement s = c.createStatement();
	            String sql = "{call get_device_types ()}";
	            ResultSet rs = s.executeQuery(sql);
	            while (rs.next()) {
	                list.add(Mapper.MapDeviceType(processVariableRow(rs)));
	            }
			} catch (SQLException e) {
	            e.printStackTrace();
	            throw new RuntimeException(e);
			} finally {
				DatabaseHelper.close(c);
			}
		return list;
	}
	
	protected static DeviceTypeData processVariableRow(ResultSet rs) throws SQLException {
		DeviceTypeData deviceType = new DeviceTypeData();
		deviceType.setTypeID(rs.getInt("TypeID"));
		deviceType.setClassID(rs.getInt("ClassID"));
		deviceType.setTypeName(rs.getString("TypeName"));
		deviceType.setTypeDescription(rs.getString("TypeDescription"));
		deviceType.setClassName(rs.getString("ClassName"));
		deviceType.setClassDescription(rs.getString("ClassDescription"));
		return deviceType;
	}

}
