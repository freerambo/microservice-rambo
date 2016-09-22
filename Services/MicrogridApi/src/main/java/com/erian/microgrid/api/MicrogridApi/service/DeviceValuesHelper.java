package com.erian.microgrid.api.MicrogridApi.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceValuesData;

public class DeviceValuesHelper {
	
	public static List<DeviceValuesData> getDeviceValues(int deviceId) {
		List<DeviceValuesData> list = new ArrayList<>();
		Connection c = null;
		
		try {
			c = DatabaseHelper.getConnection();
            Statement s = c.createStatement();
            String sql = "{call get_device_data (" + deviceId + ",null,null " + ")}";
            ResultSet rs = s.executeQuery(sql);
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnNumber = rsmd.getColumnCount();
            while (rs.next()) {
            	DeviceValuesData deviceValues = new DeviceValuesData();
            	for (int i=1 ; i <= columnNumber; i++) {
            		deviceValues.put(rsmd.getColumnName(i), rs.getString(i));
            		
            	}
            	list.add(deviceValues);
            }
		} catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		
		return list;
	}
	
	public static List<DeviceValuesData> getDeviceValuesWithDatesString(int deviceId, String startDate, String endDate) {
		List<DeviceValuesData> list = new ArrayList<>();
		Connection c = null;
		
		try {
			c = DatabaseHelper.getConnection();
            Statement s = c.createStatement();
            String sql = "{call get_device_data (" + deviceId + "," + startDate + "," + endDate + ")}";
            System.out.println("sql:" + sql);
            ResultSet rs = s.executeQuery(sql);
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnNumber = rsmd.getColumnCount();
            while (rs.next()) {
            	DeviceValuesData deviceValues = new DeviceValuesData();
            	for (int i=1 ; i <= columnNumber; i++) {
            		deviceValues.put(rsmd.getColumnName(i), rs.getString(i));
            		
            	}
            	list.add(deviceValues);
            }
		} catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
		} finally {
			DatabaseHelper.close(c);
		}
		
		return list;
	}

}
