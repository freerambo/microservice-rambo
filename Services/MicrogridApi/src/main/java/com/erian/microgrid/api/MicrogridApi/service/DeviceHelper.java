package com.erian.microgrid.api.MicrogridApi.service;

import com.erian.microgrid.api.MicrogridApi.dataModel.DeviceData;
import com.erian.microgrid.api.MicrogridApi.model.Device;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DeviceHelper
{
	private Connection c = null;

	public List<Device> GetAllDevices(){
		List<DeviceData> dataList = GetAllDeviceData();
		List<Device> res = new ArrayList<>();
		// TODO - fix 'error: lambda expressions are not supported in -source 1.7' and use lambda-expression instead of loop
		// dataList.forEach( (data) -> res.add(Mapper.MapDevice(data)));
		for (DeviceData data: dataList ) {
			res.add(Mapper.MapDevice(data));
		}
		
		return res;
	}
	
	public Device AddNewDevice(Device newDevice) {	       
	           return Mapper.MapDevice(AddNewDevice(Mapper.MapDevice(newDevice)));
	}
	
 	protected List<DeviceData> GetAllDeviceData(){
		List<DeviceData> list = new ArrayList<>();
 		try {
	            c = DatabaseHelper.getConnection();
	            Statement s = c.createStatement();
	            String sql = "{call get_devices ()}";
	            ResultSet rs = s.executeQuery(sql);
	            while (rs.next()) {
	                list.add(processDeviceRow(rs));
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	            throw new RuntimeException(e);
			} finally {
				DatabaseHelper.close(c);
			}
	        return list;
	    }

	protected DeviceData AddNewDevice (DeviceData newDevice)
	{
		Connection c = null;
	       
	       PreparedStatement ps=null;
	       try {
	           c = DatabaseHelper.getConnection();
	           String query = "{call add_device(?,?,?,?,?,?,?,?,?,?,?,?)}";
	           ps= c.prepareStatement(query);
	           ps.setInt(1, newDevice.getTypeID());
	           ps.setString(2, newDevice.getName());
	           ps.setString(3, newDevice.getDescription());
	           ps.setInt(4, newDevice.getMicrogridID());
	           ps.setString(5, newDevice.getVendor());
	           ps.setString(6, newDevice.getModel());
	           ps.setString(7, newDevice.getLocation());
	           ps.setString(8, newDevice.getIPAdress());
	           ps.setString(9, newDevice.getPortNumber());
	           ps.setInt(10, newDevice.getBusID());
	           ps.setInt(11, newDevice.getIsProgrammable());
	           ps.setInt(12, newDevice.getIsConnected());
	           ps.executeQuery();
	       }
	           catch (Exception e) {
	               e.printStackTrace();
	               throw new RuntimeException(e);
	               
	           } finally {
	               DatabaseHelper.close(c);
	           }
	       return newDevice;  // TODO - return inserted device from insert statement and return it here including ID
	}
	
	protected DeviceData processDeviceRow(ResultSet rs) throws SQLException {
    	DeviceData  deviceData = new DeviceData();
    	deviceData.setID(rs.getInt("ID"));
    	deviceData.setTypeID(rs.getInt("TypeID"));
    	deviceData.setTypeName(rs.getString("TypeName"));
    	deviceData.setClassID(rs.getInt("ClassID"));
    	deviceData.setClassName(rs.getString("ClassName"));
    	deviceData.setName(rs.getString("Name"));
    	deviceData.setDescription(rs.getString("Description"));
    	deviceData.setMicrogridID(rs.getInt("MicrogridID"));
    	deviceData.setMicrogridName(rs.getString("MicrogridName"));
    	deviceData.setVendor(rs.getString("Vendor"));
    	deviceData.setModel(rs.getString("Model"));
    	deviceData.setLocation(rs.getString("Location"));
    	deviceData.setIPAdress(rs.getString("IPAdress"));
    	deviceData.setPortNumber(rs.getString("PortNumber"));
    	deviceData.setBusID(rs.getInt("BusID"));
    	deviceData.setIsProgrammable(rs.getInt("IsProgrammable"));
    	deviceData.setIsConnected(rs.getInt("IsConnected"));
    	
    	return deviceData;
   }	

}
